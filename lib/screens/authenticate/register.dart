import 'package:fastorder/services/auth.dart';
import 'package:fastorder/shared/constants.dart';
import 'package:fastorder/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

// fields
  String email = '';
  String password = '';
  String confirmPassword = '';
  var phoneNo = '';

  @override
  Widget build(BuildContext context) {
      return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Reflector Academy'),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () => widget.toggleView(),
              icon: Icon(Icons.person), 
              label: Text(
                'Sign In',
                style: TextStyle( color: Colors.lightBlue[100]),
              )
            )
          ], 
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  error,
                  style: TextStyle(color: Colors.tealAccent, fontSize: 14.0),
                ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Phone Number'),
                validator: (val) => val.isEmpty ? 'Enter valid phone number' : null,
                onChanged: (val) {
                  setState(() => phoneNo = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) => val.length < 6 ? 'Password must be at least 6 characters' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Confirm Password'),
                validator: (val) => password != confirmPassword ? 'Password doesnt match' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => confirmPassword = val);
                },
              ),
              SizedBox(height: 20.0),
               RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                     setState(() {
                    loading = true;
                  });
                  dynamic result = await _authService.registerWithCred(email, password);
                  if(result == null) {
                    setState(() {
                      loading = false;
                      error = 'Registration failed. Please try again';
                    });
                  }

                  }
                 
                }
              ),
              ],
            )
            ),
        ),

        );
      
  }
}