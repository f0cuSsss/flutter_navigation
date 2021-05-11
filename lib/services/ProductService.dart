import 'package:flutter_navigation/models/Product.dart';
import 'package:flutter_navigation/services/HttpService.dart';
import 'package:flutter_navigation/services/api/config.dart';

class ProductService {
  static Future<List<Product>> getProducts() async {
    try {
      return await HTTPService.doGet(Uri.https(APIs.data.authority,
              APIs.data.endpoints[DATA_ENDPOINT_TYPES.posts]))
          .then((res) {
        if (res.statusCode == 200) {
          final List<Product> products = productFromJson(res.body);
          print('List length: ${products.length}');
          return products;
        } else {
          print(res.statusCode);
          return List<Product>();
        }
      });
    } catch (err) {
      print(err.toString());
      return List<Product>();
    }
  }
}
