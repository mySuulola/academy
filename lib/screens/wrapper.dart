import 'package:academy/models/user.dart';
import 'package:academy/screens/authenticate/authenticate.dart';
import 'package:academy/shared/main_menu.dart';
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