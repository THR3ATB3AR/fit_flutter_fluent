import 'package:fit_flutter_fluent/data/download_mirror.dart';

class GogDownloadLinks {
  final Map<String, List<DownloadMirror>> gameDownloadLinks;
  final Map<String, List<DownloadMirror>> patchDownloadLinks;
  final Map<String, List<DownloadMirror>> extraDownloadLinks;
  final String? torrentLink;

  GogDownloadLinks({
    this.gameDownloadLinks = const {},
    this.patchDownloadLinks = const {},
    this.extraDownloadLinks = const {},
    this.torrentLink,
  });

  bool get isEmpty =>
      gameDownloadLinks.isEmpty &&
      patchDownloadLinks.isEmpty &&
      extraDownloadLinks.isEmpty &&
      (torrentLink == null || torrentLink!.isEmpty);
}