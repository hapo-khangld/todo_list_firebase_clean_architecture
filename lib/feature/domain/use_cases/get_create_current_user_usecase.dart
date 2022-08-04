import 'package:todo_firebase/feature/domain/entities/user_entity.dart';
import 'package:todo_firebase/feature/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
