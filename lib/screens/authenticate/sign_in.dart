import 'package:fastorder/services/auth.dart';
import 'package:fastorder/shared/constants.dart';
import 'package:fastorder/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Reflector Academy'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () => widget.toggleView(),
                    icon: Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                    label: Text(
                      'Register',
                      style: TextStyle(color: Colors.white70),
                    ))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    Text(
                      error,
                      style:
                          TextStyle(color: Colors.tealAccent, fontSize: 14.0),
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (value) =>
                          value.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val.length < 6
                          ? 'Password must be at least 6 characters'
                          : null,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService.signInWithCred(
                                email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Registration failed. Please try again';
                              });
                            }
                          }
                        }),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      child: Text('Sign in as anon'),
                      onPressed: () async {
                        dynamic result = await _authService.signInAnon();
                        if (result == null) {
                          print('error signing in');
                        }
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink[200],
                      child: Text(
                        'Google Authentication',
                        style: TextStyle(
                          color: Colors.white70
                        ),
                        ),
                      onPressed: () async {},
                    ),
                  ])),
            ),
          );
  }
}
