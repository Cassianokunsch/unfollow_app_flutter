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
              buildTitleLogin(),
              SizedBox(
                height: 60.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildTextField("Username", false),
                    SizedBox(
                      height: 10.0,
                    ),
                    buildTextField("Password", true),
                    SizedBox(
                      height: 20.0,
                    ),
                    ButtonTheme(
                      height: 54.0,
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        splashColor: Colors.blueAccent,
                        onPressed: () {},
                        child: Text("Entrar", style: TextStyle(fontSize: 20.0)),
                      ),
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

  TextField buildTextField(hintText, obscureText) {
    return TextField(
      cursorColor: Color.fromRGBO(255, 255, 255, 0.5),
      obscureText: obscureText,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromRGBO(255, 255, 255, 0.3), width: 2.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: hintText,
          fillColor: Color.fromRGBO(255, 255, 255, 0.5)),
    );
  }

  Column buildTitleLogin() {
    return Column(
      children: <Widget>[
        Text(
          "Unfollow",
          style: TextStyle(
              color: Colors.white, fontSize: 70, fontFamily: 'Lobster'),
        ),
        Text(
          "App",
          style: TextStyle(
              color: Colors.white, fontSize: 70, fontFamily: 'Lobster'),
        ),
      ],
    );
  }
}
