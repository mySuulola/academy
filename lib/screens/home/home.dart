import 'package:fastorder/screens/home/settings_form.dart';
import 'package:fastorder/services/auth.dart';
import 'package:flutter/material.dart';

// stle

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                color: Colors.brown[300],
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm());
          });
    }

    return Container(
        child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Academy'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          Container(
            child: FlatButton(
              child: Icon(Icons.settings, color: Colors.white70),
              onPressed: () => _showSettingsPanel(),
            ),
          ),
          FlatButton.icon(
              padding: EdgeInsets.all(0),
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white70,
              ),
              label: Text(
                'logout',
                style: TextStyle(color: Colors.white70),
              ))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/people.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 10.0),
          child: Text(
            'Hello there',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    ));
  }
}
