import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fit_flutter_fluent/theme.dart';
import 'package:fit_flutter_fluent/widgets/page.dart';

const List<String> accentColorNames = [
  'System',
  'Yellow',
  'Orange',
  'Red',
  'Magenta',
  'Purple',
  'Blue',
  'Teal',
  'Green',
];

bool get kIsWindowEffectsSupported {
  return !kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.linux,
        TargetPlatform.macOS,
      ].contains(defaultTargetPlatform);
}

const _LinuxWindowEffects = [WindowEffect.disabled, WindowEffect.transparent];

const _WindowsWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.solid,
  WindowEffect.transparent,
  WindowEffect.aero,
  WindowEffect.acrylic,
  WindowEffect.mica,
  WindowEffect.tabbed,
];

const _MacosWindowEffects = [
  WindowEffect.disabled,
  WindowEffect.titlebar,
  WindowEffect.selection,
  WindowEffect.menu,
  WindowEffect.popover,
  WindowEffect.sidebar,
  WindowEffect.headerView,
  WindowEffect.sheet,
  WindowEffect.windowBackground,
  WindowEffect.hudWindow,
  WindowEffect.fullScreenUI,
  WindowEffect.toolTip,
  WindowEffect.contentBackground,
  WindowEffect.underWindowBackground,
  WindowEffect.underPageBackground,
];

List<WindowEffect> get currentWindowEffects {
  if (kIsWeb) return [];

  if (defaultTargetPlatform == TargetPlatform.windows) {
    return _WindowsWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    return _LinuxWindowEffects;
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    return _MacosWindowEffects;
  }

  return [];
}

class Settings extends StatefulWidget {
  final String? sectionToScrollTo; 

