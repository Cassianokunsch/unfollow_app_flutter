import 'package:flutter/material.dart';

class UserInfoScreen extends StatelessWidget {
  final String username;
  UserInfoScreen(this.username);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(username),
      ),
    );
  }
}
