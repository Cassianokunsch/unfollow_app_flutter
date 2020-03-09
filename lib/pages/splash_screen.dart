import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/pages/home_screen.dart';
import 'package:unfollow_app_flutter/pages/login_screen.dart';
import 'package:unfollow_app_flutter/storage.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _isLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  _isLogged() async {
    String token = await getToken();
    if (token != null) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }
  }
}
