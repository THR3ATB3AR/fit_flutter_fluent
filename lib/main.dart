import 'dart:io';
import 'package:fit_flutter_fluent/providers/update_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/screens/download_manager_screen.dart';
import 'package:fit_flutter_fluent/screens/home.dart';
import 'package:fit_flutter_fluent/screens/repack_details.dart';
import 'package:fit_flutter_fluent/screens/repack_library.dart';
import 'package:fit_flutter_fluent/screens/settings.dart';
import 'package:fit_flutter_fluent/services/repack_service.dart';
import 'package:fluent_ui/fluent_ui.dart' hide Page;
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'theme.dart';

const String appTitle = 'FitFlutter';

bool get isDesktop {
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

final _appTheme = AppTheme();

Future<void> _requestPermissions() async {
  if (Platform.isAndroid) {
    final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _appTheme.loadInitialSettings();
  final updateProvider = UpdateProvider();
  await RepackService.instance.init();
  await _requestPermissions();

  if ([
    TargetPlatform.windows,
    TargetPlatform.android,
  ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await flutter_acrylic.Window.hideWindowControls();
    }
    await WindowManager.instance.ensureInitialized();

    await windowManager.waitUntilReadyToShow();

    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setMinimumSize(const Size(670, 690));
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
  }
  runApp(MyApp(updateProvider: updateProvider));
}

class MyApp extends StatelessWidget {
  final UpdateProvider updateProvider;
  const MyApp({super.key, required this.updateProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _appTheme),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider.value(value: updateProvider),
      ],
      child: Builder(
        builder: (context) {
          final appTheme = context.watch<AppTheme>();

          return FluentApp.router(
            title: appTitle,
            themeMode: appTheme.mode,
            debugShowCheckedModeBanner: false,
            color: appTheme.color,
            darkTheme: FluentThemeData(
              brightness: Brightness.dark,
              accentColor: appTheme.color,
              visualDensity: VisualDensity.standard,
              focusTheme: FocusThemeData(
                glowFactor: is10footScreen(context) ? 2.0 : 0.0,
              ),
            ),
            theme: FluentThemeData(
              accentColor: appTheme.color,
              visualDensity: VisualDensity.standard,
              focusTheme: FocusThemeData(
                glowFactor: is10footScreen(context) ? 2.0 : 0.0,
              ),
            ),
            locale: appTheme.locale,
            builder: (context, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                appTheme.applyInitialWindowEffectIfNeeded(context);
                if (isDesktop) {
                  windowManager.show();
                  windowManager.focus();
                }
              });

              return Directionality(
                textDirection: appTheme.textDirection,
                child: NavigationPaneTheme(
                  data: NavigationPaneThemeData(
                    backgroundColor:
                        appTheme.windowEffect !=
                                    flutter_acrylic.WindowEffect.disabled &&
                                (appTheme.windowEffect ==
                                        flutter_acrylic.WindowEffect.mica ||
                                    appTheme.windowEffect ==
                                        flutter_acrylic.WindowEffect.acrylic ||
                                    appTheme.windowEffect ==
                                        flutter_acrylic.WindowEffect.tabbed ||
                                    appTheme.windowEffect ==
                                        flutter_acrylic
                                            .WindowEffect
                                            .transparent)
                            ? Colors.transparent
                            : null,
                  ),
                  child: child!,
                ),
              );
            },
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.child,
    required this.shellContext,
  });

  final Widget child;
  final BuildContext? shellContext;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value = false;
  bool _isUpdateInfoBarVisible = false;

  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  late final List<NavigationPaneItem> originalItems =
      [
        PaneItem(
          key: const ValueKey('/'),
          icon: const Icon(FluentIcons.home),
          title: const Text('Home'),
          body: const SizedBox.shrink(),
        ),
        PaneItem(
          key: const ValueKey('/repacklibrary'),
          icon: const Icon(FluentIcons.library),
          title: const Text('Repack Library'),
          body: const SizedBox.shrink(),
        ),
      ].map<NavigationPaneItem>((e) {
        PaneItem buildPaneItem(PaneItem item) {
          return PaneItem(
            key: item.key,
            icon: item.icon,
            title: item.title,
            body: item.body,
            onTap: () {
              final path = (item.key as ValueKey).value;
              if (GoRouterState.of(context).uri.toString() != path) {
                context.go(path);
              }
              item.onTap?.call();
            },
          );
        }

        if (e is PaneItemExpander) {
          return PaneItemExpander(
            key: e.key,
            icon: e.icon,
            title: e.title,
            body: e.body,
            items:
                e.items.map((item) {
                  if (item is PaneItem) return buildPaneItem(item);
                  return item;
                }).toList(),
          );
        }
        return buildPaneItem(e);
      }).toList();

  late final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const ValueKey('/downloadmanager'),
      icon: const Icon(FluentIcons.download),
      title: const Text('Download Manager'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/downloadmanager') {
          context.go('/downloadmanager');
        }
      },
    ),
    PaneItem(
      key: const ValueKey('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (GoRouterState.of(context).uri.toString() != '/settings') {
          context.go('/settings');
        }
      },
    ),
  ];

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final updateProvider = Provider.of<UpdateProvider>(
        context,
        listen: false,
      );
      updateProvider.checkForUpdates();
      updateProvider.addListener(_handleUpdateInfobar);
    });
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    try {
      Provider.of<UpdateProvider>(
        context,
        listen: false,
      ).removeListener(_handleUpdateInfobar);
    } catch (e) {
      print("Could not remove UpdateProvider listener: $e");
    }
    super.dispose();
  }

  void _handleUpdateInfobar() {
    if (!mounted) return;
    final updateProvider = Provider.of<UpdateProvider>(context, listen: false);

    if (updateProvider.showUpdateInfobar && !_isUpdateInfoBarVisible) {
      setState(() {
        _isUpdateInfoBarVisible = true;
      });

      final latestTagName =
          updateProvider.latestReleaseInfo?['tag_name'] ?? "Unknown";
      final releaseNotes =
          updateProvider.latestReleaseInfo?['release_notes'] ??
          "No release notes available.";

      final PageStorageBucket infoBarBucket = PageStorageBucket();

      displayInfoBar(
        context,
        builder: (infoBarContext, close) {
          return PageStorage(
            bucket: infoBarBucket,
            child: InfoBar(
              title: Text('Update Available: $latestTagName'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('A new version of FitFlutter is available.'),
                  const SizedBox(height: 8),
                  Expander(
                    header: const Text('View Release Notes'),
                    content: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 150,
                        maxWidth: 400,
                      ),
                      child: SingleChildScrollView(child: Text(releaseNotes)),
                    ),
                  ),
                ],
              ),
              action: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HyperlinkButton(
                    child: const Text('Release Page'),
                    onPressed: () {
                      updateProvider.openReleasePage();
                    },
                  ),
                  const SizedBox(width: 8),
                  Button(
                    child: const Text('Later'),
                    onPressed: () {
                      updateProvider.ignoreCurrentUpdate();
                      if (mounted)
                        setState(() {
                          _isUpdateInfoBarVisible = false;
                        });
                      close();
                    },
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    child: const Text('Upgrade'),
                    onPressed: () {
                      if (mounted)
                        setState(() {
                          _isUpdateInfoBarVisible = false;
                        });
                      close();
                      updateProvider.downloadAndInstallUpdate(
                        GoRouter.of(
                              context,
                            ).routerDelegate.navigatorKey.currentContext ??
                            context,
                      );
                    },
                  ),
                ],
              ),
              severity: InfoBarSeverity.warning,
              onClose: () {
                if (mounted)
                  setState(() {
                    _isUpdateInfoBarVisible = false;
                  });
                close();
              },
              isLong: true,
            ),
          );
        },
        alignment: Alignment.topRight,
        duration: Duration(hours: 24),
      );
    } else if (!updateProvider.showUpdateInfobar && _isUpdateInfoBarVisible) {
      if (mounted)
        setState(() {
          _isUpdateInfoBarVisible = false;
        });
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = originalItems
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        if (location.startsWith('/settings?section=')) {
          indexFooter = footerItems
              .where((element) => element.key != null)
              .toList()
              .indexWhere((element) => element.key == const Key('/settings'));
          if (indexFooter != -1) {
            return originalItems
                    .where((element) => element.key != null)
                    .toList()
                    .length +
                indexFooter;
          }
        }
        return 0;
      }
      return originalItems
              .where((element) => element.key != null)
              .toList()
              .length +
          indexFooter;
    } else {
      return indexOriginal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = FluentLocalizations.of(context);
    final appTheme = context.watch<AppTheme>();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);

    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        leading: () {
          onPressed() {
            if (router.canPop()) {
              context.pop();
              setState(() {});
            }
          }

          return NavigationPaneTheme(
            data: NavigationPaneTheme.of(context).merge(
              NavigationPaneThemeData(
                unselectedIconColor: WidgetStateProperty.resolveWith((states) {
                  if (states.isDisabled) {
                    return ButtonThemeData.buttonColor(context, states);
                  }
                  return ButtonThemeData.uncheckedInputColor(
                    FluentTheme.of(context),
                    states,
                  ).basedOnLuminance();
                }),
              ),
            ),
            child: Builder(
              builder:
                  (context) => PaneItem(
                    icon: const Center(
                      child: Icon(FluentIcons.back, size: 12.0),
                    ),
                    title: Text(localizations.backButtonTooltip),
                    body: const SizedBox.shrink(),
                  ).build(
                    context,
                    false,
                    onPressed,
                    displayMode: PaneDisplayMode.compact,
                  ),
            ),
          );
        }(),
        title: () {
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            ),
          );
        }(),
        actions:
            isDesktop
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const WindowButtons()],
                )
                : null,
      ),
      paneBodyBuilder: (item, child) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        selected: _calculateSelectedIndex(context),
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
              return const StickyNavigationIndicator();
          }
        }(),
        items: originalItems,
        autoSuggestBox: Builder(
          builder: (context) {
            return TextBox(
              key: searchKey,
              focusNode: searchFocusNode,
              controller: searchController,
              unfocusedColor: Colors.transparent,
              placeholder: 'Search',
              onChanged: (text) {
                searchProvider.updateSearchQuery(text);
              },
              onSubmitted: (value) {
                if (searchController.text.isEmpty) {
                  return;
                }
                context.go('/repacklibrary');
                searchProvider.updateSearchQuery(searchController.text);
                searchFocusNode.unfocus();
              },
              suffix: IconButton(
                onPressed: () {
                  if (searchController.text.isEmpty) {
                    return;
                  }
                  context.go('/repacklibrary');
                  searchProvider.updateSearchQuery(searchController.text);
                  searchFocusNode.unfocus();
                },
                icon: const Icon(FluentIcons.search),
              ),
            );
          },
        ),
        autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        footerItems: footerItems,
      ),
      onOpenSearch: searchFocusNode.requestFocus,
    );
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose && mounted) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MyHomePage(
          shellContext: _shellNavigatorKey.currentContext,
          child: child,
        );
      },
      routes: <GoRoute>[
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/repacklibrary',
          builder: (context, state) {
            return const RepackLibrary();
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) {
            final String? section = state.uri.queryParameters['section'];
            return Settings(sectionToScrollTo: section);
          },
        ),
        GoRoute(
          path: '/downloadmanager',
          builder: (context, state) {
            return const DownloadManagerScreen();
          },
        ),
        GoRoute(
          path: '/repackdetails',
          builder: (context, state) {
            final repack = state.extra as Repack;
            return RepackDetails(selectedRepack: repack);
          },
        ),
      ],
    ),
  ],
);
