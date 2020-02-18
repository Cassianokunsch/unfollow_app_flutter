import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/login_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Unfollow",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontFamily: 'Lobster'),
                  ),
                  Text(
                    "App",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontFamily: 'Lobster'),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Username",
                          fillColor: Color.fromRGBO(255, 255, 255, 0.5)),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Password",
                          fillColor: Color.fromRGBO(255, 255, 255, 0.3)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
