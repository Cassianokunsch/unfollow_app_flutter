import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/graphql/client_provider.dart';
import 'package:unfollow_app_flutter/pages/splash_screen.dart';
import 'package:unfollow_app_flutter/routes.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: "https://unfollow-app-graphene.herokuapp.com/",
      //uri: "http://10.15.240.14:5000/",
      child: MaterialApp(
        theme: ThemeData.dark(),
        routes: routes,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
