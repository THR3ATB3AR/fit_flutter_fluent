import 'package:fit_flutter_fluent/services/download_plugins/fucking_fast_co.dart';

class HostService {
  dynamic getDownloadPlugin(String repackTitle, String url) async {
    switch (url) {
      case String url when url.contains('fuckingfast.co'):
        return await FuckingFastCo().getDownloadInfo(repackTitle, url);
      default:
        return 'UnknownPlugin';
    }
  }
}
