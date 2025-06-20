import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fit_flutter_fluent/data/download_mirror.dart';
import 'package:fit_flutter_fluent/data/gog_download_links.dart';
import 'package:fit_flutter_fluent/data/gog_game.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:fit_flutter_fluent/l10n/generated/app_localizations.dart';

class ScraperService {
  ScraperService._privateConstructor();
  static final ScraperService _instance = ScraperService._privateConstructor();
  static ScraperService get instance => _instance;

  static const int _maxConcurrentFetches = 20;

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

  Future<void> _scrapeAndSaveGogGames({Function(int, int)? onProgress}) async {
    _repackService.gogGames.clear();
    _repackService.gogGames = await scrapeGogGames(
      onProgress: onProgress ?? (i, e) {},
    );
    await _repackService.saveGogGamesList();
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

      debugPrint("scraping gog games...");
      await _scrapeAndSaveGogGames(
        onProgress: (current, total) {
          if (total > 0) {
            loadingProgress.value = 1.0;
          }
        },
      );
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
    if (url.isEmpty || !Uri.tryParse(url)!.isAbsolute) return false;
    try {
      final response = await http.head(Uri.parse(url));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<Repack> deleteInvalidScreenshots(Repack repack) async {
    final defaultCover =
        'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true';

    final allImageUrls = [repack.cover, ...repack.screenshots];

    final checkFutures = allImageUrls.map((url) => checkImageUrl(url)).toList();

    final results = await Future.wait(checkFutures);

    if (!results[0]) {
      repack.cover = defaultCover;
    }

    final List<String> validScreenshots = [];
    for (int i = 0; i < repack.screenshots.length; i++) {
      if (results[i + 1]) {
        validScreenshots.add(repack.screenshots[i]);
      }
    }
    repack.screenshots = validScreenshots;

    return repack;
  }

  Future<List<Repack>> scrapeEveryRepack({
    required Function(int, int) onProgress,
  }) async {
    final allNamesEntries = _repackService.allRepacksNames.entries.toList();

    return await _processInBatches(
      items: allNamesEntries,
      processItem: (entry) async {
        try {
          return await scrapeRepackFromSearch(entry.value);
        } catch (e) {
          debugPrint('Failed to scrape repack: ${entry.key}, error: $e');
          return null;
        }
      },
      batchSize: _maxConcurrentFetches,
      onProgress: onProgress,
    );
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

    final List<MapEntry<String, String>> missingRepackEntries =
        allRepackNamesCopy.entries
            .where((entry) => urlsToPotentiallyScrape.contains(entry.value))
            .toList();

    int totalMissing = missingRepackEntries.length;
    if (totalMissing == 0) {
      debugPrint("No missing repacks to scrape.");
      loadingProgress.value = 1.0;
      onProgress?.call(0, 0);
      _repackService.notifyListeners();
      return;
    }

    debugPrint("Found $totalMissing missing repacks to scrape.");
    loadingProgress.value = 0.0;

    await _processInBatches(
      items: missingRepackEntries,
      processItem: (entry) async {
        final title = entry.key;
        final url = entry.value;
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
        return null;
      },
      batchSize: _maxConcurrentFetches,
      onProgress: (current, total) {
        if (total > 0) loadingProgress.value = current / total;
        onProgress?.call(current, total);
      },
    );

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

    void parsePage(dom.Document doc) {
      final titlesAndLinks =
          doc.querySelectorAll('ul.lcp_catlist > li > a').map((element) {
            final title = element.innerHtml.trim();
            final index = title.indexOf(RegExp(r'[–+]'));
            final cleanTitle =
                (index != -1 ? title.substring(0, index) : title).trim();
            final link = element.attributes['href']!.trim();
            return MapEntry(cleanTitle, link);
          }).toList();

      for (var entry in titlesAndLinks) {
        repacks[entry.key] = entry.value;
      }
    }

    parsePage(html);

    final pageLinks = html.querySelectorAll(
      'ul.lcp_paginator > li > a:not([class])',
    );
    if (pageLinks.isEmpty) {
      debugPrint(
        "Warning: Could not find pagination. Scraping first page only.",
      );
      onProgress(1, 1);
      return repacks;
    }

    final totalPages = pageLinks
        .map((e) => int.tryParse(e.attributes['title'] ?? '') ?? 0)
        .fold(0, (max, current) => current > max ? current : max);

    if (totalPages <= 1) {
      onProgress(1, 1);
      return repacks;
    }

    final pagesToFetch = List.generate(totalPages - 1, (index) => index + 2);

    await _processInBatches(
      items: pagesToFetch,
      processItem: (pageNum) async {
        final pageUrl = Uri.parse(
          'https://fitgirl-repacks.site/all-my-repacks-a-z/?lcp_page0=$pageNum#lcp_instance_0',
        );
        final pageResponse = await _fetchWithRetry(pageUrl);
        return dom.Document.html(pageResponse.body);
      },
      batchSize: _maxConcurrentFetches,
      onProgress: (current, total) => onProgress(current + 1, totalPages),
      onBatchComplete: (List<dom.Document?> batchResults) {
        for (final doc in batchResults.whereType<dom.Document>()) {
          parsePage(doc);
        }
      },
    );

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

    final pageFutures = List.generate(pagesToScrape, (i) {
      final url = Uri.parse(
        'https://fitgirl-repacks.site/category/lossless-repack/page/${i + 1}/',
      );
      return _fetchWithRetry(url).catchError((e) {
        debugPrint("Error scraping new repacks page ${i + 1}: $e");
        if (i == 0) {
          throw e;
        }
        return http.Response('', 500);
      });
    });

    final responses = await Future.wait(pageFutures);
    int processedCount = 0;

    for (final response in responses.whereType<http.Response>()) {
      dom.Document html = dom.Document.html(response.body);
      final articles = html.querySelectorAll(
        'article.category-lossless-repack',
      );

      final repackFutures =
          articles
              .map((article) => deleteInvalidScreenshots(scrapeRepack(article)))
              .toList();
      final scrapedRepacks = await Future.wait(repackFutures);
      repacks.addAll(scrapedRepacks);

      processedCount++;
      onProgress(processedCount, pagesToScrape);
    }

    return repacks;
  }

  Future<List<Repack>> scrapePopularRepacks({
    required Function(int, int) onProgress,
  }) async {
    final popularIndexUrl = Uri.parse(
      'https://fitgirl-repacks.site/popular-repacks/',
    );
    final indexResponse = await _fetchWithRetry(popularIndexUrl);
    dom.Document indexHtml = dom.Document.html(indexResponse.body);

    final individualRepackPageUrls =
        indexHtml
            .querySelectorAll(
              'article > div.entry-content div.jetpack_top_posts_widget a',
            )
            .map((element) => element.attributes['href']?.trim())
            .whereType<String>()
            .take(20)
            .toList();

    if (individualRepackPageUrls.isEmpty) {
      debugPrint("Warning: No popular repack links found on the index page.");
      onProgress(0, 0);
      return [];
    }

    return await _processInBatches(
      items: individualRepackPageUrls,
      processItem: (repackUrl) async {
        try {
          return await scrapeRepackFromSearch(repackUrl);
        } catch (e) {
          debugPrint('Error scraping popular repack from $repackUrl: $e');
          return null;
        }
      },
      batchSize: _maxConcurrentFetches,
      onProgress: onProgress,
    );
  }

  Repack scrapeRepack(dom.Element article, {String url = ''}) {
    final List<dom.Element> h3Elements = article.querySelectorAll(
      'div.entry-content h3',
    );
    List<Map<String, String>> repackSections = [];

    url =
        url.isEmpty
            ? article
                    .querySelector('header > h1 > a')
                    ?.attributes['href']
                    ?.trim() ??
                'N/A_URL'
            : url;

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

    final String title = repackSections.first['title'] ?? 'N/A Title';
    final String dateString =
        article
            .querySelector('header.entry-header time.entry-date')
            ?.text
            .trim() ??
        "01/01/1970";
    DateTime releaseDate;
    try {
      releaseDate = DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      releaseDate = DateTime.now();
    }

    final coverContent = repackSections.first['content'] ?? "";
    final coverMatch = RegExp(r'src="([^"]+)"').firstMatch(coverContent);
    final cover =
        coverMatch?.group(1) ??
        'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true';

    final dom.Element? infoElement = article.querySelector(
      'div.entry-content p',
    );
    String genres = 'N/A',
        company = 'N/A',
        language = 'N/A',
        originalSize = 'N/A',
        repackSize = 'N/A';

    if (infoElement != null) {
      final infoMap = infoElement.innerHtml
          .split(RegExp(r'<br\s*/?>\s*\n?'))
          .where((s) => s.contains(':'))
          .map((element) {
            final parts = element.split(':');
            final key =
                parts.first
                    .replaceAll(RegExp(r'<[^>]*>'), '')
                    .trim()
                    .toLowerCase();
            final value =
                parts
                    .sublist(1)
                    .join(':')
                    .replaceAll(RegExp(r'<[^>]*>'), '')
                    .trim();
            return MapEntry(key, value);
          })
          .fold<Map<String, String>>(
            {},
            (prev, element) => prev..[element.key] = element.value,
          );

      genres = infoMap['genres/tags'] ?? infoMap['genres'] ?? 'N/A';
      language = infoMap['languages'] ?? infoMap['language'] ?? 'N/A';
      company = infoMap['companies'] ?? infoMap['company'] ?? 'N/A';
      originalSize = infoMap['original size'] ?? 'N/A';
      repackSize = infoMap['repack size'] ?? 'N/A';
    }

    Map<String, List<Map<String, String>>> sectionDownloadLinks = {};
    for (var section in repackSections) {
      final contentDoc = dom.Document.html(section['content']!);
      if (section['title']!.toLowerCase().contains('download')) {
        final links =
            contentDoc
                .querySelectorAll('a[href^="magnet:"]')
                .where((el) => el.text.toLowerCase() != '.torrent file only')
                .map(
                  (el) => {
                    'hostName': el.text.trim(),
                    'url': el.attributes['href']!.trim(),
                  },
                )
                .toList();
        if (links.isNotEmpty) {
          sectionDownloadLinks[section['title']!] = links;
        }
      }
      final fuckingFastLinks =
          contentDoc
              .querySelectorAll('a[href*="fuckingfast"]')
              .map((el) => el.attributes['href']!.trim())
              .toList();
      if (fuckingFastLinks.isNotEmpty) {
        sectionDownloadLinks['FuckingFast'] = [
          {'hostName': 'FuckingFast', 'url': fuckingFastLinks.join(', ')},
        ];
      }
    }

    final updatesContent = repackSections
        .where((s) => s['title']!.toLowerCase().contains('game updates'))
        .map(
          (s) =>
              dom.Document.html(s['content']!).querySelector('div')?.innerHtml,
        )
        .whereType<String>()
        .join('\n')
        .replaceAll(RegExp(r'\s?\(Source:.*?\)', caseSensitive: false), '');
    final String? updates = updatesContent.isNotEmpty ? updatesContent : null;

    final String repackFeatures = repackSections
        .where((s) => s['title']!.toLowerCase().contains('repack features'))
        .map((s) => s['content']!)
        .expand((content) {
          final doc = dom.Document.html(content);
          doc.querySelectorAll('div.su-spoiler').forEach((e) => e.remove());
          return doc
              .querySelectorAll('li')
              .map((e) => '\u2022${e.innerHtml.trim()}');
        })
        .join('\n');

    String description = 'N/A';
    final descriptionSpoiler = article
        .querySelectorAll('div.su-spoiler')
        .firstWhere(
          (spoiler) =>
              spoiler
                  .querySelector('.su-spoiler-title')
                  ?.text
                  .toLowerCase()
                  .contains('game description') ??
              false,
          orElse: () => dom.Element.html('<div></div>'),
        );
    final descriptionContent = descriptionSpoiler.querySelector(
      '.su-spoiler-content',
    );
    if (descriptionContent != null) {
      description =
          descriptionContent.innerHtml
              .trim()
              .replaceAll(RegExp(r'</p>\s*<p>', caseSensitive: false), '\n\n')
              .replaceAll(
                RegExp(r'</li>\s*<li>', caseSensitive: false),
                '\n\u2022',
              )
              .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
              .replaceAll(RegExp(r'<[^>]*>'), '')
              .trim();
    }

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
      updates: updates,
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
      } on TimeoutException {
        if (attempt == retries - 1) rethrow;
        debugPrint("Timeout for $url. Retrying (${attempt + 1}/$retries)...");
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

  Future<List<T>> _processInBatches<S, T>({
    required List<S> items,
    required Future<T?> Function(S item) processItem,
    required int batchSize,
    Function(int processed, int total)? onProgress,
    Function(List<T?> batchResults)? onBatchComplete,
  }) async {
    final List<T> allResults = [];
    int processedCount = 0;

    for (int i = 0; i < items.length; i += batchSize) {
      final int end =
          (i + batchSize > items.length) ? items.length : i + batchSize;
      final batchItems = items.sublist(i, end);

      final futures =
          batchItems
              .map(
                (item) => processItem(item).catchError((e) {
                  debugPrint("Error in batch processing for item $item: $e");
                  return null;
                }),
              )
              .toList();

      final batchResults = await Future.wait(futures);

      if (onBatchComplete != null) {
        onBatchComplete(batchResults);
      }

      allResults.addAll(batchResults.whereType<T>());

      processedCount += batchItems.length;
      final currentProgress =
          processedCount > items.length ? items.length : processedCount;
      onProgress?.call(currentProgress, items.length);
    }
    return allResults;
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
            final phaseProgress = (current / total) * 0.20;
            onProgressUpdate(0.05 + phaseProgress);
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
            final phaseProgress = (current / total) * 0.50;
            onProgressUpdate(0.25 + phaseProgress);
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
            final phaseProgress = (current / total) * 0.10;
            onProgressUpdate(0.75 + phaseProgress);
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
            final phaseProgress = (current / total) * 0.10;
            onProgressUpdate(0.85 + phaseProgress);
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

  Future<List<GogGame>> scrapeGogGames({
    required Function(int, int) onProgress,
  }) async {
    // 1. Fetch the initial list of all games from gog-games.to
    final allGamesUrl = Uri.parse('https://gog-games.to/api/web/all-games');
    http.Response response;
    try {
      response = await _fetchWithRetry(allGamesUrl);
    } catch (e) {
      debugPrint("Failed to fetch all games list from gog-games.to: $e");
      // If the initial list fails, we cannot proceed.
      return [];
    }

    // Parse the JSON response into a list of dynamic objects
    final List<dynamic> allGamesData;
    try {
      allGamesData = jsonDecode(response.body) as List<dynamic>;
    } catch (e) {
      debugPrint("Failed to parse JSON from gog-games.to: $e");
      return [];
    }

    // Cast the list to a more specific type for processing
    final List<Map<String, dynamic>> gamesToProcess =
        allGamesData.cast<Map<String, dynamic>>();

    // 2. Use _processInBatches to fetch details for each game concurrently
    final List<GogGame>
    gogGames = await _processInBatches<Map<String, dynamic>, GogGame>(
      items: gamesToProcess,
      batchSize:
          _maxConcurrentFetches, // Reuse existing constant for concurrency
      onProgress: onProgress,
      processItem: (gameData) async {
        final String? gogId = gameData['id']?.toString();
        if (gogId == null || gogId.isEmpty) {
          debugPrint("Skipping game with missing ID: ${gameData['title']}");
          return null;
        }

        try {
          // Fetch detailed data for a single game from gogdb.org
          final gogDbUrl = Uri.parse(
            'https://www.gogdb.org/data/products/$gogId/product.json',
          );
          final gogDbResponse = await _fetchWithRetry(gogDbUrl);
          final Map<String, dynamic> gogDbData = jsonDecode(gogDbResponse.body);

          // 3. Combine data from both sources to create a GogGame instance

          // Helper function to clean HTML content into plain text
          String cleanHtml(String? htmlString) {
            if (htmlString == null || htmlString.isEmpty) return 'N/A';
            return htmlString
                .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
                .replaceAll(RegExp(r'<[^>]*>'), '')
                .trim();
          }

          // Extract genres from the 'tags' list
          final List<String> genres =
              (gogDbData['tags'] as List<dynamic>?)
                  ?.map((tag) => tag['name'].toString())
                  .toList() ??
              [];

          // Construct the full URL for the cover image
          final String coverHash =
              gogDbData['image_boxart'] ?? gameData['image'] ?? '';
          final String coverUrl =
              coverHash.isNotEmpty
                  ? 'https://images.gog-statics.com/$coverHash.jpg'
                  : 'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true'; // Default image

          // Construct full URLs for screenshots
          final List<String> screenshots =
              (gogDbData['screenshots'] as List<dynamic>?)
                  ?.map((hash) => 'https://images.gog-statics.com/$hash.jpg')
                  .toList() ??
              [];

          final List<String> languages =
              (gogDbData['localizations'] as List<dynamic>?)
                  ?.map((lang) => lang['name'].toString())
                  .toList() ??
              ['English']; // Default to English if not found

          // Extract user rating (out of 50)
          final int? userRating = gogDbData['user_rating'] as int?;

          // Extract Windows download size in bytes
          final installerList = gogDbData['dl_installer'] as List<dynamic>?;
          int? windowsDownloadSize;
          if (installerList != null) {
            final windowsInstaller = installerList.firstWhere(
              (installer) => installer['os'] == 'windows',
              orElse: () => null,
            );
            if (windowsInstaller != null) {
              windowsDownloadSize = windowsInstaller['total_size'] as int?;
            }
          }

          return GogGame(
            id: int.parse(gogId),
            title: gameData['title'] ?? 'N/A Title',
            slug: gameData['slug'] ?? '',
            developer: gameData['developer'] ?? 'N/A',
            publisher: gameData['publisher'] ?? 'N/A',
            updateDate:
                DateTime.tryParse(gameData['last_update'] ?? '') ??
                DateTime(1970),
            description: cleanHtml(gogDbData['description']),
            cover: coverUrl,
            genres: genres,
            screenshots: screenshots,
            // --- PASS NEW DATA TO CONSTRUCTOR ---
            languages: languages,
            userRating: userRating,
            windowsDownloadSize: windowsDownloadSize,
          );
        } catch (e, s) {
          debugPrint(
            "Failed to process game ID $gogId (${gameData['title']}): $e\n$s",
          );
          return null;
        }
      },
    );

    return gogGames;
  }

  Map<String, List<DownloadMirror>> _parseDownloadSection(dom.Document document, String sectionTitle) {
    // ... (This helper function from the previous answer remains unchanged)
    final Map<String, List<DownloadMirror>> categorizedMirrors = {};
    final sectionHeader = document.querySelectorAll('div[class^="game-section-with-accordion"] p.font-semibold').firstWhere(
          (p) => p.text.trim().toUpperCase() == sectionTitle,
      orElse: () => dom.Element.html('<div></div>'),
    );

    final sectionContainer = sectionHeader.parent?.parent;
    if (sectionContainer == null) return {};

    final mirrorElements = sectionContainer.querySelectorAll('details[class*="item-accordion"]');

    for (final mirrorElement in mirrorElements) {
      final mirrorName = mirrorElement.querySelector('summary p')?.text.trim();
      if (mirrorName == null || mirrorName.isEmpty) continue;
      
      final links = mirrorElement.querySelectorAll('div > a[href]')
                                .map((a) => a.attributes['href'])
                                .whereType<String>()
                                .toList();
      
      if (links.isNotEmpty) {
        final category = sectionTitle.replaceAll(' DOWNLOAD LINKS', '').trim();
        categorizedMirrors.putIfAbsent(category, () => []).add(
          DownloadMirror(mirrorName: mirrorName, urls: links),
        );
      }
    }
    return categorizedMirrors;
  }

  /// Scrapes all download links from a gog-games.to page using a headless browser.
  Future<GogDownloadLinks> scrapeGogGameDownloadLinks(String gamePageUrl) async {
    // We use a Completer to wait for the page to finish loading in the background.
    final Completer<String> contentCompleter = Completer<String>();

    debugPrint("[WebView] Starting headless scrape for: $gamePageUrl");
    
    // Create and run the headless webview.
    final headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(gamePageUrl)),
      initialSettings: InAppWebViewSettings(
        // Set a realistic User-Agent
        userAgent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36",
        // Crucially, enable JavaScript
        javaScriptEnabled: true,
        // Try to disable some detection mechanisms
        javaScriptCanOpenWindowsAutomatically: false,
        mediaPlaybackRequiresUserGesture: false,
      ),
      onLoadStop: (controller, url) async {
        debugPrint("[WebView] Page finished loading: $url");
        
        // Give Cloudflare/JS time to run its checks and render the content.
        // This delay is crucial for SPAs and anti-bot systems.
        await Future.delayed(const Duration(seconds: 10));
        
        debugPrint("[WebView] Extracting HTML content...");
        try {
          // Get the entire HTML of the rendered page.
          final html = await controller.getHtml();
          if (html != null && !contentCompleter.isCompleted) {
            contentCompleter.complete(html);
          } else if (!contentCompleter.isCompleted) {
            contentCompleter.completeError("Failed to get HTML content.");
          }
        } catch (e) {
          if (!contentCompleter.isCompleted) {
            contentCompleter.completeError(e);
          }
        }
      },
      onLoadError: (controller, url, code, message) {
        debugPrint("[WebView] Error loading page: $message");
        if (!contentCompleter.isCompleted) {
          contentCompleter.completeError("Error code $code: $message");
        }
      },
    );

    try {
      debugPrint("[WebView] Running headless webview instance...");
      await headlessWebView.run();

      // Wait for the onLoadStop callback to complete and provide the HTML, with a timeout.
      final String content = await contentCompleter.future.timeout(const Duration(seconds: 45));
      debugPrint("[WebView] Got page content. Length: ${content.length} characters.");
      
      // Stop and dispose the webview now that we have the content.
      await headlessWebView.dispose();
      debugPrint("[WebView] Headless webview disposed.");

      if (content.length < 5000) {
        debugPrint("[WebView] WARNING: Content is very short. Scrape might have been blocked.");
      }

      final document = parser.parse(content);

      // --- The rest of your parsing logic remains IDENTICAL ---
      debugPrint("[WebView] Parsing content...");
      final torrentElement = document.querySelector('a.btn-torrent[href^="magnet:"]');
      final String? torrentLink = torrentElement?.attributes['href'];
      
      final gameLinks = _parseDownloadSection(document, 'GAME DOWNLOAD LINKS');
      final patchLinks = _parseDownloadSection(document, 'PATCH DOWNLOAD LINKS');
      final extraLinks = _parseDownloadSection(document, 'EXTRA DOWNLOAD LINKS');
      debugPrint("[WebView] Parsing complete.");

      return GogDownloadLinks(
        torrentLink: torrentLink,
        gameDownloadLinks: gameLinks,
        patchDownloadLinks: patchLinks,
        extraDownloadLinks: extraLinks,
      );
    } catch (e) {
      debugPrint("FATAL ERROR during headless WebView scrape for $gamePageUrl: $e");
      // Ensure the webview is disposed even on error.
      if (headlessWebView.isRunning()) {
        await headlessWebView.dispose();
      }
      return GogDownloadLinks(); // Return empty on failure
    }
  }

  Future<GogGame> rescrapeSingleGogGame(int gogGameId) async {
    debugPrint("[Rescrape] Starting rescrape for GOG game ID: $gogGameId");

    // --- Step 1: Fetch the master list to find the specific game's base data ---
    final allGamesUrl = Uri.parse('https://gog-games.to/api/web/all-games');
    final http.Response allGamesResponse;
    try {
      allGamesResponse = await _fetchWithRetry(allGamesUrl);
    } catch (e) {
      throw Exception("Failed to fetch master game list from gog-games.to: $e");
    }

    final List<dynamic> allGamesData = jsonDecode(allGamesResponse.body);
    // Find the specific game's data from the master list by its ID.
    final gameData = allGamesData.cast<Map<String, dynamic>>().firstWhere(
          (game) => game['id']?.toString() == gogGameId.toString(),
      orElse: () => throw Exception("Game with ID $gogGameId not found in the master list."),
    );

    debugPrint("[Rescrape] Found base game data: ${gameData['title']}");

    // --- Step 2: Fetch the detailed data from gogdb.org ---
    final gogDbUrl = Uri.parse('https://www.gogdb.org/data/products/$gogGameId/product.json');
    final http.Response gogDbResponse;
    try {
      gogDbResponse = await _fetchWithRetry(gogDbUrl);
    } catch (e) {
      throw Exception("Failed to fetch detailed data from gogdb.org for ID $gogGameId: $e");
    }

    final Map<String, dynamic> gogDbData = jsonDecode(gogDbResponse.body);
    debugPrint("[Rescrape] Fetched detailed data from gogdb.org");

    // --- Step 3: Combine and build the new GogGame object (reusing logic from scrapeGogGames) ---
    String cleanHtml(String? htmlString) {
      if (htmlString == null || htmlString.isEmpty) return 'N/A';
      return htmlString.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n').replaceAll(RegExp(r'<[^>]*>'), '').trim();
    }

    final List<String> genres = (gogDbData['tags'] as List<dynamic>?)?.map((tag) => tag['name'].toString()).toList() ?? [];
    final String coverHash = gogDbData['image_boxart'] ?? gameData['image'] ?? '';
    final String coverUrl = coverHash.isNotEmpty ? 'https://images.gog-statics.com/$coverHash.jpg' : 'https://github.com/THR3ATB3AR/fit_flutter_assets/blob/main/noposter.png?raw=true';
    final List<String> screenshots = (gogDbData['screenshots'] as List<dynamic>?)?.map((hash) => 'https://images.gog-statics.com/$hash.jpg').toList() ?? [];
    final List<String> languages = (gogDbData['localizations'] as List<dynamic>?)?.map((lang) => lang['name'].toString()).toList() ?? ['English'];
    final int? userRating = gogDbData['user_rating'] as int?;

    final installerList = gogDbData['dl_installer'] as List<dynamic>?;
    int? windowsDownloadSize;
    if (installerList != null) {
      final windowsInstaller = installerList.firstWhere((installer) => installer['os'] == 'windows', orElse: () => null);
      if (windowsInstaller != null) {
        windowsDownloadSize = windowsInstaller['total_size'] as int?;
      }
    }

    debugPrint("[Rescrape] Successfully built new GogGame object.");

    return GogGame(
      id: gogGameId,
      title: gameData['title'] ?? 'N/A Title',
      slug: gameData['slug'] ?? '',
      developer: gameData['developer'] ?? 'N/A',
      publisher: gameData['publisher'] ?? 'N/A',
      updateDate: DateTime.tryParse(gameData['last_update'] ?? '') ?? DateTime(1970),
      description: cleanHtml(gogDbData['description']),
      cover: coverUrl,
      genres: genres,
      screenshots: screenshots,
      languages: languages,
      userRating: userRating,
      windowsDownloadSize: windowsDownloadSize,
    );
  }
}
