import 'package:todo_firebase/feature/domain/entities/note_entity.dart';
import 'package:todo_firebase/feature/domain/repositories/firebase_repository.dart';

class AddNewTaskUseCase {
  final FirebaseRepository repository;

  AddNewTaskUseCase({
    required this.repository,
  });

  Future<void> call(NoteEntity note) async {
    return repository.addNewNote(note);
  }
}
