import 'dart:convert';
import 'dart:io';
import 'package:fluent_ui/fluent_ui.dart'; 
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart'; 

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
          return 'x64';
        } else if (arch == 'aarch64') {
          return 'arm64';
        } else {
          debugPrint('Unsupported Linux architecture: $arch. Cannot determine asset.');
          throw Exception('Unsupported Linux architecture for update: $arch');
        }
      } else {
        debugPrint('Failed to determine Linux architecture: ${result.stderr}');
        throw Exception('Failed to determine Linux architecture (uname -m failed).');
      }
    } catch (e) {
      debugPrint('Error determining Linux architecture: $e');
      rethrow; 
    }
  }

  Future<String> downloadLatestRelease() async {
    final jsonResponse = await getLatestReleaseData();
    final assets = jsonResponse['assets'] as List<dynamic>?;

    if (assets == null || assets.isEmpty) {
      throw Exception('No assets found in the latest release.');
    }

    Map<String, dynamic>? assetData;

    try {
      String? searchPatternStart; 
      String searchPatternEnd;   

      if (Platform.isWindows) {
        searchPatternEnd = '.exe';
      } else if (Platform.isAndroid) {
        searchPatternEnd = '.apk';
      } else if (Platform.isMacOS) {
        searchPatternEnd = '.dmg'; 
      } else if (Platform.isLinux) {
        final archSuffix = await _getLinuxArchSuffixForAsset(); 
        searchPatternStart = 'fitflutterfluent-linux-$archSuffix-';
        searchPatternEnd = '.tar.gz';
      } else {
        throw UnsupportedError('Unsupported platform for update.');
      }

      assetData = assets.firstWhere(
        (asset) {
          final assetName = (asset['name'] as String?)?.toLowerCase();
          if (assetName == null) return false;

          if (Platform.isLinux && searchPatternStart != null) {
            return assetName.startsWith(searchPatternStart) && assetName.endsWith(searchPatternEnd);
          } else {
            return assetName.endsWith(searchPatternEnd);
          }
        },
        orElse: () => null,
      );

      if (assetData == null) {
        String expectedFormat = searchPatternEnd;
        if (Platform.isLinux && searchPatternStart != null) {
            expectedFormat = "$searchPatternStart<version>$searchPatternEnd";
        }
        debugPrint("Could not find suitable asset. Expected format: $expectedFormat. Available assets: ${assets.map((a) => a['name'])}");
        throw Exception('Suitable asset not found. Expected format like: $expectedFormat');
      }

    } catch (e) { 
      debugPrint("Error identifying asset: $e");
      throw Exception('Failed to identify a suitable release asset: ${e.toString()}');
    }


    final downloadUrl = assetData['browser_download_url'] as String?;
    final fileName = assetData['name'] as String?;

    if (downloadUrl == null || fileName == null) {
      throw Exception('Asset download URL or name is missing from identified asset data.');
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
        throw Exception('Failed to download release asset (Status ${streamedResponse.statusCode})');
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
    } else if (Platform.isLinux || Platform.isMacOS) {
      debugPrint(
        'Automatic update installation is not implemented for ${Platform.operatingSystem}. Please install manually: $filePath',
      );
      await OpenFilex.open(File(filePath).parent.path);
      throw Exception('Please install the update manually from: $filePath');
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
