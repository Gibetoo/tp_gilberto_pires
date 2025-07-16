const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.updateLastUpdatedAt = functions.firestore
    .document("posts/{postId}")
    .onUpdate((change, context) => {
      const newData = change.after.data();
      const previousData = change.before.data();

      if (
        newData.title !== previousData.title ||
      newData.description !== previousData.description
      ) {
        return change.after.ref.update({
          lastUpdatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      return null;
    });
