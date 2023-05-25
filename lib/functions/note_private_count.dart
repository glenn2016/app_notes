import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updatePrivateNoteCount(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final notesRef = FirebaseFirestore.instance.collection('notes');

  try {
    final userSnapshot = await userRef.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    int notePrivateCount = 0;

    if (userData != null && userData.containsKey('notePrivateCount')) {
      notePrivateCount = userData['notePrivateCount'] as int;
    }

    final notesSnapshot = await notesRef.get();
    final notesData = notesSnapshot.docs.map((doc) => doc.data()).toList();

    if (notesData != null) {
      final userNotes = notesData
          .where((note) => note['userId'] == userId && note['cat'] == 'private')
          .toList();
      notePrivateCount = userNotes.length;
    }

    await userRef.update({'notePrivateCount': notePrivateCount});
  } catch (error) {
    print(error);
  }
}

Future<int> getPrivateNoteCount(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userSnapshot.exists) {
    int notePrivateCount = userSnapshot['notePrivateCount'] ?? 0;
    return notePrivateCount;
  } else {
    return 0;
  }
}
