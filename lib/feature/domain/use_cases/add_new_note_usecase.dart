import 'package:todo_firebase/feature/domain/entities/note_entity.dart';
import 'package:todo_firebase/feature/domain/repositories/firebase_repository.dart';

class AddNewNoteUseCase {
  final FirebaseRepository repository;

  AddNewNoteUseCase({
    required this.repository,
  });

  Future<void> call(NoteEntity note) async {
    return repository.addNewNote(note);
  }
}
