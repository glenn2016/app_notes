import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updatePrivateNoteAverage(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final notesRef = FirebaseFirestore.instance.collection('notes');

  try {
    final userSnapshot = await userRef.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    double moyenneNotesPrivees = 0.0;

    final notesSnapshot = await notesRef.get();
    final notesData = notesSnapshot.docs.map((doc) => doc.data()).toList();

    if (notesData != null) {
      final userNotes = notesData
          .where((note) => note['userId'] == userId && note['cat'] == 'private')
          .toList();

      // Calculer la moyenne des notes privées
      if (userNotes.isNotEmpty) {
        final sum = userNotes.fold(0.0,
            (total, note) => total + (double.parse(note['note'] ?? '0.0')));

        moyenneNotesPrivees = sum / userNotes.length;
      }
    }

    // Arrondir la moyenne à deux chiffres après la virgule

    await userRef.update({
      'moyenneNotesPrivees':
          moyenneNotesPrivees, // Mettre à jour la moyenne dans Firestore
    });
  } catch (error) {
    print(error);
  }
}

Future<double> getPrivateNoteAverage(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userSnapshot.exists) {
    double moyenneNotesPrivees = userSnapshot['moyenneNotesPrivees'] ?? 0.0;
    return moyenneNotesPrivees;
  } else {
    return 0.0;
  }
}
