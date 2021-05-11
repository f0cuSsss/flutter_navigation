import 'package:flutter/material.dart';
import 'package:flutter_navigation/models/Product.dart';
import 'package:flutter_navigation/routes/types.dart';
import 'package:flutter_navigation/services/ProductService.dart';
// import 'package:flutter_navigation/services/api/config.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_navigation/pages/favorite_products.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  void handleNavToFavorites() {}

  List<Product> _products;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    ProductService.getProducts().then((products) {
      setState(() {
        _products = products;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _isLoading
            ? Center(child: Text('Products is loading...'))
            : ListView.builder(
                itemCount: null == _products ? 0 : _products.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_products[index].title),
                    subtitle: Text(_products[index].body),
                  );
                },
              ),
      ),
    );
  }
}

// Future<http.Response> getProducts() async =>
//     await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));

// void fetchProducts() {
//   print(APIs.data.url);

//   getProducts().then((res) {
//     if (res.statusCode == 200) {
//       print(res.body);
//     } else {
//       print(res.statusCode);
//     }
//   }).catchError((err) {
//     debugPrint(err.toString());
//   });
// }
