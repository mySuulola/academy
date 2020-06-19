import 'package:academy/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

// stfu
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return SignIn();
  }
}