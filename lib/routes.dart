import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/pages/authorization_code_view.dart';
import 'package:unfollow_app_flutter/pages/follower_screen.dart';
import 'package:unfollow_app_flutter/pages/following_screen.dart';
import 'package:unfollow_app_flutter/pages/home_screen.dart';
import 'package:unfollow_app_flutter/pages/login_screen.dart';
import 'package:unfollow_app_flutter/pages/splash_screen.dart';
import 'package:unfollow_app_flutter/pages/unfollow_screen.dart';

final routes = {
  HomeScreen.routeName: (BuildContext context) => HomeScreen(),
  LoginScreen.routeName: (BuildContext context) => LoginScreen(),
  SplashScreen.routeName: (BuildContext context) => SplashScreen(),
  FollowerScreen.routeName: (BuildContext context) => FollowerScreen(),
  FollowingScreen.routeName: (BuildContext context) => FollowingScreen(),
  UnfollowScreen.routeName: (BuildContext context) => UnfollowScreen(),
  AutorizationCodeView.routeName: (BuildContext context) =>
      AutorizationCodeView(),
};
