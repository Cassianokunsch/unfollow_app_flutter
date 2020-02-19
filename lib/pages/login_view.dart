import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/mutations.dart';

class LoginView extends StatefulWidget {
  static String tag = '/';

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<LoginView> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final title = Column(
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

    final loginButton = Mutation(
      options: MutationOptions(documentNode: gql(loginMutation)),
      builder: (RunMutation login, QueryResult result) {
        if (result.loading) {
          print("logando");
        }
        return ButtonTheme(
          height: 54.0,
          child: RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            onPressed: () {
              login(
                <String, dynamic>{
                  'username': _usernameController.text,
                  'password': _passwordController.text,
                },
              );
            },
            child: Text("Entrar", style: TextStyle(fontSize: 20.0)),
          ),
        );
      },
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login_background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            title,
            SizedBox(height: 60.0),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _getTextFormField('Username', false, _usernameController),
                  SizedBox(height: 10.0),
                  _getTextFormField('Password', true, _passwordController),
                  SizedBox(height: 20.0),
                  loginButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _getTextFormField(hintText, obscureText, controller) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Color.fromRGBO(255, 255, 255, 0.5),
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
}
