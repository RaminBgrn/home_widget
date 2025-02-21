import 'package:http4/http4.dart' as http4;
import 'package:http4/package_content/domain/http4_response.dart';

class RequestService extends http4.Http4 {
  Future<Http4Response?> getRequest(String url) async {
    try {
      final getResponse = await get(url);
      if (getResponse.isOkey) {
        return getResponse;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
