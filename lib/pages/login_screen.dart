import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/mutation.dart';
import 'package:unfollow_app_flutter/pages/home_screen.dart';
import 'package:unfollow_app_flutter/storage.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextStyle _style =
      TextStyle(color: Colors.white, fontSize: 70, fontFamily: 'Lobster');

  _onCompleted(dynamic resultData) async {
    if (resultData != null) {
      await setToken(resultData['login']['token']);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  _submit(RunMutation login) {
    if (_passwordController.text != '' && _usernameController.text != '') {
      login(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      });
    } else {
      _scaffoldKey.currentState
          .showSnackBar(snackBar('Preencha corretamente os campos!'));
    }
  }

  Mutation _loginButton(context) {
    return Mutation(
      options: MutationOptions(
        documentNode: gql(login),
        onCompleted: (dynamic resultData) => _onCompleted(resultData),
        onError: (OperationException error) => _scaffoldKey.currentState
            .showSnackBar(snackBar(error.graphqlErrors[0].message)),
      ),
      builder: (RunMutation login, QueryResult result) {
        return ButtonTheme(
          height: 54.0,
          child: RaisedButton(
            color: Colors.lightGreen,
            textColor: Colors.black,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.lightGreenAccent,
            onPressed: () => _submit(login),
            child: result.loading
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      strokeWidth: 3.0,
                    ),
                  )
                : Text(
                    "Entrar",
                    style: TextStyle(fontSize: 20.0),
                  ),
          ),
        );
      },
    );
  }

  SnackBar snackBar(String message) {
    return SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
  }

  TextFormField _input(hintText, obscureText, controller) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Color.fromRGBO(255, 255, 255, 0.5),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromRGBO(255, 255, 255, 0.3), width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        filled: true,
        hintStyle: TextStyle(
          color: Colors.grey[800],
        ),
        hintText: hintText,
        fillColor: Color.fromRGBO(255, 255, 255, 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login_background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("Unfollow", style: _style),
                Text("App", style: _style),
              ],
            ),
            SizedBox(height: 60.0),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _input('Usuário', false, _usernameController),
                  SizedBox(height: 10.0),
                  _input('Senha', true, _passwordController),
                  SizedBox(height: 20.0),
                  _loginButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
