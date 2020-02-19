import 'package:flutter/material.dart';
import 'package:unfollow_app_flutter/pages/home_view.dart';
import 'package:unfollow_app_flutter/pages/login_view.dart';

final routes = {
  HomeView.tag: (BuildContext context) => HomeView(),
  LoginView.tag: (BuildContext context) => LoginView(),
};
