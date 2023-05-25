import 'package:app_notes/bloc/note/note.dart';
import 'package:app_notes/functions/note_private_count.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteRepository {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  //

  Future<bool> addNote({
    required String matiere,
    required String note,
    required bool isPublic,
    required bool isPrivate,
  }) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) {
        throw Exception('No user is currently signed in.');
      }

      String userId = currentUser.uid;

      String cat = isPublic ? 'public' : 'private';

      await FirebaseFirestore.instance.collection('notes').add({
        'matiere': matiere,
        'note': note,
        'userId': userId,
        'cat': cat,
      });

      return true;
    } catch (e) {
      throw Exception('Failed to add note');
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesCollection.doc(noteId).delete();
    } catch (e) {
      throw Exception('Failed to delete note');
    }
  }

  Future<void> updateNote({
    required String noteId,
    required String matiere,
    required String note,
  }) async {
    try {
      await _notesCollection.doc(noteId).update({
        'matiere': matiere,
        'note': note,
      });
    } catch (e) {
      throw Exception('Failed to update note');
    }
  }

  // Stream<List<Note>> getNotes() {
  //   return _notesCollection.snapshots().map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       return Note(
  //         id: doc.id,
  //         matiere: data['matiere'], // Utilisation de l'opérateur de null-check ?. pour récupérer la propriété matiere si data n'est pas null
  //       note: data['note'],
  //       );
  //     }).toList();
  //   });
  // }

  Stream<List<Note>> getPrivateNotes(String userId) {
    return _notesCollection
        .where('userId',
            isEqualTo:
                userId) // Filtrer les notes par l'ID de l'utilisateur connecté
        .where('cat',
            isEqualTo:
                'private') // Filtrer les notes par la valeur de 'cat' égale à "private"
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          matiere: data['matiere'],
          note: data['note'],
        );
      }).toList();
    });
  }

  Stream<List<Note>> getPublicNotes() {
    return _notesCollection
        .where('cat',
            isEqualTo:
                'public') // Filtrer les notes par la valeur de 'cat' égale à "private"
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          matiere: data['matiere'],
          note: data['note'],
        );
      }).toList();
    });
  }

  Future<String> getUsername(String uid) async {
    final userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      final username = userData['nom'] as String;
      return username;
    } else {
      return '';
    }
  }
}
