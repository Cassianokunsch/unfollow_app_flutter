import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/pages/home_view.dart';
import 'package:unfollow_app_flutter/pages/login_view.dart';
import 'package:unfollow_app_flutter/pages/users_list_view.dart';
import 'package:unfollow_app_flutter/storage.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/splash';

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
      Navigator.pushReplacementNamed(context, HomeView.tag);
    } else {
      Navigator.pushReplacementNamed(context, LoginView.tag);
    }
  }
}
