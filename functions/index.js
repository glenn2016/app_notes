const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.countNotesByUser = functions.database.ref('/notes/{noteId}').onWrite(async (change) => {
    const noteSnapshot = change.after;
    const noteData = noteSnapshot.val();
  
    const userId = noteData.userId;
  
    const userRef = admin.database().ref(`/users/${userId}`);
    const userSnapshot = await userRef.once('value');
    const userData = userSnapshot.val();
  
    let noteCount = 0;
    if (userData && userData.noteCount) {
      noteCount = userData.noteCount;
    }
  
    if (change.after.exists() && !change.before.exists()) {
      noteCount++;
    } else if (!change.after.exists() && change.before.exists()) {
      noteCount--;
    }
  
    await userRef.update({ noteCount });
  });
  