import 'package:shared_preferences/shared_preferences.dart';
import 'package:unfollow_app_flutter/models/me_response.dart';
import 'dart:convert';

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<void> setToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<void> setUser(Map<String, dynamic> user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user', json.encode(user));
}

Future<MeResponse> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user = prefs.getString('user');

  if (user == null) {
    return null;
  }

  return MeResponse.fromJson(jsonDecode(prefs.getString('user')));
}
