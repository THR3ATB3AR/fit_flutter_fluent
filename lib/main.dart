import 'package:fit_flutter_fluent/data/repack.dart';
import 'package:fit_flutter_fluent/screens/download_manager_screen.dart';
import 'package:fit_flutter_fluent/screens/home.dart';
import 'package:fit_flutter_fluent/screens/repack_details.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _appTheme.loadInitialSettings();
  await RepackService.instance.init();

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

    await windowManager.show();
    await windowManager.focus();

    runApp(const MyApp());
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _appTheme,
      builder: (context, child) {
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
                                      flutter_acrylic.WindowEffect.transparent)
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

  // int index = 0;

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
        // ignore: unnecessary_type_check
        if (e is PaneItem) return buildPaneItem(e);
        return e;
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
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
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
    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        leading: () {
          // final enabled = widget.shellContext != null && router.canPop();
          final enabled = true;

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
                    enabled: enabled,
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
        actions: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [const WindowButtons()],
        ),
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
            return AutoSuggestBox(
              key: searchKey,
              focusNode: searchFocusNode,
              controller: searchController,
              unfocusedColor: Colors.transparent,
              // also need to include sub items from [PaneItemExpander] items
              items:
                  <PaneItem>[
                    ...originalItems
                        .whereType<PaneItemExpander>()
                        .expand<PaneItem>((item) {
                          return [item, ...item.items.whereType<PaneItem>()];
                        }),
                    ...originalItems
                        .where(
                          (item) =>
                              item is PaneItem && item is! PaneItemExpander,
                        )
                        .cast<PaneItem>(),
                  ].map((item) {
                    assert(item.title is Text);
                    final text = (item.title as Text).data!;
                    return AutoSuggestBoxItem(
                      label: text,
                      value: text,
                      onSelected: () {
                        item.onTap?.call();
                        searchController.clear();
                        searchFocusNode.unfocus();
                        final view = NavigationView.of(context);
                        if (view.compactOverlayOpen) {
                          view.compactOverlayOpen = false;
                        } else if (view.minimalPaneOpen) {
                          view.minimalPaneOpen = false;
                        }
                      },
                    );
                  }).toList(),
              trailingIcon: IgnorePointer(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(FluentIcons.search),
                ),
              ),
              placeholder: 'Search',
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
        /// Home
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
  path: '/settings',
  builder: (BuildContext context, GoRouterState state) {
    final String? section = state.uri.queryParameters['section']; // Odczytaj parametr 'section'
    return Settings(sectionToScrollTo: section); // Przekaż go do widgetu Settings
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
