import 'dart:io';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

class ScraperService {
  ScraperService._privateConstructor();
  static final ScraperService _instance = ScraperService._privateConstructor();
  static ScraperService get instance => _instance;

  bool isRescraping = false; // General lock for any major scraping operation
  final RepackService _repackService = RepackService.instance;
  final ValueNotifier<double> loadingProgress = ValueNotifier<double>(
    0.0,
  ); // 0.0 to 1.0

  // Renamed from rescrapeNewRepacks for clarity
  Future<void> _scrapeAndSaveNewRepacks({
    Function(int, int)? onProgress,
  }) async {
    _repackService.newRepacks.clear(); // Clear in-memory list first
    _repackService.newRepacks = await scrapeNewRepacks(
      onProgress: onProgress ?? (i, e) {},
    );
    await _repackService.saveNewRepackList();
  }

  // Renamed from rescrapePopularRepacks for clarity
  Future<void> _scrapeAndSavePopularRepacks({
    Function(int, int)? onProgress,
  }) async {
    _repackService.popularRepacks.clear(); // Clear in-memory list first
    _repackService.popularRepacks = await scrapePopularRepacks(
      onProgress: onProgress ?? (i, e) {},
    );
    await _repackService.savePopularRepackList();
  }

  Future<void> rescrapeNewAndPopularRepacks() async {
    if (isRescraping) {
      debugPrint("Rescrape already in progress. Skipping.");
      return;
    }
    isRescraping = true;
    loadingProgress.value = 0.0; // Reset progress

    try {
      debugPrint("Rescraping new repacks...");
      await _scrapeAndSaveNewRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            loadingProgress.value = (current / total) * 0.5; // 50% for new
          }
        },
      );
      debugPrint("New repacks rescraped and saved.");

      debugPrint("Rescraping popular repacks...");
      await _scrapeAndSavePopularRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            loadingProgress.value =
                0.5 + (current / total) * 0.5; // 50% for popular
          }
        },
      );
      debugPrint("Popular repacks rescraped and saved.");

      // _repackService.notifyListeners(); // Individual save methods already notify
    } catch (e) {
      debugPrint("Error during rescrapeNewAndPopularRepacks: $e");
      rethrow;
    } finally {
      isRescraping = false;
      loadingProgress.value = 0.0; // Reset progress fully
    }
  }

  Future<void> rescrapeAllRepacksNames() async {
    // This is if only names are needed separately
    if (isRescraping) return;
    isRescraping = true;
    loadingProgress.value = 0.0;
    try {
      _repackService.allRepacksNames = await scrapeAllRepacksNames(
        onProgress: (current, total) {
          if (total > 0) loadingProgress.value = current / total;
        },
      );
      await _repackService.saveAllRepackList();
    } finally {
      isRescraping = false;
      loadingProgress.value = 0.0;
    }
  }

  Future<bool> checkImageUrl(String url) async {
    if (url.isEmpty) return false;
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      // debugPrint("Failed to check image URL $url: $e");
      return false;
    }
  }

  Future<Repack> deleteInvalidScreenshots(Repack repack) async {
    final List<String> validScreenshots = [];
    if (!await checkImageUrl(repack.cover)) {
      repack.cover =
          'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true';
    }
    for (int i = 0; i < repack.screenshots.length; i++) {
      if (await checkImageUrl(repack.screenshots[i])) {
        validScreenshots.add(repack.screenshots[i]);
      }
    }
    repack.screenshots = validScreenshots;
    return repack;
  }

  Future<List<Repack>> scrapeEveryRepack({
    // This scrapes all based on allRepacksNames
    required Function(int, int) onProgress,
  }) async {
    List<Repack> repacks = [];
    final allNamesEntries = _repackService.allRepacksNames.entries.toList();
    int totalToScrape = allNamesEntries.length;

    for (int i = 0; i < totalToScrape; i++) {
      var entry = allNamesEntries[i];
      try {
        final repack = await scrapeRepackFromSearch(entry.value);
        repacks.add(repack);
      } catch (e) {
        debugPrint('Failed to scrape repack: ${entry.key}, error: $e');
        // Optionally add to failedRepacks here too, if this func is used standalone
        // await _repackService.saveFailedRepack(entry.key, entry.value);
      }
      // loadingProgress.value is managed by forceRescrapeEverything if called from there
      // If called standalone, it should update loadingProgress.value
      // For now, assume it's part of a larger flow or the caller manages global progress
      onProgress(i + 1, totalToScrape);
    }
    return repacks;
  }

  Future<void> scrapeMissingRepacks({Function(int, int)? onProgress}) async {
    final everyRepackUrls =
        _repackService.everyRepack.map((repack) => repack.url).toSet();
    final allRepackNamesCopy = Map<String, String>.from(
      _repackService.allRepacksNames,
    ); // Copy for iteration safety

    // Filter out already scraped URLs and URLs present in failedRepacks
    final Set<String> urlsToPotentiallyScrape =
        allRepackNamesCopy.values.toSet();
    urlsToPotentiallyScrape.removeAll(everyRepackUrls);
    urlsToPotentiallyScrape.removeAll(
      _repackService.failedRepacks.values.toSet(),
    );

    final List<String> missingRepackUrls = urlsToPotentiallyScrape.toList();

    int totalMissing = missingRepackUrls.length;
    if (totalMissing == 0) {
      debugPrint("No missing repacks to scrape.");
      loadingProgress.value = 1.0; // Indicate completion
      onProgress?.call(0, 0);
      _repackService
          .notifyListeners(); // Ensure UI updates if nothing was to scrape
      return;
    }

    debugPrint("Found $totalMissing missing repacks to scrape.");
    loadingProgress.value = 0.0; // Reset for this specific operation

    for (int i = 0; i < totalMissing; i++) {
      final url = missingRepackUrls[i];
      final title =
          allRepackNamesCopy.entries
              .firstWhere(
                (entry) => entry.value == url,
                orElse: () => MapEntry("Unknown Title for $url", url),
              )
              .key;
      try {
        final repack = await scrapeRepackFromSearch(url);
        // Add to in-memory list before saving, ensure no duplicates if called multiple times
        if (!_repackService.everyRepack.any((r) => r.url == repack.url)) {
          _repackService.everyRepack.add(repack);
          await _repackService.saveSingleEveryRepack(
            repack,
          ); // This also notifies
        }
      } catch (e) {
        debugPrint('Failed to scrape repack: $url ($title), error: $e');
        await _repackService.saveFailedRepack(title, url); // This also notifies
      }
      if (totalMissing > 0) loadingProgress.value = (i + 1) / totalMissing;
      onProgress?.call(i + 1, totalMissing);
    }
    await _repackService
        .deleteFailedRepacksFromAllRepackNames(); // This also notifies
    _repackService.everyRepack.sort((a, b) => a.title.compareTo(b.title));
    _repackService.notifyListeners(); // Final notification for sort
    debugPrint('scrapeMissingRepacks finished. Scraped/Attempted: $totalMissing');
    if (totalMissing > 0) loadingProgress.value = 1.0; // Mark as complete
  }

  Future<Map<String, String>> scrapeAllRepacksNames({
    required Function(int, int) onProgress,
  }) async {
    Map<String, String> repacks = {};
    final url = Uri.parse('https://fitgirl-repacks.site/all-my-repacks-a-z/');
    final response = await _fetchWithRetry(url);
    dom.Document html = dom.Document.html(response.body);
    final pageLinks = html.querySelectorAll(
      'ul.lcp_paginator > li > a:not([class])',
    );

    if (pageLinks.isEmpty) {
      // Handle case where site structure might change or no pagination
      debugPrint(
        "Warning: Could not find pagination for all repacks names. Scraping first page only.",
      );
      // Try to scrape current page if no paginator
      final titles =
          html.querySelectorAll('ul.lcp_catlist > li > a').map((element) {
            final title = element.innerHtml.trim();
            final index = title.indexOf(
              RegExp(r'[–+]'),
            ); // Using RegExp for robustness
            return index != -1 ? title.substring(0, index).trim() : title;
          }).toList();
      final links =
          html
              .querySelectorAll('ul.lcp_catlist > li > a')
              .map((element) => element.attributes['href']!.trim())
              .toList();
      for (int j = 0; j < titles.length; j++) {
        repacks[titles[j]] = links[j];
      }
      onProgress(1, 1); // Indicate one page processed
      return repacks;
    }

    final pages =
        pageLinks
            .map(
              (element) => int.tryParse(element.attributes['title'] ?? '') ?? 0,
            )
            .where((p) => p > 0) // Filter out non-numeric or zero titles
            .toList();

    int totalPages =
        pages.isNotEmpty
            ? pages.reduce((curr, next) => curr > next ? curr : next)
            : 1;

    for (int i = 1; i <= totalPages; i++) {
      final pageUrl = Uri.parse(
        'https://fitgirl-repacks.site/all-my-repacks-a-z/?lcp_page0=$i#lcp_instance_0',
      );
      final pageResponse = await _fetchWithRetry(pageUrl);
      dom.Document pageHtml = dom.Document.html(pageResponse.body);

      final titles =
          pageHtml.querySelectorAll('ul.lcp_catlist > li > a').map((element) {
            final title = element.innerHtml.trim();
            final index = title.indexOf(RegExp(r'[–+]'));
            return index != -1 ? title.substring(0, index).trim() : title;
          }).toList();
      final links =
          pageHtml
              .querySelectorAll('ul.lcp_catlist > li > a')
              .map((element) => element.attributes['href']!.trim())
              .toList();

      for (int j = 0; j < titles.length; j++) {
        repacks[titles[j]] = links[j];
      }
      // loadingProgress.value is managed by caller like forceRescrapeEverything
      onProgress(i, totalPages);
    }
    return repacks;
  }

  Future<Repack> scrapeRepackFromSearch(String searchUrl) async {
    final url = Uri.parse(searchUrl);
    final response = await _fetchWithRetry(url);
    dom.Document html = dom.Document.html(response.body);
    final article = html.querySelector('article.category-lossless-repack');
    if (article == null) {
      throw Exception("Could not find article element on page: $searchUrl");
    }
    return await deleteInvalidScreenshots(
      scrapeRepack(article, url: searchUrl),
    );
  }

  Future<List<Repack>> scrapeNewRepacks({
    // Returns list, does not save
    required Function(int, int) onProgress,
  }) async {
    int pagesToScrape = 2; // Usually 2 pages for "new"
    List<Repack> repacks = [];
    for (int i = 0; i < pagesToScrape; i++) {
      try {
        final url = Uri.parse(
          'https://fitgirl-repacks.site/category/lossless-repack/page/${i + 1}/',
        );
        final response = await _fetchWithRetry(url);
        dom.Document html = dom.Document.html(response.body);
        final articles = html.querySelectorAll(
          'article.category-lossless-repack',
        );
        if (articles.isEmpty && i == 0) {
          // If first page has no articles, something is wrong or no new repacks
          debugPrint(
            "No articles found on the first page of new repacks. Stopping scrape for new repacks.",
          );
          break;
        }
        if (articles.isEmpty) {
          // If subsequent page is empty, means no more new repacks
          break;
        }
        for (final article in articles) {
          repacks.add(await deleteInvalidScreenshots(scrapeRepack(article)));
        }
        onProgress(i + 1, pagesToScrape);
      } catch (e) {
        debugPrint("Error scraping new repacks page ${i + 1}: $e");
        // Decide if to continue or rethrow. For new/popular, might be okay to skip a page.
        if (i == 0) rethrow; // If first page fails, it's a bigger issue
      }
    }
    return repacks;
  }

  Future<List<Repack>> scrapePopularRepacks({
    // Returns list, does not save
    required Function(int, int) onProgress,
  }) async {
    List<Repack> repacks = [];
    final popularIndexUrl = Uri.parse(
      'https://fitgirl-repacks.site/popular-repacks/',
    );
    final indexResponse = await _fetchWithRetry(popularIndexUrl);
    dom.Document indexHtml = dom.Document.html(indexResponse.body);

    final individualRepackPageUrls =
        indexHtml
            .querySelectorAll(
              'article > div.entry-content > div.jetpack_top_posts_widget > div.widgets-grid-layout > div.widget-grid-view-image > a',
            )
            .map((element) => element.attributes['href']?.trim())
            .whereType<String>() // Filter out nulls
            .toList();

    if (individualRepackPageUrls.isEmpty) {
      debugPrint("Warning: No popular repack links found on the index page.");
      onProgress(0, 0);
      return repacks;
    }

    int itemsToScrape =
        (individualRepackPageUrls.length > 20)
            ? 20
            : individualRepackPageUrls.length;

    for (int i = 0; i < itemsToScrape; i++) {
      try {
        final String repackUrlString = individualRepackPageUrls[i];
        final Uri repackUrl = Uri.parse(repackUrlString);
        final repackPageResponse = await _fetchWithRetry(repackUrl);
        dom.Document repackPageHtml = dom.Document.html(
          repackPageResponse.body,
        );
        final articleElement = repackPageHtml.querySelector(
          'article.category-lossless-repack',
        );

        if (articleElement != null) {
          Repack repack = await deleteInvalidScreenshots(
            scrapeRepack(articleElement, url: repackUrlString),
          );
          repacks.add(repack);
        } else {
          debugPrint(
            "Warning: Could not find 'article.category-lossless-repack' on page: $repackUrlString",
          );
        }
        onProgress(i + 1, itemsToScrape);
      } catch (e) {
        debugPrint(
          'Error scraping popular repack from ${individualRepackPageUrls[i]}: $e',
        );
      }
    }
    return repacks;
  }

  Repack scrapeRepack(dom.Element article, {String url = ''}) {
    // This is the existing scraping logic, not changing it per instructions.
    // However, it's prone to errors if site structure changes.
    // Minimal safety checks can be added if absolutely necessary without altering main logic.

    dom.Document html = dom.Document.html(article.outerHtml);
    final List<dom.Element> h3Elements = html.querySelectorAll(
      'div.entry-content h3',
    );
    List<Map<String, String>> repackSections = [];

    if (url.isEmpty) {
      url =
          html.querySelector('header > h1 > a')?.attributes['href']?.trim() ??
          'N/A_URL';
    }

    for (int i = 0; i < h3Elements.length; i++) {
      final dom.Element h3Element = h3Elements[i];
      h3Element.querySelector('span')?.remove();
      final String h3Text = h3Element.text.trim();
      final StringBuffer sectionContent = StringBuffer();
      dom.Element? nextSibling = h3Element.nextElementSibling;
      while (nextSibling != null && nextSibling.localName != 'h3') {
        sectionContent.write(nextSibling.outerHtml);
        nextSibling = nextSibling.nextElementSibling;
      }
      repackSections.add({
        'title': h3Text,
        'content': sectionContent.toString(),
      });
    }

    if (repackSections.isEmpty) {
      throw Exception("No repack sections found in article for URL: $url");
    }

    final String title = repackSections[0]['title'] ?? 'N/A Title';
    final String dateString =
        html
            .querySelector(
              'header.entry-header > div.entry-meta > span.entry-date > a > time',
            )
            ?.text
            .trim() ??
        "01/01/1970";
    DateTime releaseDate;
    try {
      releaseDate = DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      releaseDate = DateTime.now(); // Fallback
    }

    final coverContent = repackSections[0]['content'] ?? "";
    final cover =
        coverContent.contains('<img')
            ? coverContent.substring(
              coverContent.indexOf('src="') + 5,
              coverContent.indexOf('"', coverContent.indexOf('src="') + 5),
            )
            : 'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true'; // Fallback cover

    final dom.Element? infoElement = html.querySelector('div.entry-content p');
    String genres = 'N/A';
    String company = 'N/A';
    String language = 'N/A';
    String originalSize = 'N/A';
    String repackSize = 'N/A';

    if (infoElement != null) {
      Map<String, String> infoMap = infoElement.innerHtml
          .split('<br>\n')
          .where((s) => s.contains(':')) // Ensure there's a colon
          .map((element) {
            final parts = element.split(':');
            final key = parts[0].trim().toLowerCase();
            final value =
                parts
                    .sublist(1)
                    .join(':') // Handle colons in value
                    .replaceAll('<strong>', '')
                    .replaceAll('</strong>', '')
                    .trim();
            return MapEntry(key, value);
          })
          .fold({}, (prev, element) {
            prev[element.key] = element.value;
            return prev;
          });
      genres = infoMap['genres/tags'] ?? infoMap['genres'] ?? 'N/A';
      language = infoMap['languages'] ?? infoMap['language'] ?? 'N/A';
      company = infoMap['companies'] ?? infoMap['company'] ?? 'N/A';
      originalSize = infoMap['original size'] ?? 'N/A';
      repackSize = infoMap['repack size'] ?? 'N/A';
    }

    Map<String, List<Map<String, String>>> sectionDownloadLinks = {};
    for (var section in repackSections) {
      if (section['title']!.toLowerCase().contains('download')) {
        final links =
            dom.Document.html(section['content']!)
                .querySelectorAll('a[href]')
                .map(
                  (element) => {
                    'hostName': element.text.trim(),
                    'url': element.attributes['href']!.trim(),
                  },
                )
                .where(
                  (link) =>
                      (link['url']!.startsWith('magnet:')) &&
                      link['hostName']!.toLowerCase() != '.torrent file only',
                )
                .toList();
        if (links.isNotEmpty) {
          sectionDownloadLinks[section['title']!] = links;
        }
      }
      final fuckingFastLinks =
          dom.Document.html(section['content']!)
              .querySelectorAll('a[href]')
              .map((element) => element.attributes['href']!.trim())
              .where((url) => url.startsWith('https://fuckingfast'))
              .toList();
      if (fuckingFastLinks.isNotEmpty) {
        final ddd = {
          'hostName': 'FuckingFast',
          'url': fuckingFastLinks.join(', '),
        };
        sectionDownloadLinks['FuckingFast'] = [ddd];
      }
    }

    final String repackFeatures = repackSections
        .where(
          (section) =>
              section['title']!.toLowerCase().contains('repack features'),
        )
        .map((section) => section['content'])
        .expand((content) {
          final document = dom.Document.html(content!);
          document.querySelectorAll('div.su-spoiler').forEach((element) {
            element.remove();
          });
          return document
              .querySelectorAll('li')
              .map((element) => '\u2022${element.innerHtml.trim()}');
        })
        .toList()
        .join('\n');

    final descriptionHelper = dom.Document.html(
      '${repackSections.expand((section) {
        final document = dom.Document.html(section['content']!);
        return document.querySelectorAll('div.su-spoiler').map((element) => element.innerHtml.trim().split('</div>')).where((list) => list.isNotEmpty && list[0].toLowerCase().contains('game description'));
      }).toList()[0][1]}</div>',
    );
    final description = descriptionHelper
        .querySelector('div')!
        .innerHtml
        .trim()
        .replaceAll('<p>', '')
        .replaceAll('</p>', '\n')
        .replaceAll('<b>', '')
        .replaceAll('</b>', '')
        .replaceAll('<ul>', '')
        .replaceAll('</ul>', '')
        .replaceAll('<li>', '\u2022')
        .replaceAll('</li>', '')
        .replaceAll('<br>', '');

    final List<String> screenshots =
        repackSections
            .where(
              (section) =>
                  section['title']!.toLowerCase().contains('screenshots'),
            )
            .map((section) => section['content']!)
            .expand((content) {
              return dom.Document.html(content).querySelectorAll('img').map((
                element,
              ) {
                try {
                  String src = element.attributes['src']!.trim();
                  if (src.endsWith('.240p.jpg')) {
                    src = src.substring(0, src.length - '.240p.jpg'.length);
                  }
                  return src;
                } catch (e) {
                  print(e);
                  return '';
                }
              });
            })
            .toList();

    return Repack(
      title: title,
      url: url,
      releaseDate: releaseDate,
      cover: cover,
      genres: genres,
      language: language,
      company: company,
      originalSize: originalSize,
      repackSize: repackSize,
      downloadLinks: sectionDownloadLinks,
      repackFeatures: repackFeatures,
      description: description,
      screenshots: screenshots,
    );
  }

  Future<http.Response> _fetchWithRetry(Uri url, {int retries = 3}) async {
    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        final response = await http
            .get(url)
            .timeout(const Duration(seconds: 30)); // Added timeout
        if (response.statusCode == 200) {
          return response;
        } else if (response.statusCode == 404 && attempt < retries - 1) {
          debugPrint("Got 404 for $url, retrying (${attempt + 1}/$retries)...");
          await Future.delayed(
            Duration(seconds: 2 + attempt * 2),
          ); // Exponential backoff
          continue; // Retry on 404 as well
        } else {
          throw http.ClientException(
            'Failed to load data: ${response.statusCode} from $url',
          );
        }
      } on SocketException catch (e) {
        if (attempt == retries - 1) rethrow;
        debugPrint(
          "SocketException for $url: $e. Retrying (${attempt + 1}/$retries)...",
        );
        await Future.delayed(Duration(seconds: 5 + attempt * 5));
      } on http.ClientException catch (e) {
        if (attempt == retries - 1) rethrow;
        debugPrint(
          "ClientException for $url: $e. Retrying (${attempt + 1}/$retries)...",
        );
        await Future.delayed(Duration(seconds: 2 + attempt * 2));
      } catch (e) {
        // Catch other errors like TimeoutException
        if (attempt == retries - 1) rethrow;
        debugPrint(
          "Generic error for $url: $e. Retrying (${attempt + 1}/$retries)...",
        );
        await Future.delayed(Duration(seconds: 3 + attempt * 3));
      }
    }
    throw http.ClientException(
      'Failed to load data from $url after $retries attempts',
    );
  }

  // New function for settings page
 Future<void> forceRescrapeEverything({
    required Function(String status) onStatusUpdate,
    required Function(double progress) onProgressUpdate,
  }) async {
    if (isRescraping) {
      onStatusUpdate("Another rescraping process is already running.");
      return;
    }
    isRescraping = true;
    loadingProgress.value = 0.0; // Global progress reset

    try {
      onStatusUpdate("Clearing all existing data...");
      onProgressUpdate(0.0);
      await _repackService.forceClearAllData();
      onProgressUpdate(0.05); // 5% for clearing

      onStatusUpdate("Scraping all repack names (Phase 1/4)...");
      _repackService.allRepacksNames = await scrapeAllRepacksNames(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(
              0.05 + (current / total) * 0.20,
            ); // Names: 20% (total 25%)
            onStatusUpdate("Scraping all repack names (Phase 1/4): Page $current of $total");
          }
        },
      );
      await _repackService.saveAllRepackList();
      onStatusUpdate(
        "All repack names scraped. (${_repackService.allRepacksNames.length} names found) (Phase 1/4 Complete)",
      );
      onProgressUpdate(0.25);

      onStatusUpdate(
        "Scraping details for every repack (Phase 2/4 - Longest Phase)...",
      );
      _repackService.everyRepack = await scrapeEveryRepack(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(
              0.25 + (current / total) * 0.50,
            ); // Details: 50% (total 75%)
            onStatusUpdate("Scraping details for every repack (Phase 2/4): Repack $current of $total");
          }
        },
      );
      await _repackService.saveEveryRepackList();
      onStatusUpdate(
        "All repack details scraped. (${_repackService.everyRepack.length} repacks processed) (Phase 2/4 Complete)",
      );
      onProgressUpdate(0.75);

      onStatusUpdate("Rescraping new repacks (Phase 3/4)...");
      await _scrapeAndSaveNewRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(
              0.75 + (current / total) * 0.10,
            ); // New: 10% (total 85%)
            onStatusUpdate("Rescraping new repacks (Phase 3/4): Page $current of $total");
          }
        },
      );
       onStatusUpdate("New repacks rescraped. (Phase 3/4 Complete)");
       onProgressUpdate(0.85);


      onStatusUpdate("Rescraping popular repacks (Phase 4/4)...");
      await _scrapeAndSavePopularRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(
              0.85 + (current / total) * 0.10,
            ); // Popular: 10% (total 95%)
            onStatusUpdate("Rescraping popular repacks (Phase 4/4): Item $current of $total");
          }
        },
      );
      onStatusUpdate("Popular repacks rescraped. (Phase 4/4 Complete)");
      onProgressUpdate(0.95);


      onStatusUpdate("Finalizing...");
      _repackService.notifyListeners();
      // Small delay for finalization to show before completion message
      await Future.delayed(const Duration(milliseconds: 500)); 
      onProgressUpdate(1.0); // All done
      onStatusUpdate("Full rescrape completed successfully!");
    } catch (e) {
      debugPrint("Error during force rescrape everything: $e");
      onStatusUpdate("Error: $e. Process halted.");
      // Do not rethrow if onStatusUpdate is used for final error reporting to UI
    } finally {
      isRescraping = false;
      loadingProgress.value = 0.0; // Reset global progress
    }
  }
}
