import 'package:academy/screens/authenticate/register.dart';
import 'package:academy/services/auth.dart';
import 'package:academy/shared/constants.dart';
import 'package:academy/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
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
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: 400.0,
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                      child: Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Center(
                                child: Image.asset(
                              'assets/login.png',
                              height: 200.0,
                              // width: 50.0,
                            )),
                            Text(
                              "Welcome back!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text(
                              error == ''
                                  ? "Log in to your existing account"
                                  : error,
                              style: TextStyle(
                                  color: Colors.black26, fontSize: 14.0),
                            ),
                            SizedBox(height: 20.0),
                            Material(
                              elevation: 4.0,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 51.0, 0.0),
                                child: TextFormField(
                                  decoration: textInputDecorationLogin.copyWith(
                                    hintText: 'Email',
                                    icon: Icon(Icons.people),
                                  ),
                                  validator: (value) =>
                                      value.isEmpty ? 'Enter an email' : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Material(
                              elevation: 4.0,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10.0, 0.0, 51.0, 0.0),
                                child: TextFormField(
                                  obscureText: true,
                                  validator: (val) => val.length < 6
                                      ? 'Minimum of 6 characters'
                                      : null,
                                  decoration: textInputDecorationLogin.copyWith(
                                      hintText: 'Password',
                                      icon: new Icon(Icons.lock,
                                          color: Color(0xff224597))),
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {},
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ButtonTheme(
                              minWidth: 130.0,
                              height: 40.0,
                              child: RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _authService
                                          .signInWithCred(email, password);
                                      if (result['data'] == null) {
                                        setState(() {
                                          loading = false;
                                          error = result['error'];
                                        });
                                      }
                                    }
                                  }),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                              "Or connect using",
                              style: TextStyle(color: Colors.black54),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(
                                  width: 120.0,
                                  child: RaisedButton(
                                    color: Colors.red,
                                    child: Text(
                                      'Google',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    onPressed: () async {
                                      // signInWithGoogle
                                      dynamic result =  await _authService.signInAnon();
                                          // await _authService.signInWithGoogle();

                                      if (result['data'] == null) {
                                        setState(() {
                                          loading = false;
                                          error = result['error'];
                                        });
                                      }
                                    },
                                  ),
                                ),
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width / 4,
                                //   child: RaisedButton(
                                //     color: Colors.blue,
                                //     child: Text(
                                //       'Facebook',
                                //       style: TextStyle(
                                //           color: Colors.white70, fontSize: 12.0),
                                //     ),
                                //     onPressed: () async {},
                                //   ),
                                // ),
                                SizedBox(
                                  width: 120.0,
                                  child: RaisedButton(
                                    child: Text('Anon login'),
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result =
                                          await _authService.signInAnon();
                                      print('result');
                                      print(result);
                                      if (result['data'] == null) {
                                        setState(() {
                                          loading = false;
                                          error = result['error'];
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 60.0),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(builder: ((context) {
                                      return Register();
                                    }))),
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ])),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
