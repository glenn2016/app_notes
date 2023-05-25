import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updatePublicNoteAverage(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final notesRef = FirebaseFirestore.instance.collection('notes');

  try {
    final userSnapshot = await userRef.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    double moyenneNotesPubliques = 0.0;

    final notesSnapshot = await notesRef.get();
    final notesData = notesSnapshot.docs.map((doc) => doc.data()).toList();
    print('User Notes: $notesData');

    if (notesData != null) {
      final userNotes = notesData
          .where((note) => note['userId'] == userId && note['cat'] == 'public')
          .toList();

      // Calculer la moyenne des notes publiques
      if (userNotes.isNotEmpty) {
        final sum = userNotes.fold(0.0, (total, note) => total + (double.parse(note['note'] ?? '0.0')));


        moyenneNotesPubliques = sum / userNotes.length;
      }
    }
    print('Moyenne Notes Publiques: $moyenneNotesPubliques');
   

    await userRef.update({
      'moyenneNotesPubliques':
          moyenneNotesPubliques, // Mettre à jour la moyenne dans Firestore
    });
  } catch (error) {
    print(error);
  }
}

Future<double> getPublicNoteAverage(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userSnapshot.exists) {
    double moyenneNotesPubliques = userSnapshot['moyenneNotesPubliques'] ?? 0.0;
    return moyenneNotesPubliques;
  } else {
    return 0.0;
  }
}
