import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateNoteEchueCount(String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final notesRef = FirebaseFirestore.instance.collection('notes');

  try {
    final userSnapshot = await userRef.get();
    final userData = userSnapshot.data() as Map<String, dynamic>;
    int noteEchueCount = 0;

    if (userData != null && userData.containsKey('noteEchueCount')) {
      noteEchueCount = userData['noteEchueCount'] as int;
    }

    final notesSnapshot = await notesRef.get();
    final notesData = notesSnapshot.docs.map((doc) => doc.data()).toList();

    if (notesData != null) {
      final userNotes = notesData
          .where((note) => note['userId'] == userId && note['status'] == 'échue')
          .toList();
      noteEchueCount = userNotes.length;
    }

    await userRef.update({'noteEchueCount': noteEchueCount});
  } catch (error) {
    print(error);
  }
}

Future<int> getNoteEchueCount(String userId) async {
  DocumentSnapshot userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userSnapshot.exists) {
    int noteEchueCount = userSnapshot['noteEchueCount'] ?? 0;
    return noteEchueCount;
  } else {
    return 0;
  }
}
