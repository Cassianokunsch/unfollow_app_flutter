import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:unfollow_app_flutter/models/user.dart';

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  if (token == '') {
    return '';
  }

  return token;
}

Future<void> setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<void> setUser(Map<String, dynamic> user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', json.encode(user));
}

Future<User> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  return User.fromJson(jsonDecode(prefs.getString('user')));
}
