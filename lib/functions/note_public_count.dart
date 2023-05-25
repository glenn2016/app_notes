import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updatePublicNoteCount(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final notesRef = FirebaseFirestore.instance.collection('notes');

  try {
    final userSnapshot = await userRef.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    int notePublicCount = 0;

    if (userData != null && userData.containsKey('notePublicCount')) {
      notePublicCount = userData['notePublicCount'] as int;
    }

    final notesSnapshot = await notesRef.get();
    final notesData = notesSnapshot.docs.map((doc) => doc.data()).toList();

    if (notesData != null) {
      final userNotes = notesData
          .where((note) => note['userId'] == userId && note['cat'] == 'public')
          .toList();
      notePublicCount = userNotes.length;
    }

    await userRef.update({'notePublicCount': notePublicCount});
  } catch (error) {
    print(error);
  }
}

Future<int> getPublicNoteCount(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userSnapshot.exists) {
    int notePublicCount = userSnapshot['notePublicCount'] ?? 0;
    return notePublicCount;
  } else {
    return 0;
  }
}
