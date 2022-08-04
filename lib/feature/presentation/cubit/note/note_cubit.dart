import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/feature/domain/entities/note_entity.dart';

import '../../../domain/use_cases/add_new_note_usecase.dart';
import '../../../domain/use_cases/delete_note_usecase.dart';
import '../../../domain/use_cases/get_note_usecase.dart';
import '../../../domain/use_cases/update_note_usecase.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final UpdateNoteUseCase updateNoteUseCase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final GetNoteUseCase getNoteUseCase;
  final AddNewNoteUseCase addNewNoteUseCase;
  NoteCubit({
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
    required this.getNoteUseCase,
    required this.addNewNoteUseCase,
  }) : super(NoteInitial());

  Future<void> addNotes({required NoteEntity noteEntity}) async {
    try {
      await addNewNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> deleteNotes({required NoteEntity noteEntity}) async {
    try {
      await deleteNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> updateNotes({required NoteEntity noteEntity}) async {
    try {
      await updateNoteUseCase.call(noteEntity);
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> getNotes({required String uid}) async {
    emit(NoteLoading());
    try {
      getNoteUseCase.call(uid).listen((notes) {
        emit(NoteLoaded(notes: notes));
      });
    } on SocketException catch (_) {
      emit(NoteFailure());
    } catch (_) {
      emit(NoteFailure());
    }
  }
}
