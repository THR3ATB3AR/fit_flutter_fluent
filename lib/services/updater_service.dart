import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

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
        print('GitHub API rate limit likely exceeded. Headers: ${response.headers}');
        throw Exception('GitHub API rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to fetch latest release info from GitHub (Status ${response.statusCode})');
      }
    } catch (e) {
      print("Error in getLatestReleaseData: $e");
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

      final latestVersion = latestVersionTag.startsWith('v')
          ? latestVersionTag.substring(1)
          : latestVersionTag;
      final appVersion = await getAppVersion();
      
      return latestVersion != appVersion;
    } catch (e) {
      print("Error in isUpdateAvailable: $e");
      return false; 
    }
  }

  Future<String> downloadLatestRelease() async {
    final jsonResponse = await getLatestReleaseData();
    final assets = jsonResponse['assets'] as List<dynamic>?;

    if (assets == null || assets.isEmpty) {
      throw Exception('No assets found in the latest release.');
    }

    final assetData = assets.firstWhere(
      (asset) => (asset['name'] as String?)?.toLowerCase().endsWith('.exe') ?? false,
      orElse: () => assets.first, 
    );

    if (assetData == null) {
       throw Exception('Suitable asset not found in the latest release.');
    }

    final downloadUrl = assetData['browser_download_url'] as String?;
    final fileName = assetData['name'] as String?;

    if (downloadUrl == null || fileName == null) {
      throw Exception('Asset download URL or name is missing.');
    }

    final directory = await getTemporaryDirectory(); // Use temporary for installer
    final filePath = '${directory.path}${Platform.pathSeparator}$fileName';

    print('Downloading latest release from $downloadUrl to $filePath');
    final fileResponse = await http.get(Uri.parse(downloadUrl));

    if (fileResponse.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(fileResponse.bodyBytes);
      print('Downloaded latest release to $filePath');
      return filePath;
    } else {
      throw Exception('Failed to download release asset (Status ${fileResponse.statusCode})');
    }
  }

  Future<void> runDownloadedSetup(String filePath) async {
    if (!Platform.isWindows) {
      print('Automatic setup execution is only supported on Windows for this example.');
      return;
    }
    try {
      print('Attempting to run setup: $filePath /VERYSILENT');
      final result = await Process.run(filePath, ['/VERYSILENT']); 
      if (result.exitCode == 0) {
        print('Setup ran successfully (or started in background). Exit code: ${result.exitCode}');
        print('Stdout: ${result.stdout}');
        print('Stderr: ${result.stderr}');
      } else {
        print('Setup failed or reported an issue. Exit code: ${result.exitCode}');
        print('Stdout: ${result.stdout}');
        print('Stderr: ${result.stderr}');
        throw Exception('Setup failed with exit code ${result.exitCode}. Installer output: ${result.stderr}');
      }
    } catch (e) {
      print('Failed to run setup: $e');
      throw Exception('Failed to run setup: $e');
    }
  }
}