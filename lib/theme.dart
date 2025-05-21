import 'package:fit_flutter_fluent/screens/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:system_theme/system_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

enum NavigationIndicators { sticky, end }

class AppTheme extends ChangeNotifier {
  static const String _kAccentColorName = 'apptheme_accent_color_name';
  static const String _kThemeMode = 'apptheme_theme_mode';
  static const String _kPaneDisplayMode = 'apptheme_pane_display_mode';
  static const String _kNavigationIndicator = 'apptheme_navigation_indicator';
  static const String _kWindowEffect = 'apptheme_window_effect';
  static const String _kTextDirection = 'apptheme_text_direction';
  static const String _kLocale = 'apptheme_locale';

  AccentColor? explicitAccentColor;
  bool get isSystemAccentSelected => explicitAccentColor == null;

  AccentColor get color => explicitAccentColor ?? systemAccentColor;

  set color(AccentColor newColor) {
    explicitAccentColor = newColor;
    _saveAccentColorPreference();
    notifyListeners();
  }

  void setSystemAccentColor() {
    explicitAccentColor = null;
    _saveAccentColorPreference();
    notifyListeners();
  }

  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    _saveThemeMode(mode);
    notifyListeners();
  }

  PaneDisplayMode _displayMode = PaneDisplayMode.auto;
  PaneDisplayMode get displayMode => _displayMode;
  set displayMode(PaneDisplayMode displayMode) {
    _displayMode = displayMode;
    _savePaneDisplayMode(displayMode);
    notifyListeners();
  }

  NavigationIndicators _indicator = NavigationIndicators.sticky;
  NavigationIndicators get indicator => _indicator;
  set indicator(NavigationIndicators indicator) {
    _indicator = indicator;
    _saveNavigationIndicator(indicator);
    notifyListeners();
  }

  WindowEffect _windowEffect = WindowEffect.disabled;
  WindowEffect get windowEffect => _windowEffect;
  set windowEffect(WindowEffect windowEffect) {
    _windowEffect = windowEffect;
    _saveWindowEffect(windowEffect);
    notifyListeners();
  }

  TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection;
  set textDirection(TextDirection direction) {
    _textDirection = direction;
    _saveTextDirection(direction);
    notifyListeners();
  }

  Locale? _locale;
  Locale? get locale => _locale;
  set locale(Locale? locale) {
    _locale = locale;
    _saveLocale(locale);
    notifyListeners();
  }

  Future<void> _saveAccentColorPreference() async {
    final prefs = await SharedPreferences.getInstance();
    if (explicitAccentColor == null) {
      await prefs.setString(_kAccentColorName, accentColorNames[0]);
    } else {
      int predefinedIndex = Colors.accentColors.indexWhere(
        (c) => c.value == explicitAccentColor!.value,
      );
      if (predefinedIndex != -1) {
        if ((predefinedIndex + 1) < accentColorNames.length) {
          await prefs.setString(
            _kAccentColorName,
            accentColorNames[predefinedIndex + 1],
          );
        } else {
          await prefs.setString(_kAccentColorName, accentColorNames[0]);
        }
      } else {
        await prefs.setString(_kAccentColorName, accentColorNames[0]);
      }
    }
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThemeMode, mode.index);
  }

  Future<void> _savePaneDisplayMode(PaneDisplayMode displayMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kPaneDisplayMode, displayMode.index);
  }

  Future<void> _saveNavigationIndicator(NavigationIndicators indicator) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kNavigationIndicator, indicator.index);
  }

  Future<void> _saveWindowEffect(WindowEffect effect) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kWindowEffect, effect.toString());
  }

  Future<void> _saveTextDirection(TextDirection direction) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kTextDirection, direction.index);
  }

  Future<void> _saveLocale(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale != null) {
      await prefs.setString(_kLocale, locale.toString());
    } else {
      await prefs.remove(_kLocale);
    }
  }

  bool _initialEffectAppliedOnStartup = false;

  // Normal settings

  static const String _kDownloadPath = 'download_path';

  String _downloadPath = '';
  String get downloadPath => _downloadPath;
  set downloadPath(String path) {
    _downloadPath = path;
    _saveDownloadPath(path);
    notifyListeners();
  }

  Future<void> _saveDownloadPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDownloadPath, path);
  }

  Future<void> loadInitialSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final savedColorName = prefs.getString(_kAccentColorName);
    if (savedColorName == null || savedColorName == accentColorNames[0]) {
      explicitAccentColor = null;
    } else {
      int colorNameIndex = accentColorNames.indexOf(savedColorName);
      if (colorNameIndex > 0 &&
          (colorNameIndex - 1) < Colors.accentColors.length) {
        explicitAccentColor = Colors.accentColors[colorNameIndex - 1];
      } else {
        explicitAccentColor = null;
      }
    }

    final themeModeIndex = prefs.getInt(_kThemeMode);
    if (themeModeIndex != null && themeModeIndex < ThemeMode.values.length) {
      _mode = ThemeMode.values[themeModeIndex];
    }

    final displayModeIndex = prefs.getInt(_kPaneDisplayMode);
    if (displayModeIndex != null &&
        displayModeIndex < PaneDisplayMode.values.length) {
      _displayMode = PaneDisplayMode.values[displayModeIndex];
    }

    final indicatorIndex = prefs.getInt(_kNavigationIndicator);
    if (indicatorIndex != null &&
        indicatorIndex < NavigationIndicators.values.length) {
      _indicator = NavigationIndicators.values[indicatorIndex];
    }

    final windowEffectString = prefs.getString(_kWindowEffect);
    if (windowEffectString != null) {
      try {
        _windowEffect = WindowEffect.values.firstWhere(
          (effect) => effect.toString() == windowEffectString,
          orElse: () => WindowEffect.disabled,
        );
      } catch (e) {
        _windowEffect = WindowEffect.disabled;
      }
    }
    _initialEffectAppliedOnStartup = false;

    final textDirectionIndex = prefs.getInt(_kTextDirection);
    if (textDirectionIndex != null &&
        textDirectionIndex < TextDirection.values.length) {
      _textDirection = TextDirection.values[textDirectionIndex];
    }

    final localeString = prefs.getString(_kLocale);
    if (localeString != null && localeString.isNotEmpty) {
      if (localeString.contains('_')) {
        final parts = localeString.split('_');
        if (parts.length == 2) _locale = Locale(parts[0], parts[1]);
      } else {
        _locale = Locale(localeString);
      }
    }

    // normal settings

    final String? downloadPath = prefs.getString(_kDownloadPath);
    if (downloadPath != null) {
      _downloadPath = downloadPath;
    } else {
      _downloadPath = '';
    }
  }

  void applyInitialWindowEffectIfNeeded(BuildContext context) {
    if (kIsWindowEffectsSupported && !_initialEffectAppliedOnStartup) {
      if (_windowEffect != WindowEffect.disabled) {
        setEffect(_windowEffect, context);
      }
      _initialEffectAppliedOnStartup = true;
    } else if (!_initialEffectAppliedOnStartup) {
      _initialEffectAppliedOnStartup = true;
    }
  }

  void setEffect(WindowEffect effect, BuildContext context) {
    final theme = FluentTheme.of(context);
    Color effectColor;

    if (effect == WindowEffect.acrylic) {
      effectColor = theme.menuColor.withOpacity(0.6);
    } else if (effect == WindowEffect.solid) {
      effectColor = theme.micaBackgroundColor;
    } else {
      effectColor = Colors.transparent;
    }

    Window.setEffect(
      effect: effect,
      color: effectColor,
      dark: theme.brightness.isDark,
    );
  }
}

AccentColor get systemAccentColor {
  if ((defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.android) &&
      !kIsWeb) {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
  return Colors.blue;
}
