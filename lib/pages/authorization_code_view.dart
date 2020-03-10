import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:unfollow_app_flutter/graphql/mutation.dart';
import 'package:unfollow_app_flutter/pages/home_screen.dart';
import 'package:unfollow_app_flutter/storage.dart';

class AutorizationCodeView extends StatefulWidget {
  static String routeName = '/code';
  @override
  _AutorizationCodeViewState createState() => _AutorizationCodeViewState();
}

class _AutorizationCodeViewState extends State<AutorizationCodeView> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Por favor, insira o código recebido por sms:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextFormField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _codeController,
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
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                  ),
                  hintText: 'Code',
                  fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                ),
              ),
              SizedBox(height: 10),
              _sendCode(context)
            ],
          ),
        ),
      ),
    );
  }

  Mutation _sendCode(context) {
    return Mutation(
      options: MutationOptions(
        documentNode: gql(sendCodeChallenge),
        onCompleted: (dynamic resultData) async {
          if (resultData != null) {
            await setToken(resultData['login']['token']);

            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
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
                    "Validar",
                    style: TextStyle(fontSize: 20.0),
                  ),
          ),
        );
      },
    );
  }

  _submit(RunMutation login) {
    if (_codeController.text != '') {
      login(<String, String>{'code': _codeController.text});
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Preencha o código!'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
