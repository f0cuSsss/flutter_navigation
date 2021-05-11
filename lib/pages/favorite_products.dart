import 'package:flutter/material.dart';
import 'package:flutter_navigation/routes/types.dart';

class FavoriteProductsPage extends StatelessWidget {
  var data;
  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    data = settings.arguments;
    return Container(
      decoration: BoxDecoration(color: Colors.white70),
      child: Center(
          child: Column(
        children: [
          RaisedButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, RoutePaths[route_types.auth]);
            },
            child: Text(
              'Go to auth',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text((data != null ? data : 'No data'))
        ],
      )),
    );
  }
}
