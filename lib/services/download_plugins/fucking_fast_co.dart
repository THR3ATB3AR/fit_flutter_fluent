import 'package:fit_flutter_fluent/data/download_info.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class FuckingFastCo {
  Future<DownloadInfo> getDownloadInfo(String gameName, String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 404) {
      throw Exception('File not found (404)');
    } else if (response.statusCode != 200) {
      throw Exception(
        'Failed to load page, status code: ${response.statusCode}',
      );
    }

    final htmlBody = response.body;

    final linkRegex = RegExp(r'window\.open\("(https?://[^"]+)"\)');
    final match = linkRegex.firstMatch(htmlBody);

    if (match == null) {
      throw Exception(
        'Could not parse the direct download link from the page.',
      );
    }

    final String dllink = match.group(1)!;

    dom.Document document = parser.parse(response.body);
    String? fileName = document.querySelector('span.text-xl')?.text;
    if (fileName != null) {
      fileName = fileName.trim();
    } else {
      fileName = 'unknown';
    }

    String downloadType = '';
    if (fileName.contains('.')) {
      downloadType = fileName.split('.').first;
    } else {
      downloadType = fileName;
    }

    return DownloadInfo(
      repackTitle: gameName,
      downloadLink: dllink,
      fileName: fileName,
      downloadType: downloadType,
    );
  }
}
