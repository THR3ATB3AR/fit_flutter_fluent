import 'dart:io';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScraperService {
  ScraperService._privateConstructor();
  static final ScraperService _instance = ScraperService._privateConstructor();
  static ScraperService get instance => _instance;

  bool isRescraping = false;
  final RepackService _repackService = RepackService.instance;
  final ValueNotifier<double> loadingProgress = ValueNotifier<double>(0.0);

  Future<void> _scrapeAndSaveNewRepacks({
    Function(int, int)? onProgress,
  }) async {
    _repackService.newRepacks.clear();
    _repackService.newRepacks = await scrapeNewRepacks(
      onProgress: onProgress ?? (i, e) {},
    );
    await _repackService.saveNewRepackList();
  }

  Future<void> _scrapeAndSavePopularRepacks({
    Function(int, int)? onProgress,
  }) async {
    _repackService.popularRepacks.clear();
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
    loadingProgress.value = 0.0;

    try {
      debugPrint("Rescraping new repacks...");
      await _scrapeAndSaveNewRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            loadingProgress.value = (current / total) * 0.5;
          }
        },
      );
      debugPrint("New repacks rescraped and saved.");

      debugPrint("Rescraping popular repacks...");
      await _scrapeAndSavePopularRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            loadingProgress.value = 0.5 + (current / total) * 0.5;
          }
        },
      );
      debugPrint("Popular repacks rescraped and saved.");
    } catch (e) {
      debugPrint("Error during rescrapeNewAndPopularRepacks: $e");
      rethrow;
    } finally {
      isRescraping = false;
      loadingProgress.value = 0.0;
    }
  }

  Future<void> rescrapeAllRepacksNames() async {
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
      }
      onProgress(i + 1, totalToScrape);
    }
    return repacks;
  }

  Future<void> scrapeMissingRepacks({Function(int, int)? onProgress}) async {
    final everyRepackUrls =
        _repackService.everyRepack.map((repack) => repack.url).toSet();
    final allRepackNamesCopy = Map<String, String>.from(
      _repackService.allRepacksNames,
    );

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
      loadingProgress.value = 1.0;
      onProgress?.call(0, 0);
      _repackService.notifyListeners();
      return;
    }

    debugPrint("Found $totalMissing missing repacks to scrape.");
    loadingProgress.value = 0.0;

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
        if (!_repackService.everyRepack.any((r) => r.url == repack.url)) {
          _repackService.everyRepack.add(repack);
          await _repackService.saveSingleEveryRepack(repack);
        }
      } catch (e) {
        debugPrint('Failed to scrape repack: $url ($title), error: $e');
        await _repackService.saveFailedRepack(title, url);
      }
      if (totalMissing > 0) loadingProgress.value = (i + 1) / totalMissing;
      onProgress?.call(i + 1, totalMissing);
    }
    await _repackService.deleteFailedRepacksFromAllRepackNames();
    _repackService.everyRepack.sort((a, b) => a.title.compareTo(b.title));
    _repackService.notifyListeners();
    debugPrint(
      'scrapeMissingRepacks finished. Scraped/Attempted: $totalMissing',
    );
    if (totalMissing > 0) loadingProgress.value = 1.0;
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
      debugPrint(
        "Warning: Could not find pagination for all repacks names. Scraping first page only.",
      );
      final titles =
          html.querySelectorAll('ul.lcp_catlist > li > a').map((element) {
            final title = element.innerHtml.trim();
            final index = title.indexOf(RegExp(r'[–+]'));
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
      onProgress(1, 1);
      return repacks;
    }

    final pages =
        pageLinks
            .map(
              (element) => int.tryParse(element.attributes['title'] ?? '') ?? 0,
            )
            .where((p) => p > 0)
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
    required Function(int, int) onProgress,
  }) async {
    int pagesToScrape = 2;
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
          debugPrint(
            "No articles found on the first page of new repacks. Stopping scrape for new repacks.",
          );
          break;
        }
        if (articles.isEmpty) {
          break;
        }
        for (final article in articles) {
          repacks.add(await deleteInvalidScreenshots(scrapeRepack(article)));
        }
        onProgress(i + 1, pagesToScrape);
      } catch (e) {
        debugPrint("Error scraping new repacks page ${i + 1}: $e");
        if (i == 0) rethrow;
      }
    }
    return repacks;
  }

  Future<List<Repack>> scrapePopularRepacks({
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
            .whereType<String>()
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
      releaseDate = DateTime.now();
    }

    final coverContent = repackSections[0]['content'] ?? "";
    final cover =
        coverContent.contains('<img')
            ? coverContent.substring(
              coverContent.indexOf('src="') + 5,
              coverContent.indexOf('"', coverContent.indexOf('src="') + 5),
            )
            : 'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true';

    final dom.Element? infoElement = html.querySelector('div.entry-content p');
    String genres = 'N/A';
    String company = 'N/A';
    String language = 'N/A';
    String originalSize = 'N/A';
    String repackSize = 'N/A';

    if (infoElement != null) {
      Map<String, String> infoMap = infoElement.innerHtml
          .split('<br>\n')
          .where((s) => s.contains(':'))
          .map((element) {
            final parts = element.split(':');
            final key = parts[0].trim().toLowerCase();
            final value =
                parts
                    .sublist(1)
                    .join(':')
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
            .timeout(const Duration(seconds: 30));
        if (response.statusCode == 200) {
          return response;
        } else if (response.statusCode == 404 && attempt < retries - 1) {
          debugPrint("Got 404 for $url, retrying (${attempt + 1}/$retries)...");
          await Future.delayed(Duration(seconds: 2 + attempt * 2));
          continue;
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

  Future<void> forceRescrapeEverything({
    required Function(String status) onStatusUpdate,
    required Function(double progress) onProgressUpdate,
    required BuildContext context,
  }) async {
    if (isRescraping) {
      onStatusUpdate(
        AppLocalizations.of(context)!.anotherRescrapingProcessIsAlreadyRunning,
      );
      return;
    }
    isRescraping = true;
    loadingProgress.value = 0.0;

    try {
      onStatusUpdate(AppLocalizations.of(context)!.clearingAllExistingData);
      onProgressUpdate(0.0);
      await _repackService.forceClearAllData();
      onProgressUpdate(0.05);

      onStatusUpdate(
        AppLocalizations.of(context)!.scrapingAllRepackNamesPhase1,
      );
      _repackService.allRepacksNames = await scrapeAllRepacksNames(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(0.05 + (current / total) * 0.20);
            onStatusUpdate(
              AppLocalizations.of(
                context,
              )!.scrapingAllRepackNamesPhase1Progress(current, total),
            );
          }
        },
      );
      await _repackService.saveAllRepackList();
      onStatusUpdate(
        AppLocalizations.of(
          context,
        )!.allRepackNamesScrapedPhase1(_repackService.allRepacksNames.length),
      );
      onProgressUpdate(0.25);

      onStatusUpdate(
        AppLocalizations.of(
          context,
        )!.scrapingDetailsForEveryRepackPhase2LongestPhase,
      );
      _repackService.everyRepack = await scrapeEveryRepack(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(0.25 + (current / total) * 0.50);
            onStatusUpdate(
              AppLocalizations.of(
                context,
              )!.scrapingDetailsForEveryRepackPhase2Progress(current, total),
            );
          }
        },
      );
      await _repackService.saveEveryRepackList();
      onStatusUpdate(
        AppLocalizations.of(
          context,
        )!.allRepackDetailsScrapedPhase2(_repackService.everyRepack.length),
      );
      onProgressUpdate(0.75);

      onStatusUpdate(AppLocalizations.of(context)!.rescrapingNewRepacksPhase3);
      await _scrapeAndSaveNewRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(0.75 + (current / total) * 0.10);
            onStatusUpdate(
              AppLocalizations.of(
                context,
              )!.rescrapingNewRepacksPhase3Progress(current, total),
            );
          }
        },
      );
      onStatusUpdate(
        AppLocalizations.of(context)!.newRepacksRescrapedPhase3Complete,
      );
      onProgressUpdate(0.85);

      onStatusUpdate(
        AppLocalizations.of(context)!.rescrapingPopularRepacksPhase4,
      );
      await _scrapeAndSavePopularRepacks(
        onProgress: (current, total) {
          if (total > 0) {
            onProgressUpdate(0.85 + (current / total) * 0.10);
            onStatusUpdate(
              AppLocalizations.of(
                context,
              )!.rescrapingPopularRepacksPhase4Progress(current, total),
            );
          }
        },
      );
      onStatusUpdate(
        AppLocalizations.of(context)!.popularRepacksRescrapedPhase4Complete,
      );
      onProgressUpdate(0.95);

      onStatusUpdate(AppLocalizations.of(context)!.finalizing);
      _repackService.notifyListeners();
      await Future.delayed(const Duration(milliseconds: 500));
      onProgressUpdate(1.0);
      onStatusUpdate(
        AppLocalizations.of(context)!.fullRescrapeCompletedSuccessfully,
      );
    } catch (e) {
      debugPrint("Error during force rescrape everything: $e");
      onStatusUpdate(
        AppLocalizations.of(context)!.errorProcessHalted(e.toString()),
      );
    } finally {
      isRescraping = false;
      loadingProgress.value = 0.0;
    }
  }
}
