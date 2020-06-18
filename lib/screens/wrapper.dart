import 'package:fastorder/models/user.dart';
import 'package:fastorder/screens/authenticate/authenticate.dart';
import 'package:fastorder/shared/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context) ;

    if(user == null) {
      return Authenticate();
    }else{
      return MainMenu();
    }
  }
}