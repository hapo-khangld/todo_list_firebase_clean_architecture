import 'package:todo_firebase/feature/domain/entities/note_entity.dart';
import 'package:todo_firebase/feature/domain/repositories/firebase_repository.dart';

class GetNoteUseCase {
  final FirebaseRepository repository;

  GetNoteUseCase({required this.repository});

  Stream<List<NoteEntity>> call(String uid) {
    return repository.getNotes(uid);
  }
}
