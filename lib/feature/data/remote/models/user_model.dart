import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
  ) : super(
          uid: uid,
          email: email,
          name: name,
          status: status,
          password: password,
        );

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      documentSnapshot.get("name"),
      documentSnapshot.get("email"),
      documentSnapshot.get("uid"),
      documentSnapshot.get("status"),
      documentSnapshot.get("password"),
    );
  }

  ///todo
  Map<String, dynamic> toDocument() {
    return {
      "status": status,
      "uid": uid,
      "email": email,
      "name": name,
      "password": password,
    };
  }
}
