import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/mutations.dart';
import 'package:unfollow_app_flutter/pages/home_view.dart';
import 'package:unfollow_app_flutter/storage.dart';

class LoginView extends StatefulWidget {
  static String tag = '/';

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final title = Column(
    children: <Widget>[
      Text(
        "Unfollow",
        style:
            TextStyle(color: Colors.white, fontSize: 70, fontFamily: 'Lobster'),
      ),
      Text(
        "App",
        style:
            TextStyle(color: Colors.white, fontSize: 70, fontFamily: 'Lobster'),
      ),
    ],
  );

  Mutation loginButton(context) {
    return Mutation(
      options: MutationOptions(
        documentNode: gql(loginMutation),
        onCompleted: (dynamic resultData) async {
          if (resultData != null) {
            await setToken(resultData['login']['token']);
            await setUser(resultData['login']['user']);
            Navigator.pushNamed(context, HomeView.tag);
          }
        },
        onError: (OperationException error) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(error.graphqlErrors[0].message),
            duration: Duration(seconds: 3),
          ));
        },
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
            onPressed: () => submit(login),
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

  void submit(RunMutation login) {
    if (_passwordController.text != '' && _usernameController.text != '') {
      login(<String, dynamic>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Preencha corretamente os campos!'),
        duration: Duration(seconds: 3),
      ));
    }
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
                  loginButton(context),
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
