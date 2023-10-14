import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin(BuildContext context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    notifyListeners();
    Navigator.of(context).pop();
  }
  
  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
