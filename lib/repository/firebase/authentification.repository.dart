import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }


Future<UserCredential> signUp(String email, String password, String nom) async {
  try {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = userCredential.user;
    if (user != null) {
      // Utilisateur créé avec succès, enregistrer les attributs supplémentaires dans Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'nom': nom,
        'notePrivateCount': 0,
        'notePublicCount' : 0,
        'moyenneNotesPrivees' : 0.0,
        'moyenneNotesPubliques' : 0.0,
         // NoteCount initialisé à 0 pour un nouvel utilisateur
      });

      return userCredential;
    } else {
      // Gérer le cas où l'utilisateur est nul
      throw Exception('Failed to create user');
    }
  } catch (e) {
    throw Exception('Failed to create user: $e');
  }
}

  Future<void> resetPassword(String email) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
