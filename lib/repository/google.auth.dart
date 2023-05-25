import 'package:app_notes/pages/home.page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Service {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();
  Future<void> googleSignin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSigninAccount = await _googleSignIn.signIn();
      if (googleSigninAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentification =
            await googleSigninAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentification.idToken,
          accessToken: googleSignInAuthentification.accessToken,
        );
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          enregistrerUser(userCredential);
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> enregistrerUser(UserCredential userCredential) async {
    const storage = FlutterSecureStorage();
    await storage.write(
      key: "token",
      value: userCredential.credential?.token.toString(),
    );
    await storage.write(
      key: "userCredential",
      value: userCredential.toString(),
    );
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> logOut() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}