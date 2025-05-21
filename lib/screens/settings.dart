// ignore_for_file: constant_identifier_names

// import 'package:fit_flutter_fluent/widgets/changelog.dart';
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
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with PageMixin {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    // final theme = FluentTheme.of(context);

    const supportedLocales = FluentLocalizations.supportedLocales;
    final currentLocale =
        appTheme.locale ?? Localizations.maybeLocaleOf(context);
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      children: [
        // IconButton(
        //   onPressed: () {
        //     showDialog(
        //       context: context,
        //       barrierDismissible: true,
        //       builder: (context) => const Changelog(),
        //     );
        //   },
        //   icon: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'What\'s new on 4.0.0',
        //         style: theme.typography.body?.copyWith(
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       Text('June 21, 2022', style: theme.typography.caption),
        //       Text(
        //         'A native look-and-feel out of the box',
        //         style: theme.typography.bodyLarge,
        //       ),
        //     ],
        //   ),
        // ),
        Text('Default Download Path',
            style: FluentTheme.of(context).typography.subtitle),
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
        biggerSpacer,
        Text('Theme mode', style: FluentTheme.of(context).typography.subtitle),
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
        biggerSpacer,
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
        biggerSpacer,
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
        if (kIsWindowEffectsSupported) ...[
          biggerSpacer,
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
        ],
        biggerSpacer,
        Text('Locale', style: FluentTheme.of(context).typography.subtitle),
        spacer,
        Align(
          alignment: Alignment.centerLeft,
          child: ComboBox<Locale>(
            value: currentLocale,
            items:
                supportedLocales.map((locale) {
                  return ComboBoxItem(value: locale, child: Text('$locale'));
                }).toList(),
            onChanged: (locale) {
              if (locale != null) {
                appTheme.locale = locale;
              }
            },
          ),
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
