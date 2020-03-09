import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;

  const CustomSnackBar({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
  }
}
