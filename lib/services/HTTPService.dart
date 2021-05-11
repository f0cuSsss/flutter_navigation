import 'package:http/http.dart' as http;

class HTTPService {
  static Future doGet(Uri url) async {
    return await http.get(url);
  }
}
