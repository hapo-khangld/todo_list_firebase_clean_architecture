import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/feature/domain/entities/user_entity.dart';

import '../../../domain/use_cases/get_create_current_user_usecase.dart';
import '../../../domain/use_cases/sign_in_usecase.dart';
import '../../../domain/use_cases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  UserCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCreateCurrentUserUseCase,
  }) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity userEntity}) async {
    emit(UserLoading());
    try {
      await signInUseCase.call(userEntity);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity userEntity}) async {
    emit(UserLoading());
    try {
      await signUpUseCase.call(userEntity);
      await getCreateCurrentUserUseCase.call(userEntity);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
