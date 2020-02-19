import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/client_provider.dart';
import 'package:unfollow_app_flutter/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClientProvider(
        // uri: "https://unfollow-app-graphene.herokuapp.com/",
        uri: "http://0.0.0.0:5000/",
        child: MaterialApp(routes: routes),
      ),
    );
  }
}
