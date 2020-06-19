import 'package:academy/models/user.dart';
import 'package:academy/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  // final String CLIENT_ID = "260896715197261";
  // final String REDIRECT_URL =
  //     'https://tedxsamonda-2163d.firebaseapp.com/__/auth/handler';

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, isAnonymous: user.isAnonymous)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

// sign in anon

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (errorMessage) {
      print(errorMessage.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithCred(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return {'data': _userFromFirebaseUser(user), 'error': null};
    } catch (error) {
      print(error.toString());
      return {'data': null, 'error': error};
    }
  }

  // register with email and password
  Future registerWithCred(
      String email, String password, String phoneNo, String fullName) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid)
          .updateUserData(fullName, phoneNo, 'Female', 100.0);

      return {'data': _userFromFirebaseUser(user), 'error': null};
    } catch (error) {
      print(error.toString());
      print(error);
      return {'data': null, 'error': error};
    }
  }

  // loginWithFacebook(BuildContext context) async {
  //   String result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => CustomWebView(
  //               selectedUrl:
  //                   'https://www.facebook.com/dialog/oauth?client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URL&response_type=token&scope=email,public_profile,',
  //             ),
  //         maintainState: true),
  //   );
  //   if (result != null) {
  //     try {
  //       final facebookAuthCred =
  //           FacebookAuthProvider.getCredential(accessToken: result);
  //       final user = await _auth.signInWithCredential(facebookAuthCred);
  //       print('user');
  //       print(user);
  //       print('user');
  //     } catch (e) {}
  //   }
  // }

  Future signInWithGoogle() async {
    try {
      print('a');
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      print('b');
      print(googleSignInAccount.toString());
      // final GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount.authentication;

      // print("1");

      // final AuthCredential credential = GoogleAuthProvider.getCredential(
      //   accessToken: googleSignInAuthentication.accessToken,
      //   idToken: googleSignInAuthentication.idToken,
      // );
      // print("2");

      // final AuthResult authResult =
      //     await _auth.signInWithCredential(credential);
      // print("3");
      // final FirebaseUser user = authResult.user;
      // print("4");

      // assert(!user.isAnonymous);
      // assert(await user.getIdToken() != null);
      // print("5");

      // final FirebaseUser currentUser = await _auth.currentUser();
      // print("6");
      // assert(user.uid == currentUser.uid);

      // print(user);
      // print("7");
      return {'data': null, 'error': null};
    } catch (error) {
      print(error.toString());
      return {'data': null, 'error': "Failed Authentication. Please try later"};
    }
  }

  Future _signOutGoogle() async {
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      return await _signOutGoogle();
    } catch (error) {
      print('error in signing out');
      print(error.toString());
      return null;
    }
  }
}
