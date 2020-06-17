import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastorder/models/userData.dart';
import 'package:meta/meta.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ @required this.uid });

  // collection reference

  final CollectionReference academyCollection = Firestore.instance.collection('academy');
  final CollectionReference userInforCollection = Firestore.instance.collection('users');

  Future updateUserData(String fullName, String phoneNo, String gender, double maritalStatus) async {
    return await userInforCollection.document(uid).setData({
      'name': fullName,
      'phoneNumber': phoneNo,
      'gender': gender,
      'martialStatus': maritalStatus,
    });
  }

 
  Stream<UserData> get userData {
    return userInforCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
      }
    
    
    
    
      UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
        return UserData(
          uid: uid,
          name: snapshot.data['name'],
          phoneNumber: snapshot.data['phoneNumber'],
          gender: snapshot.data['gender'],
          maritalStatus: snapshot.data['martialStatus'],
        );
  }
}