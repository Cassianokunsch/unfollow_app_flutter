import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/graphql/client_provider.dart';
import 'package:unfollow_app_flutter/pages/splash_screen.dart';
import 'package:unfollow_app_flutter/routes.dart';
import 'package:unfollow_app_flutter/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String token = await getToken();
  print(token);
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String token;

  const MyApp({@required this.token});

  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: "https://unfollow-app-graphene.herokuapp.com/",
      //uri: "http://10.15.240.14:5000/",
      child: MaterialApp(
        theme: ThemeData.dark(),
        routes: routes,
        initialRoute: SplashScreen.tag,
      ),
    );
  }
}
