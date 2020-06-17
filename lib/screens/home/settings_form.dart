import 'package:fastorder/models/user.dart';
import 'package:fastorder/models/userData.dart';
import 'package:fastorder/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fastorder/shared/constants.dart';
import 'package:fastorder/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  List<String> genders = ['Male', 'Female'];
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String _fullName;
  String _phoneNumber;
  String _gender;
  double _martialStatus;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user.isAnonymous) {
      return Container(
        child: Center(
          child: Text(
            'Register to update your profile',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        ),
      );
    } else {
      return loading
          ? Loading()
          : Form(
              key: _formKey,
              child: StreamBuilder<UserData>(
                  stream: DatabaseService(uid: user.uid).userData,
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    print(user.uid);
                    if (snapshot.hasData) {

                      UserData userData = snapshot.data;

                      return Column(
                        children: <Widget>[
                          Text(
                            "Update Your Profile",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                                fontFamily: 'Roboto'),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: _fullName ?? userData.name,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Full Name'),
                            validator: (val) =>
                                val.isEmpty ? 'Enter your Full Name' : null,
                            onChanged: (val) {
                              setState(() => _fullName = val);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            initialValue: _phoneNumber ?? userData.phoneNumber,
                            decoration: textInputDecoration.copyWith(
                                hintText: 'Phone Number'),
                            validator: (val) => val.length < 11
                                ? 'Enter a valid phone number'
                                : null,
                            onChanged: (val) {
                              setState(() => _phoneNumber = val);
                            },
                          ),
                          SizedBox(height: 20.0),
                          DropdownButtonFormField(
                            // iconEnabledColor: Colors.white,
                            decoration: textInputDecoration,
                            value: _gender ?? genders[0],
                            items: genders.map((gender) {
                              return DropdownMenuItem(
                                child: Text('$gender'),
                                value: gender,
                              );
                            }).toList(),
                            onChanged: (String value) =>
                                setState(() => _gender = value),
                          ),
                          SizedBox(height: 20.0),
                          Slider(
                              activeColor: Colors.brown[_martialStatus == null ? userData.maritalStatus.round() : _martialStatus.round()],
                              inactiveColor: Colors.brown[_martialStatus == null ? userData.maritalStatus.round() : _martialStatus.round()],
                              min: 100.0,
                              max: 900.0,
                              value: _martialStatus ?? userData.maritalStatus,
                              divisions: 8,
                              onChanged: (val) =>
                                  setState(() => _martialStatus = val )),
                          SizedBox(height: 5.0),
                          Expanded(
                            child: RaisedButton(
                                color: Colors.pink[400],
                                child: Text(
                                  'Update',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  try{
                                     await DatabaseService(uid: userData.uid)
                                      .updateUserData(
                                          _fullName ?? userData.name,
                                          _phoneNumber ?? userData.phoneNumber,
                                          _gender ?? userData.gender,
                                         _martialStatus ?? userData.maritalStatus
                                      );
                                      print('all is good');
                                  Navigator.pop(context);
                                  }catch(error) {
                                    print("Error don happend");
                                    print(error.toString());
                                  }
                               
                                }),
                          ),
                        ],
                      );
                    } else {
                      return Loading();
                    }
                  }),
            );
    }
  }
}
