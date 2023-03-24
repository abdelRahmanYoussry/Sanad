import 'package:sanad/utils/sharepref.dart';

class Constant {
  final String baseurl = 'http://exeativesolutions.com/public/api/';

  final String oneSignalAppId = "5bf7405c-0c2d-49f2-9f09-22c6732cc1d1";

  static Future<int> totalCoins({required int coins}) async {
    SharePref sharePref = SharePref();
    await sharePref.save('totalCoins', coins);
    return coins;
  }

  static Future<int> totalPoints({required int points}) async {
    SharePref sharePref = SharePref();
    await sharePref.save('totalPoints', points);
    return points;
  }
}
