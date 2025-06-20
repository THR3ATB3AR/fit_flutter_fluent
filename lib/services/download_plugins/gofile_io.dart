// in lib/services/download_plugins/gofile_io.dart (or wherever your Gofile code is)

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fit_flutter_fluent/data/download_info.dart';
import 'package:flutter/foundation.dart';

class GofileIo {
  static String? _guestToken;
  static DateTime? _guestTokenTimestamp;

  Future<String> _getGuestToken() async {
    if (_guestToken != null &&
        _guestTokenTimestamp != null &&
        DateTime.now().difference(_guestTokenTimestamp!).inMinutes < 15) {
      debugPrint('[Gofile] Using cached guest token.');
      return _guestToken!;
    }

    debugPrint('[Gofile] Requesting new guest token.');
    final url = Uri.parse('https://api.gofile.io/accounts');
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': '*/*',
          'Origin': 'https://gofile.io',
          'Referer': 'https://gofile.io/',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'ok' && data['data']['token'] != null) {
          _guestToken = data['data']['token'];
          _guestTokenTimestamp = DateTime.now();
          debugPrint('[Gofile] Successfully obtained new guest token.');
          return _guestToken!;
        } else {
          throw Exception('Gofile API did not return a valid token. Response: ${response.body}');
        }
      } else {
        throw Exception('Failed to get Gofile guest token, status: ${response.statusCode}, body: ${response.body}');
      }
    } catch (e) {
      debugPrint('[Gofile] Error getting guest token: $e');
      rethrow;
    }
  }

  String? _getFolderIdFromUrl(String url) {
    final regex = RegExp(r'\/d\/([a-zA-Z0-9]+)');
    final match = regex.firstMatch(url);
    return match?.group(1);
  }

  Future<List<DownloadInfo>> getDownloadInfo(String repackTitle, String gofileUrl) async {
    final folderId = _getFolderIdFromUrl(gofileUrl);
    if (folderId == null) {
      throw ArgumentError('Invalid Gofile URL format. Could not find a folder ID.');
    }

    debugPrint('[Gofile] Processing Folder ID: $folderId');
    final guestToken = await _getGuestToken();
    final contentUrl = Uri.parse('https://api.gofile.io/contents/$folderId?wt=4&cache=true');
    
    final headers = {
      'Authorization': 'Bearer $guestToken',
      'Cookie': 'accountToken=$guestToken',
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36',
    };
    
    try {
      final response = await http.get(contentUrl, headers: headers);

      // --- START OF MODIFICATIONS ---
      // We need to handle non-200 status codes gracefully now.
      if (response.statusCode != 200) {
        String errorMsg = 'Failed to get Gofile content, status code: ${response.statusCode}';
        try {
          // Try to parse the error body to get a more specific message.
          final errorData = jsonDecode(response.body);
          final String? status = errorData['status'];
          
          if (status == 'error-notPremium') {
            // This is the specific error we need to handle.
            debugPrint('[Gofile] Server is overloaded and requires a premium account for this file.');
            throw Exception('Gofile server is busy. This file currently requires a Premium account to access. Please try again later.');
          } else if (status != null) {
            // A different, known API error.
            errorMsg = 'Gofile API Error: $status';
          }
        } catch (_) {
          // JSON parsing failed, just use the status code.
        }
        throw Exception(errorMsg);
      }
      // --- END OF MODIFICATIONS ---

      final data = jsonDecode(response.body);
      if (data['status'] != 'ok') {
        if (data['status'] == 'error-passwordRequired' || data['status'] == 'error-passwordWrong') {
          throw Exception('This Gofile folder is password protected, which is not supported.');
        }
        throw Exception('Gofile API returned an error: ${data['status']}');
      }

      // The rest of the parsing logic remains the same...
      final Map<String, dynamic>? contents = data['data']?['contents'];
      if (contents == null) throw Exception('Gofile response is missing "contents" data.');

      final Map<String, dynamic>? children = data['data']?['children'];
      if (children == null) throw Exception('Gofile response is missing "children" data.');

      final List<DownloadInfo> downloadInfos = [];
      final rootFolderId = data['data']?['id'];
      if (rootFolderId == null) throw Exception('Could not determine the root folder ID from the response.');

      final rootFolderData = contents[rootFolderId];
      if (rootFolderData == null || rootFolderData['type'] != 'folder' || rootFolderData['children'] == null) {
        throw Exception('Root content is not a valid folder or has no children.');
      }

      final List<String> childrenIds = List<String>.from(rootFolderData['children']);
      for (var childId in childrenIds) {
        final childData = children[childId];
        if (childData != null && childData['type'] == 'file') {
          final String? downloadLink = childData['link'];
          final String? fileName = childData['name'];
          if (downloadLink != null && fileName != null) {
            downloadInfos.add(
              DownloadInfo(repackTitle: repackTitle, downloadLink: downloadLink, fileName: fileName, downloadType: 'Gofile'),
            );
          }
        }
      }
      
      if (downloadInfos.isEmpty) throw Exception('No valid files found in the Gofile folder.');

      debugPrint('[Gofile] Successfully parsed ${downloadInfos.length} file(s).');
      return downloadInfos;

    } catch (e) {
      // The catch block will now receive the more specific error message.
      debugPrint('[Gofile] Error processing Gofile content: $e');
      rethrow; // Rethrow the specific error to be caught by the UI.
    }
  }
}