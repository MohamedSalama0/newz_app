import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:clipboard/clipboard.dart';



class function {
  static Future<void> openLink(String link) async {
    var urlLink = link;
    if (await canLaunch(urlLink)) {
      await launch(urlLink);
    }
  }
  static Future<void> shareLink(String link) async => Share.share(link);
  static Future<void> CopyLink(String link) async => FlutterClipboard.copy(link);
}