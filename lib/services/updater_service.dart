import 'dart:convert';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart'; 
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:device_info_plus/device_info_plus.dart';

class UpdaterService {
  static const String githubRepo = 'THR3ATB3AR/fit_flutter_fluent';
  static const String _githubApiBaseUrl = 'https://api.github.com';

  Future<Map<String, dynamic>> getLatestReleaseData() async {
    final url = '$_githubApiBaseUrl/repos/$githubRepo/releases/latest';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 403) {
        debugPrint(
          'GitHub API rate limit likely exceeded. Headers: ${response.headers}',
        );
        throw Exception(
          'GitHub API rate limit exceeded. Please try again later.',
        );
      } else {
        throw Exception(
          'Failed to fetch latest release info from GitHub (Status ${response.statusCode})',
        );
      }
    } catch (e) {
      debugPrint("Error in getLatestReleaseData: $e");
      rethrow;
    }
  }

  Future<Map<String, String>> getLatestReleaseInfo() async {
    final jsonResponse = await getLatestReleaseData();
    final tagName = jsonResponse['tag_name'] as String?;
    final releaseNotes = jsonResponse['body'] as String?;

    if (tagName == null) {
      throw Exception('Tag name not found in release data.');
    }

    return {
      'tag_name': tagName,
      'release_notes': releaseNotes ?? 'No release notes provided.',
    };
  }

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<bool> isUpdateAvailable() async {
    try {
      final latestReleaseInfo = await getLatestReleaseInfo();
      final latestVersionTag = latestReleaseInfo['tag_name'];
      if (latestVersionTag == null) return false;

      final latestVersion =
          latestVersionTag.startsWith('v')
              ? latestVersionTag.substring(1)
              : latestVersionTag;
      final appVersion = await getAppVersion();

      return latestVersion != appVersion;
    } catch (e) {
      debugPrint("Error in isUpdateAvailable: $e");
      return false;
    }
  }

  Future<String> _getLinuxArchSuffixForAsset() async {
    if (!Platform.isLinux) return ''; 

    try {
      final result = await Process.run('uname', ['-m']);
      if (result.exitCode == 0) {
        final arch = (result.stdout as String).trim().toLowerCase();
        if (arch == 'x86_64' || arch == 'amd64') {
          return 'x86_64';
        } else if (arch == 'aarch64' || arch == 'arm64') {
          return 'aarch64'; 
        } else {
          debugPrint(
            'Unsupported Linux architecture: $arch. Cannot determine asset.',
          );
          throw Exception('Unsupported Linux architecture for update: $arch');
        }
      } else {
        debugPrint('Failed to determine Linux architecture: ${result.stderr}');
        throw Exception(
          'Failed to determine Linux architecture (uname -m failed).',
        );
      }
    } catch (e) {
      debugPrint('Error determining Linux architecture: $e');
      rethrow;
    }
  }

  Future<String> downloadLatestRelease() async {
    final jsonResponse = await getLatestReleaseData();
    final List<dynamic> releaseAssets =
        jsonResponse['assets'] as List<dynamic>? ?? [];
    final String releaseVersion = (jsonResponse['tag_name'] as String? ?? '')
        .replaceFirst('v', '');

    if (releaseAssets.isEmpty) {
      throw Exception('No assets found in the latest release.');
    }
    if (releaseVersion.isEmpty) {
      throw Exception('Could not determine release version from tag_name.');
    }

    Map<String, dynamic>? assetData;

    try {
      if (Platform.isWindows) {
        final expectedAssetName =
            'fit-flutter-setup-win64-$releaseVersion.exe'.toLowerCase();
        debugPrint('Checking for Windows asset: $expectedAssetName');
        assetData = releaseAssets.firstWhere(
          (asset) =>
              (asset['name'] as String?)?.toLowerCase() == expectedAssetName,
          orElse: () => null,
        );
        if (assetData == null) {
          final availableAssetNames =
              releaseAssets.map((a) => a['name'] as String?).toList();
          throw Exception(
            'Windows setup installer (expected: $expectedAssetName) not found in release assets. Available: $availableAssetNames',
          );
        }
      } else if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;
        final supportedAbis =
            androidInfo
                .supportedAbis; 
        debugPrint('Device supported ABIs: $supportedAbis');

        final preferredAbiOrder = ['arm64-v8a', 'armeabi-v7a', 'x86_64', 'x86'];

        for (final abi in preferredAbiOrder) {
          if (supportedAbis.contains(abi)) {
            final expectedAssetName =
                'fitflutterfluent-android-$releaseVersion-$abi.apk'
                    .toLowerCase();
            debugPrint('Checking for Android asset: $expectedAssetName');
            assetData = releaseAssets.firstWhere(
              (asset) =>
                  (asset['name'] as String?)?.toLowerCase() ==
                  expectedAssetName,
              orElse: () => null,
            );
            if (assetData != null) {
              debugPrint(
                'Found matching Android asset for ABI $abi: ${assetData['name']}',
              );
              break; 
            }
          }
        }
        if (assetData == null) {
          final availableAssetNames =
              releaseAssets.map((a) => a['name'] as String?).toList();
          throw Exception(
            "No suitable APK found for your device's architecture (${supportedAbis.join(', ')}). "
            "Release version: $releaseVersion. Searched for names like 'fitflutterfluent-android-$releaseVersion-[ABI].apk'. "
            "Available assets in release: $availableAssetNames",
          );
        }
      } else if (Platform.isLinux) {
        final archSuffix =
            await _getLinuxArchSuffixForAsset(); 
        final expectedAssetName =
            'fit-flutter-fluent-$releaseVersion-$archSuffix.appimage'
                .toLowerCase();
        debugPrint('Checking for Linux asset: $expectedAssetName');
        assetData = releaseAssets.firstWhere(
          (asset) =>
              (asset['name'] as String?)?.toLowerCase() == expectedAssetName,
          orElse: () => null,
        );
        if (assetData == null) {
          final availableAssetNames =
              releaseAssets.map((a) => a['name'] as String?).toList();
          throw Exception(
            'Suitable Linux AppImage (expected: $expectedAssetName) for $archSuffix not found. Available: $availableAssetNames',
          );
        }
      } else if (Platform.isMacOS) {
        throw UnsupportedError('Update for macOS is not yet implemented.');
      } else {
        throw UnsupportedError('Unsupported platform for update.');
      }
    } catch (e) {
      debugPrint("Error identifying asset: $e");
      if (e is Exception || e is UnsupportedError || e is ArgumentError) {
        rethrow;
      }
      throw Exception(
        'Failed to identify a suitable release asset: ${e.toString()}',
      );
    }

    final downloadUrl = assetData['browser_download_url'] as String?;
    final fileName = assetData['name'] as String?;

    if (downloadUrl == null || fileName == null) {
      throw Exception(
        'Asset download URL or name is missing from identified asset data.',
      );
    }

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}${Platform.pathSeparator}$fileName';

    debugPrint('Downloading latest release from $downloadUrl to $filePath');
    final client = http.Client();
    try {
      final request = http.Request('GET', Uri.parse(downloadUrl));
      final streamedResponse = await client.send(request);

      if (streamedResponse.statusCode == 200) {
        final file = File(filePath);
        final sink = file.openWrite();
        await streamedResponse.stream.pipe(sink);
        await sink.close();
        debugPrint('Downloaded latest release to $filePath');
        return filePath;
      } else {
        throw Exception(
          'Failed to download release asset (Status ${streamedResponse.statusCode})',
        );
      }
    } finally {
      client.close();
    }
  }

  Future<void> installUpdate(String filePath) async {
    if (Platform.isWindows) {
      try {
        debugPrint('Attempting to run setup: $filePath /VERYSILENT');
        final result = await Process.run(filePath, ['/VERYSILENT']);
        if (result.exitCode == 0) {
          debugPrint(
            'Setup ran successfully (or started in background). Exit code: ${result.exitCode}',
          );
        } else {
          debugPrint(
            'Setup failed or reported an issue. Exit code: ${result.exitCode}',
          );
          debugPrint('Stdout: ${result.stdout}');
          debugPrint('Stderr: ${result.stderr}');
          throw Exception(
            'Setup failed with exit code ${result.exitCode}. Installer output: ${result.stderr}',
          );
        }
      } catch (e) {
        debugPrint('Failed to run Windows setup: $e');
        throw Exception('Failed to run Windows setup: $e');
      }
    } else if (Platform.isAndroid) {
      try {
        debugPrint('Attempting to open APK for installation: $filePath');
        final result = await OpenFilex.open(filePath);
        debugPrint(
          'OpenFilex result: type=${result.type}, message=${result.message}',
        );
        if (result.type != ResultType.done) {
          if (result.message.contains("Permission denied") ||
              result.message.contains(
                "does not have manager unknown sources permission",
              )) {
            throw Exception(
              'Permission to install from unknown sources denied. Please enable it in app settings. Message: ${result.message}',
            );
          }
          throw Exception(
            'Failed to open APK installer: ${result.message} (Type: ${result.type})',
          );
        }
      } catch (e) {
        debugPrint('Failed to open APK for installation: $e');
        throw Exception('Failed to start APK installation: $e');
      }
    } else if (Platform.isLinux) {
      try {
        debugPrint('Starting AppImage update process for Linux.');
        debugPrint('New AppImage downloaded to: $filePath');

        final currentAppImagePath = Platform.resolvedExecutable;
        debugPrint('Current running AppImage path: $currentAppImagePath');

        if (!currentAppImagePath.toLowerCase().endsWith('.appimage') &&
            Platform.environment['APPIMAGE'] == null) {
          debugPrint(
            'Application does not seem to be running as an AppImage. Cannot auto-update this way.',
          );
          debugPrint(
            'Opening download location for manual update: ${File(filePath).parent.path}',
          );
          await OpenFilex.open(File(filePath).parent.path);
          throw Exception(
            'Not running as AppImage. Please update manually from: ${File(filePath).parent.path}',
          );
        }

        debugPrint('Setting execute permissions for: $filePath');
        final chmodResult = await Process.run('chmod', ['+x', filePath]);
        if (chmodResult.exitCode != 0) {
          debugPrint(
            'Failed to set execute permissions: ${chmodResult.stderr}',
          );
          throw Exception(
            'Failed to set execute permissions for the new AppImage.',
          );
        }

        final oldAppImageBackupPath = '$currentAppImagePath.old';

        if (await File(oldAppImageBackupPath).exists()) {
          try {
            await File(oldAppImageBackupPath).delete();
            debugPrint('Deleted old backup: $oldAppImageBackupPath');
          } catch (e) {
            debugPrint(
              'Could not delete old backup $oldAppImageBackupPath: $e. Continuing...',
            );
          }
        }

        debugPrint(
          'Renaming current AppImage from $currentAppImagePath to $oldAppImageBackupPath',
        );
        await File(currentAppImagePath).rename(oldAppImageBackupPath);

        debugPrint(
          'Copying new AppImage from $filePath to $currentAppImagePath',
        );
        await File(filePath).copy(currentAppImagePath);

        debugPrint('AppImage update applied. Application needs to restart.');
        throw AppImageUpdateRequiresRestartException(
          'Update applied. Please restart the application to use the new version. The old version has been backed up as $oldAppImageBackupPath (can be deleted after successful restart).',
        );
      } catch (e) {
        debugPrint('Failed to install AppImage update: $e');
        final oldAppImageBackupPath = '${Platform.resolvedExecutable}.old';
        if (await File(oldAppImageBackupPath).exists() &&
            !await File(Platform.resolvedExecutable).exists()) {
          try {
            await File(
              oldAppImageBackupPath,
            ).rename(Platform.resolvedExecutable);
            debugPrint('Restored old AppImage from backup due to error.');
          } catch (restoreError) {
            debugPrint(
              'Failed to restore old AppImage from backup: $restoreError',
            );
          }
        }
        if (e is AppImageUpdateRequiresRestartException)
          rethrow; 
        rethrow;
      }
    } else if (Platform.isMacOS) {
      debugPrint(
        'Automatic update installation is not implemented for ${Platform.operatingSystem}. Please install manually: $filePath',
      );
      await OpenFilex.open(File(filePath).parent.path); 
      throw Exception(
        'Please install the update manually from: ${File(filePath).parent.path}',
      );
    } else {
      debugPrint(
        'Automatic setup execution is not supported on ${Platform.operatingSystem}.',
      );
      throw UnsupportedError(
        'Automatic update installation not supported on this platform.',
      );
    }
  }
}

class AppImageUpdateRequiresRestartException implements Exception {
  final String message;
  AppImageUpdateRequiresRestartException(this.message);
  @override
  String toString() => 'AppImageUpdateRequiresRestartException: $message';
}