  const Settings({
    super.key,
    this.sectionToScrollTo,
  }); 

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with PageMixin {
  final ScrollController _scrollController = ScrollController();
  GlobalKey? _currentlyHighlightedKey;
  Timer? _highlightTimer;

  final GlobalKey _downloadPathKey = GlobalKey();
  final GlobalKey _maxConcurrentDownloadsKey = GlobalKey();
  final GlobalKey _themeModeKey = GlobalKey();
  final GlobalKey _paneDisplayModeKey = GlobalKey();
  final GlobalKey _accentColorKey = GlobalKey();
  final GlobalKey _windowTransparencyKey = GlobalKey();
  final GlobalKey _localeKey = GlobalKey();

  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      'downloadPath': _downloadPathKey,
      'maxConcurrentDownloads': _maxConcurrentDownloadsKey,
      'themeMode': _themeModeKey,
      'paneDisplayMode': _paneDisplayModeKey,
      'accentColor': _accentColorKey,
      'windowTransparency': _windowTransparencyKey,
      'locale':
          _localeKey, 
    };

    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      } 

      final sectionToScroll = widget.sectionToScrollTo;
      debugPrint(
        '[Settings initState - postFrameCallback] sectionToScrollTo: "$sectionToScroll"',
      );

      if (sectionToScroll != null && sectionToScroll.isNotEmpty) {
        if (_sectionKeys.containsKey(sectionToScroll)) {
          debugPrint(
            '[Settings initState - postFrameCallback] Found key for section "$sectionToScroll". Attempting to scroll.',
          );
          _scrollToSection(_sectionKeys[sectionToScroll]!);
        } else {
          debugPrint(
            '[Settings initState - postFrameCallback] WARN: Section key "$sectionToScroll" not found in _sectionKeys. Available keys: ${_sectionKeys.keys.join(', ')}',
          );
        }
      } else {
        debugPrint(
          '[Settings initState - postFrameCallback] No section specified or section is empty. Not scrolling.',
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _highlightTimer?.cancel();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    _highlightTimer?.cancel(); 

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.0, 
      ).then((_) {
        
        if (mounted) {
          setState(() {
            _currentlyHighlightedKey = key;
          });
          _highlightTimer = Timer(const Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                _currentlyHighlightedKey = null;
              });
            }
          });
        }
      });
    }
  }

  Widget _buildSectionWrapper(
    GlobalKey key,
    List<Widget> children, {
    bool addBiggerSpacerAfter = true,
  }) {
    bool isHighlighted = _currentlyHighlightedKey == key;
    return Container(
      key: key, 
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color:
            isHighlighted
                ? FluentTheme.of(context).accentColor.withValues(alpha: 0.2)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
        border:
            isHighlighted
                ? Border.all(
                  color: Colors.transparent,
                  width: 1,
                )
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children,
          if (addBiggerSpacerAfter)
            const SizedBox(height: 40.0 - 8.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    const spacer = SizedBox(height: 10.0);

    const supportedLocales = FluentLocalizations.supportedLocales;
    final currentLocale =
        appTheme.locale ?? Localizations.maybeLocaleOf(context);

    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      scrollController: _scrollController, 
      children: [
        _buildSectionWrapper(_downloadPathKey, [
          Text(
            'Default Download Path',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: TextBox(
              placeholder: 'Default Download Path',
              controller: TextEditingController(text: appTheme.downloadPath),
              onChanged: (value) {
                appTheme.downloadPath = value;
              },
              suffix: IconButton(
                icon: const Icon(FluentIcons.folder),
                onPressed: () async {
                  final path = await FilePicker.platform.getDirectoryPath();
                  if (path != null) {
                    appTheme.downloadPath = path;
                  }
                },
              ),
            ),
          ),
        ]),
        _buildSectionWrapper(_maxConcurrentDownloadsKey, [
          Text(
            'Max Concurrent Downloads',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: IntrinsicWidth(
              child: NumberBox(
                value: appTheme.maxConcurrentDownloads,
                mode: SpinButtonPlacementMode.inline,
                min: 1,
                clearButton: false,
                onChanged: (value) {
                  if (value != null) {
                    appTheme.maxConcurrentDownloads = value;
                  }
                },
              ),
            ),
          ),
        ]),
        _buildSectionWrapper(_themeModeKey, [
          Text(
            'Theme mode',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: ComboBox<ThemeMode>(
              value: appTheme.mode,
              items:
                  ThemeMode.values.map((mode) {
                    return ComboBoxItem(
                      value: mode,
                      child: Text('$mode'.replaceAll('ThemeMode.', '')),
                    );
                  }).toList(),
              onChanged: (mode) {
                if (mode != null) {
                  appTheme.mode = mode;
                  if (kIsWindowEffectsSupported) {
                    appTheme.setEffect(appTheme.windowEffect, context);
                  }
                }
              },
            ),
          ),
        ]),
        _buildSectionWrapper(_paneDisplayModeKey, [
          Text(
            'Navigation Pane Display Mode',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: ComboBox<PaneDisplayMode>(
              value: appTheme.displayMode,
              items:
                  PaneDisplayMode.values.map((mode) {
                    return ComboBoxItem(
                      value: mode,
                      child: Text(
                        mode.toString().replaceAll('PaneDisplayMode.', ''),
                      ),
                    );
                  }).toList(),
              onChanged: (mode) {
                if (mode != null) appTheme.displayMode = mode;
              },
            ),
          ),
        ]),
        _buildSectionWrapper(_accentColorKey, [
          Text(
            'Accent Color',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Tooltip(
                message: accentColorNames[0],
                child: _buildColorBlock(
                  appTheme,
                  systemAccentColor,
                  isSystemColor: true,
                ),
              ),
              ...List.generate(Colors.accentColors.length, (index) {
                final color = Colors.accentColors[index];
                return Tooltip(
                  message: accentColorNames[index + 1],
                  child: _buildColorBlock(appTheme, color),
                );
              }),
            ],
          ),
        ]),
        if (kIsWindowEffectsSupported)
          _buildSectionWrapper(_windowTransparencyKey, [
            Text(
              'Window Transparency',
              style: FluentTheme.of(context).typography.subtitle,
            ),
            spacer,
            Align(
              alignment: Alignment.centerLeft,
              child: ComboBox<WindowEffect>(
                value: appTheme.windowEffect,
                items:
                    currentWindowEffects.map((effect) {
                      return ComboBoxItem(
                        value: effect,
                        child: Text(
                          effect.toString().replaceAll('WindowEffect.', ''),
                        ),
                      );
                    }).toList(),
                onChanged: (effect) {
                  if (effect != null) {
                    appTheme.windowEffect = effect;
                    appTheme.setEffect(effect, context);
                  }
                },
              ),
            ),
          ]),
        _buildSectionWrapper(
          _localeKey,
          [
            Text('Locale', style: FluentTheme.of(context).typography.subtitle),
            spacer,
            Align(
              alignment: Alignment.centerLeft,
              child: ComboBox<Locale>(
                value: currentLocale,
                items:
                    supportedLocales.map((locale) {
                      return ComboBoxItem(
                        value: locale,
                        child: Text('$locale'),
                      );
                    }).toList(),
                onChanged: (locale) {
                  if (locale != null) {
                    appTheme.locale = locale;
                  }
                },
              ),
            ),
          ],
          addBiggerSpacerAfter: false,
        ),
      ],
    );
  }
  Widget _buildColorBlock(
    AppTheme appTheme,
    AccentColor color, {
    bool isSystemColor = false,
  }) {
    bool isSelected;
    if (isSystemColor) {
      isSelected = appTheme.isSystemAccentSelected;
    } else {
      isSelected = appTheme.explicitAccentColor?.value == color.value;
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Button(
        onPressed: () {
          if (isSystemColor) {
            appTheme.setSystemAccentColor();
          } else {
            appTheme.color = color;
          }
        },
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            final displayColor = color;
            if (states.isPressed) return displayColor.light;
            if (states.isHovered) return displayColor.lighter;
            return displayColor;
          }),
        ),
        child: Container(
          height: 40,
          width: 40,
          alignment: AlignmentDirectional.center,
          child:
              isSelected
                  ? Icon(
                    FluentIcons.check_mark,
                    color: color.basedOnLuminance(),
                    size: 22.0,
                  )
                  : null,
        ),
      ),
    );
  }
}

