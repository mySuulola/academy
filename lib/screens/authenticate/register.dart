import 'package:academy/services/auth.dart';
import 'package:academy/shared/constants.dart';
import 'package:academy/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

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
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueGrey[50],
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[50],
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            "Let's Get Started!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          Text(
                            "Create an account to Acada to get all features",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 10.0),
                          ),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Full Name'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your Full Name' : null,
                            onChanged: (val) {
                              setState(() => fullName = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration:
                                textInputDecoration.copyWith(hintText: 'Email'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter Email' : null,
                            keyboardType: TextInputType.emailAddress,
                            keyboardAppearance: Brightness.dark,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Phone Number'),
                            validator: (val) => val.length < 11
                                ? 'Enter a valid phone number'
                                : null,
                            keyboardType: TextInputType.number,
                            keyboardAppearance: Brightness.light,                            
                            onChanged: (val) {
                              setState(() => phoneNo = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Password'),
                            validator: (val) => val.length < 6
                                ? 'Password must be at least 6 characters'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Confirm Password'),
                            validator: (val) => password != confirmPassword
                                ? 'Password doesnt match'
                                : null,
                            obscureText: true,
                            onChanged: (val) {
                              setState(() => confirmPassword = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 40.0,
                            child: RaisedButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'CREATE',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await _authService.registerWithCred(
                                            email, password, phoneNo, fullName);
                                    print(result);
                                    if (result['data'] == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            result['error'].toString() ?? "";
                                      });
                                    }
                                  }
                                }),
                          ),
                          SizedBox(height: 30.0),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: <Widget>[
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    "Login here",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          );
  }
}
