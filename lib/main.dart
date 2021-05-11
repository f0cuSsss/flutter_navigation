import 'package:flutter/material.dart';
import 'package:flutter_navigation/pages/auth.dart';
import 'package:flutter_navigation/pages/favorite_products.dart';
import 'package:flutter_navigation/pages/product_list_page.dart';
import 'package:flutter_navigation/routes/types.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    // onGenerateRoute: (settings) {
    //   switch(settings.name) {
    //     case RoutePaths[route_types.favorites]: {
    //       return MaterialPageRoute(builder: (context) => FavoriteProductsPage())
    //     }
    //   }
    // },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: ProductListPage(),
      ),
      initialRoute: RoutePaths[route_types.products],
      routes: {
        RoutePaths[route_types.favorites]: (context) => FavoriteProductsPage(),
        RoutePaths[route_types.auth]: (context) => AuthPage(),
        RoutePaths[route_types.products]: (context) => ProductListPage(),
      },
    );
  }
}
