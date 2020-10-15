import 'package:coffee_app/models.dart/models.dart';
import 'package:coffee_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj base on FirebaseUser
  CustomUser _createCustomUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //Stream

  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_createCustomUser);
  }

  //SignIn Anon

  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return _createCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignOut
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register With Email And Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      //Create a FireStore Documents for the users with uid
      await DataBaseService(uid: user.uid).updateUserData("0", "UserName", 100);

      return _createCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignIn With Email And Password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _createCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
