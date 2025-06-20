import 'package:fit_flutter_fluent/services/download_plugins/buzzheavier_com.dart';
import 'package:fit_flutter_fluent/services/download_plugins/fucking_fast_co.dart';
import 'package:fit_flutter_fluent/services/download_plugins/gofile_io.dart';

class HostService {
  dynamic getDownloadPlugin(String repackTitle, String url) async {
    switch (url) {
      case String url when url.contains('fuckingfast.co'):
        return await FuckingFastCo().getDownloadInfo(repackTitle, url);
      case String url when url.contains('buzzheavier.com'):
        return await BuzzheavierCom().getDownloadInfo(repackTitle, url);
      case String url when url.contains('gofile.io'):
        return await GofileIo().getDownloadInfo(repackTitle, url);
      default:
        return 'UnknownPlugin';
    }
  }
}
