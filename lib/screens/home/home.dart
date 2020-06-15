import 'package:fastorder/services/auth.dart';
import 'package:flutter/material.dart';

// stle

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              }, 
              icon: Icon(Icons.person, color: Colors.white70,), 
              label: Text(
                'logout', 
                style: TextStyle( color: Colors.white70),
                )
              )
          ],
        ),
      )
      
    );
  }
}