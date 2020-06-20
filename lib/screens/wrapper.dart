import 'package:academy/models/user.dart';
import 'package:academy/shared/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:splashscreen/splashscreen.dart';

import 'authenticate/sign_in.dart';
import 'home/home.dart';



class IntroScreen extends StatefulWidget{


  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  void initState() {
    super.initState();
    // final res = Provider.of<User>(context);
      // print(res);
      // if (res != null) {
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => Home()),
      //   );
      // }
      // else
      // {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => SignIn()),
      //   );
      // }
  }

  @override
  Widget build(BuildContext context) {
        final user = Provider.of<User>(context);

        if(user == null) {
      return SignIn();
    }else{
      return MainMenu();
    }

    // return SplashScreen(
    //     seconds: 5,
    //     title: new Text('Welcome To Meet up!',
    //       style: new TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 20.0
    //       ),),
    //     image: Image.asset('assets/people.jpg',fit:BoxFit.scaleDown),
    //     backgroundColor: Colors.white,
    //     styleTextUnderTheLoader: new TextStyle(),
    //     photoSize: 100.0,
    //     onClick: ()=>print("flutter"),
    //     loaderColor: Colors.red
    // );
  }
}