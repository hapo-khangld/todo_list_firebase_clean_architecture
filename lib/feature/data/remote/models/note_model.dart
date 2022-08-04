import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/feature/domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel(
    final String? noteId,
    final String? note,
    final Timestamp? time,
    final String? uid,
  ) : super(
          uid: uid,
          time: time,
          note: note,
          noteId: noteId,
        );

  factory NoteModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return NoteModel(
      documentSnapshot.get("noteId"),
      documentSnapshot.get("note"),
      documentSnapshot.get("time"),
      documentSnapshot.get("uid"),
    );
  }

  ///todo
  Map<String, dynamic> toDocument() {
    return {
      "noteId": noteId,
      "note": note,
      "time": time,
      "uid": uid,
    };
  }
}
