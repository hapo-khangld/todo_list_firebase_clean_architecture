import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase/feature/data/remote/data_sources/firbase_remote_data_source.dart';
import 'package:todo_firebase/feature/data/remote/models/note_model.dart';
import 'package:todo_firebase/feature/data/remote/models/user_model.dart';
import 'package:todo_firebase/feature/domain/entities/note_entity.dart';
import 'package:todo_firebase/feature/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> addNewNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection("users").doc(noteEntity.uid).collection("notes");
    final noteId = noteCollectionRef.doc().id;

    noteCollectionRef.doc(noteId).get().then((note) {
      final newNote = NoteModel(
        //todo:1
        noteId,
        noteEntity.note,
        noteEntity.time,
        noteEntity.uid,
      ).toDocument();

      if (!note.exists) {
        noteCollectionRef.doc(noteId).set(newNote);
      }
      return;
    });
  }

  @override
  Future<void> deleteNote(NoteEntity noteEntity) async {
    final noteCollectionRef =
        firestore.collection("users").doc(noteEntity.uid).collection("notes");

    noteCollectionRef.doc(noteEntity.noteId).get().then((note) {
      if (note.exists) {
        noteCollectionRef.doc(noteEntity.noteId).delete();
      }
      //todo: 2
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity userEntity) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUid();
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        userEntity.name,
        userEntity.email,
        uid,
        userEntity.status,
        userEntity.password,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUid() async => auth.currentUser!.uid;

  @override
  Stream<List<NoteEntity>> getNotes(String uid) {
    final noteCollectionRef =
        firestore.collection("users").doc(uid).collection("notes");

    return noteCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => NoteModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async {
    auth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateNote(NoteEntity note) async {
    //Map<String, dynamic> noteMap = Map();
    //covert
    Map<String, dynamic> noteMap = {};
    final noteCollectionRef =
        firestore.collection("users").doc(note.uid).collection("notes");

    if (note.note != null) {
      noteMap['note'] = note.note;
    }
    if (note.time != null) {
      noteMap['time'] = note.time;
    }

    noteCollectionRef.doc(note.noteId).update(noteMap);
  }
}
