import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_flutter_fluent/services/updater_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:url_launcher/url_launcher.dart';

enum UpdateCheckFrequency { manual, onStartup, daily, weekly }

class UpdateProvider extends ChangeNotifier {
  static const String _kUpdateCheckFrequency = 'app_update_check_frequency';
  static const String _kLastUpdateCheckTimestamp = 'app_last_update_check_timestamp';
  static const String _kIgnoredVersion = 'app_ignored_update_version';

  final UpdaterService _updaterService = UpdaterService();
  SharedPreferences? _prefs;

  UpdateCheckFrequency _updateCheckFrequency = UpdateCheckFrequency.daily;
  UpdateCheckFrequency get updateCheckFrequency => _updateCheckFrequency;

  int _lastUpdateCheckTimestamp = 0;
  int get lastUpdateCheckTimestamp => _lastUpdateCheckTimestamp;

  bool _isCheckingForUpdates = false;
  bool get isCheckingForUpdates => _isCheckingForUpdates;

  bool _updateAvailable = false;
  bool get updateAvailable => _updateAvailable;

  Map<String, String>? _latestReleaseInfo;
  Map<String, String>? get latestReleaseInfo => _latestReleaseInfo;

  String? _currentAppVersion;
  String? get currentAppVersion => _currentAppVersion;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _ignoredVersion;
  String? get ignoredVersion => _ignoredVersion; 

  bool _showUpdateInfobar = false;
  bool get showUpdateInfobar => _showUpdateInfobar;

  UpdateProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadSettings();
    await _getAppVersion(); 
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    final freqIndex = _prefs!.getInt(_kUpdateCheckFrequency);
    if (freqIndex != null && freqIndex >= 0 && freqIndex < UpdateCheckFrequency.values.length) {
      _updateCheckFrequency = UpdateCheckFrequency.values[freqIndex];
    } else {
      _updateCheckFrequency = UpdateCheckFrequency.daily; 
    }
    _lastUpdateCheckTimestamp = _prefs!.getInt(_kLastUpdateCheckTimestamp) ?? 0;
    _ignoredVersion = _prefs!.getString(_kIgnoredVersion);
    notifyListeners(); 
  }

  Future<void> _getAppVersion() async {
    _currentAppVersion = await _updaterService.getAppVersion();
    notifyListeners();
  }

  Future<void> setUpdateCheckFrequency(UpdateCheckFrequency frequency) async {
    _updateCheckFrequency = frequency;
    await _prefs?.setInt(_kUpdateCheckFrequency, frequency.index);
    notifyListeners();
  }

  Future<void> checkForUpdates({bool forceCheck = false, bool initiatedByUser = false}) async {
    if (_isCheckingForUpdates && !forceCheck) return;

    _isCheckingForUpdates = true;
    _errorMessage = null;
    if (initiatedByUser) {
      _showUpdateInfobar = false; 
    }
    notifyListeners();

    final now = DateTime.now().millisecondsSinceEpoch;
    bool shouldCheck = false;

    if (forceCheck || initiatedByUser) {
      shouldCheck = true;
    } else {
      if (_updateCheckFrequency == UpdateCheckFrequency.manual) {
        _isCheckingForUpdates = false;
        notifyListeners();
        return;
      }
      switch (_updateCheckFrequency) {
        case UpdateCheckFrequency.manual:
          break;
        case UpdateCheckFrequency.onStartup:
          shouldCheck = true;
          break;
        case UpdateCheckFrequency.daily:
          shouldCheck = (now - _lastUpdateCheckTimestamp > const Duration(days: 1).inMilliseconds);
          break;
        case UpdateCheckFrequency.weekly:
          shouldCheck = (now - _lastUpdateCheckTimestamp > const Duration(days: 7).inMilliseconds);
          break;
      }
    }

    if (!shouldCheck) {
      _isCheckingForUpdates = false;
      if (_updateAvailable && _latestReleaseInfo?['tag_name'] != _ignoredVersion) {
          _showUpdateInfobar = true;
      } else {
          _showUpdateInfobar = false;
      }
      notifyListeners();
      return;
    }

    try {
      _latestReleaseInfo = await _updaterService.getLatestReleaseInfo();
      final latestVersionTag = _latestReleaseInfo?['tag_name'];

      if (latestVersionTag != null) {
        final latestVersion = latestVersionTag.startsWith('v') ? latestVersionTag.substring(1) : latestVersionTag;
        _currentAppVersion ??= await _updaterService.getAppVersion();

        _updateAvailable = latestVersion != _currentAppVersion;

        if (_updateAvailable) {
          _showUpdateInfobar = latestVersionTag != _ignoredVersion;
        } else {
          _showUpdateInfobar = false;
           if (initiatedByUser) { 
            _errorMessage = "You are already on the latest version.";
          }
        }
      } else {
        _updateAvailable = false;
        _showUpdateInfobar = false;
        _errorMessage = "Could not parse latest version tag.";
      }

      _lastUpdateCheckTimestamp = now;
      await _prefs?.setInt(_kLastUpdateCheckTimestamp, _lastUpdateCheckTimestamp);
    } catch (e) {
      print('Error checking for updates: $e');
      _errorMessage = 'Failed to check for updates. ${e.toString().split(":").last.trim()}';
      _updateAvailable = false;
      _showUpdateInfobar = false;
    } finally {
      _isCheckingForUpdates = false;
      notifyListeners();
    }
  }

  Future<void> ignoreCurrentUpdate() async {
    if (_latestReleaseInfo != null && _latestReleaseInfo!['tag_name'] != null) {
      _ignoredVersion = _latestReleaseInfo!['tag_name'];
      await _prefs?.setString(_kIgnoredVersion, _ignoredVersion!);
      _showUpdateInfobar = false;
      notifyListeners();
    }
  }

  Future<void> clearIgnoredVersion() async {
     _ignoredVersion = null;
     await _prefs?.remove(_kIgnoredVersion);
     if (_updateAvailable && _latestReleaseInfo?['tag_name'] != _ignoredVersion) {
       _showUpdateInfobar = true;
     }
     notifyListeners();
  }

  Future<void> downloadAndInstallUpdate(BuildContext context) async {
    if (!_updateAvailable || _latestReleaseInfo == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => ContentDialog(
        constraints: const BoxConstraints(minWidth: 300, maxWidth: 400), 
        title: const Text('Update Confirmation'),
        content: Text(
          'Version ${_latestReleaseInfo!['tag_name']} is ready to be downloaded and installed.\n'
          'The application will close and the installer will run. Do you want to proceed?',
        ),
        actions: [
          Button(child: const Text('Later'), onPressed: () => Navigator.pop(ctx, false)),
          FilledButton(child: const Text('Download & Install'), onPressed: () => Navigator.pop(ctx, true)),
        ],
      ),
    );

    if (confirmed != true) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const ContentDialog(
        constraints: BoxConstraints(minWidth: 250, maxWidth: 350, maxHeight: 200), 
        title: Text('Downloading Update'),
        content: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProgressRing(),
            SizedBox(height: 16),
            Text('Please wait... The app will close automatically after download.'),
          ],
        )),
      ),
    );

    try {
      final filePath = await _updaterService.downloadLatestRelease();
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

      await _updaterService.runDownloadedSetup(filePath);
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        await windowManager.destroy();
      } else {
        exit(0); 
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();
      // ignore: use_build_context_synchronously
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => ContentDialog(
            title: const Text('Update Failed'),
            content: Text('Error during update: $e'),
            actions: [Button(child: const Text('OK'), onPressed: () => Navigator.pop(ctx))],
          ),
        );
      }
      print('Error downloading/installing update: $e');
    }
  }

  Future<void> openReleasePage() async {
    if (_latestReleaseInfo != null && _latestReleaseInfo!['tag_name'] != null) {
      final tagName = _latestReleaseInfo!['tag_name'];
      final url = Uri.parse('https://github.com/${UpdaterService.githubRepo}/releases/tag/$tagName');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _errorMessage = 'Could not open release page.';
        notifyListeners();
      }
    }
  }
}