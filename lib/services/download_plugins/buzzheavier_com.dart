import 'package:fit_flutter_fluent/data/download_info.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class BuzzheavierCom {
  Future<DownloadInfo> getDownloadInfo(
    String repackTitle,
    String initialUrl,
  ) async {
    final client = http.Client();
    try {
      // --- 1. Request the initial file page to get file info ---
      print('[Buzzheavier] Fetching initial page: $initialUrl');
      final response = await client.get(Uri.parse(initialUrl));

      if (response.statusCode == 404) {
        throw Exception('File not found (404 Error).');
      }

      // Parse the HTML content
      final document = parser.parse(response.body);

      // Check for "File Not Found" messages in the body
      if (document.body?.text.contains('File Not Found Or Deleted') ?? false) {
        throw Exception('File not found or deleted.');
      }

      // --- 2. Parse the HTML to get the filename ---
      String fileName = 'Unknown File';
      // The filename is in a <meta name="title" content="..."> tag.
      final metaTitle = document.querySelector('meta[name="title"]');
      if (metaTitle != null) {
        fileName = metaTitle.attributes['content']?.trim() ?? fileName;
        print('[Buzzheavier] Found filename: $fileName');
      } else {
        print('[Buzzheavier] WARNING: Could not find filename on page.');
      }
      String downloadType = '';
      if (fileName.contains('.')) {
        downloadType = fileName.split('.').first;
      } else {
        downloadType = fileName;
      }

      // --- 3. Construct the /download URL and make a request ---
      // This request is expected to give us a redirect, not the file itself.
      // We prevent automatic redirects to capture the header.
      final downloadEndpointUrl = Uri.parse('$initialUrl/download');
    final intermediateRequest = http.Request('GET', downloadEndpointUrl)..followRedirects = false;
    print('[Buzzheavier] Requesting download endpoint: $downloadEndpointUrl');
    final intermediateResponse = await client.send(intermediateRequest);
    
    if (intermediateResponse.statusCode < 300 || intermediateResponse.statusCode >= 400) {
      throw Exception('Expected a redirect from download endpoint, but got status ${intermediateResponse.statusCode}');
    }

    final intermediateRedirectUrl = intermediateResponse.headers['hx-redirect'] ?? intermediateResponse.headers['location'];
    if (intermediateRedirectUrl == null || intermediateRedirectUrl.isEmpty) {
      throw Exception('Redirect found, but "Hx-Redirect" or "location" header was missing.');
    }
    print('[Buzzheavier] Found intermediate redirect URL: $intermediateRedirectUrl');

    // --- Step 3 (NEW): Make a HEAD request to the intermediate URL to get the FINAL URL ---
    // We use a HEAD request because we only care about the headers (specifically the final 'location' after redirects)
    // and don't need to download the body. This is much faster.
    print('[Buzzheavier] Sending HEAD request to intermediate URL to find final location...');
    final finalRequest = http.Request('HEAD', Uri.parse(intermediateRedirectUrl))
      ..followRedirects = true; // IMPORTANT: Allow redirects here
      
    final finalResponse = await client.send(finalRequest);

    // The final URL is the URL of the last request in the redirect chain.
    final finalUrl = finalResponse.request?.url.toString();

    if (finalUrl != null && finalUrl.isNotEmpty && finalUrl != intermediateRedirectUrl) {
      print('[Buzzheavier] Found FINAL download URL: $finalUrl');
      return DownloadInfo(
        repackTitle: repackTitle,
        downloadLink: finalUrl,
        fileName: fileName,
        downloadType: downloadType,
      );
    } else {
      throw Exception('Failed to resolve the final download URL from the intermediate redirect.');
    }

  } catch (e) {
    print('[Buzzheavier] An error occurred: $e');
    rethrow;
  } finally {
    client.close();
  }
}
}
