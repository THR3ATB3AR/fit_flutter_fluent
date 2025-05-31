// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:fit_flutter_fluent/providers/update_provider.dart';
import 'package:fit_flutter_fluent/services/scraper_service.dart';
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

  const Settings({super.key, this.sectionToScrollTo});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with PageMixin {
  final ScrollController _scrollController = ScrollController();
  GlobalKey? _currentlyHighlightedKey;
  Timer? _highlightTimer;

  final GlobalKey _downloadPathKey = GlobalKey();
  final GlobalKey _maxConcurrentDownloadsKey = GlobalKey();
  final GlobalKey _autoInstallSettingsKey = GlobalKey(); // New Key
  final GlobalKey _themeModeKey = GlobalKey();
  final GlobalKey _paneDisplayModeKey = GlobalKey();
  final GlobalKey _accentColorKey = GlobalKey();
  final GlobalKey _windowTransparencyKey = GlobalKey();
  final GlobalKey _localeKey = GlobalKey();
  final GlobalKey _dataManagementKey = GlobalKey();
  final GlobalKey _updateSettingsKey = GlobalKey();

  late final Map<String, GlobalKey> _sectionKeys;

  bool _isForceRescraping = false;
  String _forceRescrapeDialogStatus = "";
  double _forceRescrapeDialogProgress = 0.0;

  late Function(String) _updateForceRescrapeDialogStatusCallback = (status) {};
  late Function(double) _updateForceRescrapeDialogProgressCallback =
      (progress) {};

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      'downloadPath': _downloadPathKey,
      'maxConcurrentDownloads': _maxConcurrentDownloadsKey,
      'autoInstallSettings': _autoInstallSettingsKey, // Add new key
      'themeMode': _themeModeKey,
      'paneDisplayMode': _paneDisplayModeKey,
      'accentColor': _accentColorKey,
      'windowTransparency': _windowTransparencyKey,
      'locale': _localeKey,
      'dataManagement': _dataManagementKey,
      'updateSettings': _updateSettingsKey,
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final sectionToScroll = widget.sectionToScrollTo;
      if (sectionToScroll != null && sectionToScroll.isNotEmpty) {
        if (_sectionKeys.containsKey(sectionToScroll)) {
          _scrollToSection(_sectionKeys[sectionToScroll]!);
        }
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
          setState(() => _currentlyHighlightedKey = key);
          _highlightTimer = Timer(const Duration(seconds: 1), () {
            if (mounted) setState(() => _currentlyHighlightedKey = null);
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
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color:
            isHighlighted
                ? FluentTheme.of(context).accentColor.withValues(alpha: 0.2)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
        border:
            isHighlighted
                ? Border.all(
                  color: FluentTheme.of(
                    context,
                  ).accentColor.withValues(alpha: 0.3),
                  width: 1,
                )
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...children,
          if (addBiggerSpacerAfter) const SizedBox(height: 32.0),
        ],
      ),
    );
  }

  Future<void> _forceRescrapeAllData() async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => ContentDialog(
            title: const Text('Confirm Force Rescrape'),
            content: const Text(
              'This will delete ALL locally stored repack data and re-download everything from the source. '
              'This process can take a very long time and consume significant network data. Are you sure?',
            ),
            actions: [
              Button(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red.dark),
                ),
                child: const Text('Yes, Rescrape All'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          ),
    );

    if (result != true) return;

    if (!mounted) return;
    setState(() {
      _isForceRescraping = true;
    });
    _showForceRescrapeProgressDialog("Starting full data rescrape...");

    try {
      await ScraperService.instance.forceRescrapeEverything(
        onStatusUpdate: (status) {
          if (mounted) {
            _updateForceRescrapeDialogStatusCallback(status);
          }
        },
        onProgressUpdate: (progress) {
          if (mounted) {
            _updateForceRescrapeDialogProgressCallback(progress);
          }
        },
      );

      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Success'),
              content: const Text('All data has been forcefully rescraped.'),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.success,
            );
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during force rescrape: $e");
      }
      if (mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        _updateForceRescrapeDialogStatusCallback("Error: $e");
        displayInfoBar(
          context,
          builder: (context, close) {
            return InfoBar(
              title: const Text('Error'),
              content: Text('Failed to force rescrape data: $e'),
              action: IconButton(
                icon: const Icon(FluentIcons.clear),
                onPressed: close,
              ),
              severity: InfoBarSeverity.error,
            );
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isForceRescraping = false);
        ScraperService.instance.loadingProgress.value = 0.0;
      }
    }
  }

  void _showForceRescrapeProgressDialog(String initialMessage) {
    _forceRescrapeDialogStatus = initialMessage;
    _forceRescrapeDialogProgress = 0.0;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ContentDialog(
          title: const Text('Force Rescraping Data'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setDialogState) {
              _updateForceRescrapeDialogStatusCallback = (newStatus) {
                if (mounted && dialogContext.mounted) {
                  setDialogState(() => _forceRescrapeDialogStatus = newStatus);
                }
              };
              _updateForceRescrapeDialogProgressCallback = (newProgress) {
                if (mounted && dialogContext.mounted) {
                  setDialogState(
                    () => _forceRescrapeDialogProgress = newProgress,
                  );
                }
              };
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_forceRescrapeDialogStatus),
                  const SizedBox(height: 16),
                  ProgressBar(value: _forceRescrapeDialogProgress * 100),
                  const SizedBox(height: 8),
                  Text(
                    '${(_forceRescrapeDialogProgress * 100).toStringAsFixed(1)}% Complete',
                  ),
                  const SizedBox(height: 16),
                  const Center(child: ProgressRing()),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final appTheme = context.watch<AppTheme>();
    final updateProvider = context.watch<UpdateProvider>();
    const spacer = SizedBox(height: 10.0);
    const bigSpacer = SizedBox(height: 24.0);

    final supportedLocales = FluentLocalizations.supportedLocales;
    final currentLocale =
        appTheme.locale ?? Localizations.maybeLocaleOf(context);

    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Settings')),
      scrollController: _scrollController,
      children: [
        Text('Downloads & Installation', style: FluentTheme.of(context).typography.title),
        spacer,
        const Divider(
          style: DividerThemeData(horizontalMargin: EdgeInsets.zero),
        ),
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
              suffix: IconButton(
                icon: const Icon(FluentIcons.folder_open),
                onPressed: () async {
                  final path = await FilePicker.platform.getDirectoryPath();
                  if (path != null) {
                    appTheme.downloadPath = path;
                    // No need to call setState here as AppTheme provider will update
                  }
                },
              ),
            ),
          ),
        ], addBiggerSpacerAfter: false),
        _buildSectionWrapper(_maxConcurrentDownloadsKey, [
          Text(
            'Max Concurrent Downloads',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: IntrinsicWidth(
              child: NumberBox<int>(
                value: appTheme.maxConcurrentDownloads,
                mode: SpinButtonPlacementMode.inline,
                min: 1,
                max: 10,
                clearButton: false,
                onChanged: (value) {
                  if (value != null) {
                    appTheme.maxConcurrentDownloads = value;
                  }
                },
              ),
            ),
          ),
        ], addBiggerSpacerAfter: false),
        _buildSectionWrapper(_autoInstallSettingsKey, [
          Text(
            'Automatic Installation',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Row(
            children: [
              const Text('Enable Auto-Install after download:'),
              const SizedBox(width: 10),
              ToggleSwitch(
                checked: appTheme.autoInstall,
                onChanged: (v) {
                  appTheme.autoInstall = v;
                },
              ),
            ],
          ),
          spacer,
          Text(
            'Default Installation Path',
            style: FluentTheme.of(context).typography.caption, // Smaller text for label
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: TextBox(
              placeholder: 'Default Install Path',
              controller: TextEditingController(text: appTheme.installPath),
              enabled: appTheme.autoInstall, 
              suffix: IconButton(
                icon: const Icon(FluentIcons.folder_open),
                onPressed: appTheme.autoInstall 
                  ? () async {
                      final path = await FilePicker.platform.getDirectoryPath();
                      if (path != null) {
                        appTheme.installPath = path;
                      }
                    }
                  : null,
              ),
            ),
          ),
          spacer,
          InfoLabel(
            label: 'When enabled, completed repacks will attempt to install to the specified path.',
            isHeader: false,
          ),
        ], addBiggerSpacerAfter: false),
        bigSpacer,
        Text('Appearance', style: FluentTheme.of(context).typography.title),
        spacer,
        const Divider(
          style: DividerThemeData(horizontalMargin: EdgeInsets.zero),
        ),
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
                      child: Text(mode.toString().split('.').last.uppercaseFirst()),
                    );
                  }).toList(),
              onChanged: (mode) {
                if (mode != null) {
                  appTheme.mode = mode;
                  if (kIsWindowEffectsSupported) {
                    // Ensure context is available and mounted for setEffect
                    if (mounted) appTheme.setEffect(appTheme.windowEffect, context);
                  }
                }
              },
            ),
          ),
        ], addBiggerSpacerAfter: false),
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
                      child: Text(mode.toString().split('.').last.uppercaseFirst()),
                    );
                  }).toList(),
              onChanged: (mode) {
                if (mode != null) appTheme.displayMode = mode;
              },
            ),
          ),
        ], addBiggerSpacerAfter: false),
        _buildSectionWrapper(_accentColorKey, [
          Text(
            'Accent Color',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
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
        ], addBiggerSpacerAfter: false),
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
                        child: Text(effect.toString().split('.').last.uppercaseFirst()),
                      );
                    }).toList(),
                onChanged: (effect) {
                  if (effect != null) {
                    appTheme.windowEffect = effect;
                     if (mounted) appTheme.setEffect(effect, context);
                  }
                },
              ),
            ),
          ], addBiggerSpacerAfter: false),
        _buildSectionWrapper(_localeKey, [
          Text('Locale', style: FluentTheme.of(context).typography.subtitle),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: ComboBox<Locale>(
              value: currentLocale,
              items:
                  supportedLocales.map((locale) {
                    return ComboBoxItem(value: locale, child: Text('$locale'.toUpperCase()));
                  }).toList(),
              onChanged: (locale) {
                if (locale != null) {
                  appTheme.locale = locale;
                }
              },
            ),
          ),
        ], addBiggerSpacerAfter: false),
        bigSpacer,
        Text(
          'Application Updates',
          style: FluentTheme.of(context).typography.title,
        ),
        spacer,
        const Divider(
          style: DividerThemeData(horizontalMargin: EdgeInsets.zero),
        ),
        _buildSectionWrapper(_updateSettingsKey, [
          Text(
            'Update Check Frequency',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Align(
            alignment: Alignment.centerLeft,
            child: ComboBox<UpdateCheckFrequency>(
              value: updateProvider.updateCheckFrequency,
              items:
                  UpdateCheckFrequency.values.map((freq) {
                    String freqText = freq.toString().split('.').last;
                    if (freqText == "onStartup") {
                      freqText = "On Every Startup";
                    } else {
                      freqText =
                          freqText[0].toUpperCase() + freqText.substring(1);
                    }
                    return ComboBoxItem(value: freq, child: Text(freqText));
                  }).toList(),
              onChanged: (freq) {
                if (freq != null) {
                  updateProvider.setUpdateCheckFrequency(freq);
                }
              },
            ),
          ),
          spacer,
          Text(
            'Current App Version: ${updateProvider.currentAppVersion ?? "Loading..."}',
          ),
          if (updateProvider.latestReleaseInfo != null &&
              updateProvider.updateAvailable)
            Text(
              'Latest Available Version: ${updateProvider.latestReleaseInfo!['tag_name']}',
            )
          else if (updateProvider.latestReleaseInfo != null &&
              !updateProvider.updateAvailable &&
              !updateProvider.isCheckingForUpdates)
            Text(
              'You are on the latest version (${updateProvider.currentAppVersion ?? ""})',
            )
          else if (updateProvider.isCheckingForUpdates)
            const Text('Latest Available Version: Checking...')
          else if (updateProvider.errorMessage != null &&
              updateProvider.errorMessage!.contains(
                "latest version",
              ))
            Text('Latest Available Version: ${updateProvider.errorMessage}')
          else if (updateProvider.lastUpdateCheckTimestamp == 0 &&
              !updateProvider.isCheckingForUpdates)
            const Text('Latest Available Version: Not checked yet.')
          else if (!updateProvider
              .isCheckingForUpdates)
            const Text('Latest Available Version: Check to see.'),

          if (updateProvider.errorMessage != null &&
              !updateProvider.errorMessage!.contains("latest version"))
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Status: ${updateProvider.errorMessage}'),
            ),
          spacer,
          if (updateProvider.latestReleaseInfo != null &&
              updateProvider.updateAvailable &&
              updateProvider.latestReleaseInfo!['tag_name'] ==
                  updateProvider.ignoredVersion)
            Row(
              children: [
                const Text('You have ignored this update.'),
                const SizedBox(width: 8),
                Button(
                  child: const Text('Unignore & Check Again'),
                  onPressed: () {
                    updateProvider.clearIgnoredVersion();
                    updateProvider.checkForUpdates(
                      forceCheck: true,
                      initiatedByUser: true,
                    );
                  },
                ),
              ],
            ),
          spacer,
          FilledButton(
            onPressed:
                updateProvider.isCheckingForUpdates
                    ? null
                    : () => updateProvider.checkForUpdates(
                      forceCheck: true,
                      initiatedByUser: true,
                    ),
            child:
                updateProvider.isCheckingForUpdates
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: 12,
                          height: 12,
                          child: ProgressRing(strokeWidth: 1.5),
                        ),
                        SizedBox(width: 8),
                        Text('Checking...'),
                      ],
                    )
                    : const Text('Check for Updates Now'),
          ),
          if (updateProvider.updateAvailable &&
              updateProvider.latestReleaseInfo?['tag_name'] !=
                  updateProvider.ignoredVersion) ...[
            spacer,
            Text(
              'An update to version ${updateProvider.latestReleaseInfo!['tag_name']} is available.',
              style: FluentTheme.of(context).typography.bodyStrong,
            ),
            spacer,
            Row(
              children: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green.lighter),
                  ),
                  onPressed: () {
                    updateProvider.downloadAndInstallUpdate(context);
                  },
                  child: const Text('Download and Install Update'),
                ),
                const SizedBox(width: 10),
                HyperlinkButton(
                  child: const Text('View Release Page'),
                  onPressed: () => updateProvider.openReleasePage(),
                ),
              ],
            ),
            if (updateProvider.latestReleaseInfo?['release_notes'] != null &&
                updateProvider
                    .latestReleaseInfo!['release_notes']!
                    .isNotEmpty) ...[
              spacer,
              Expander(
                header: const Text('View Release Notes'),
                content: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(
                      updateProvider.latestReleaseInfo!['release_notes']!,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ], addBiggerSpacerAfter: false),
        Text(
          'Data Management',
          style: FluentTheme.of(context).typography.title,
        ),
        spacer,
        const Divider(
          style: DividerThemeData(horizontalMargin: EdgeInsets.zero),
        ),
        _buildSectionWrapper(_dataManagementKey, [
          Text(
            'Force Rescrape All Data',
            style: FluentTheme.of(context).typography.subtitle,
          ),
          spacer,
          Text(
            'This will delete ALL locally stored repack data and re-download everything from the source. '
            'Warning: This process can take a very long time and consume significant network data. Use with caution.',
            style: FluentTheme.of(context).typography.body,
          ),
          spacer,
          FilledButton(
            onPressed: _isForceRescraping ? null : _forceRescrapeAllData,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.red.dark),
              padding: WidgetStatePropertyAll(
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
            child:
                _isForceRescraping
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: ProgressRing(strokeWidth: 2.0),
                        ),
                        SizedBox(width: 12),
                        Text('Rescraping... See Dialog'),
                      ],
                    )
                    : const Text('Force Rescrape All Data Now'),
          ),
        ], addBiggerSpacerAfter: false),
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
          padding: WidgetStatePropertyAll(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            final displayColor = color;
            if (states.isPressed) return displayColor.light;
            if (states.isHovered) return displayColor.lighter;
            return displayColor;
          }),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
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
                    size: 20.0,
                  )
                  : null,
        ),
      ),
    );
  }
}
