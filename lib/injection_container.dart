import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/feature/data/remote/data_sources/firbase_remote_data_source.dart';
import 'package:todo_firebase/feature/data/remote/data_sources/firebase_remote_data_source_impl.dart';
import 'package:todo_firebase/feature/data/repositories/firebase_repository_impl.dart';
import 'package:todo_firebase/feature/domain/repositories/firebase_repository.dart';
import 'package:todo_firebase/feature/domain/use_cases/add_new_note_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/delete_note_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/get_current_uid_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/get_note_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/is_sign_in_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/sign_in_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/sign_out_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/sign_up_usecase.dart';
import 'package:todo_firebase/feature/domain/use_cases/update_note_usecase.dart';
import 'package:todo_firebase/feature/presentation/cubit/authen/auth_cubit.dart';
import 'package:todo_firebase/feature/presentation/cubit/note/note_cubit.dart';
import 'package:todo_firebase/feature/presentation/cubit/user/user_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  //Cubit/Bloc
  getIt.registerFactory<AuthCubit>(() => AuthCubit(
      getCurrentUidUseCase: getIt.call(),
      isSignInUseCase: getIt.call(),
      signOutUseCase: getIt.call()));
  getIt.registerFactory<UserCubit>(() => UserCubit(
      signInUseCase: getIt.call(),
      signUpUseCase: getIt.call(),
      getCreateCurrentUserUseCase: getIt.call()));
  getIt.registerFactory<NoteCubit>(() => NoteCubit(
      updateNoteUseCase: getIt.call(),
      deleteNoteUseCase: getIt.call(),
      getNoteUseCase: getIt.call(),
      addNewNoteUseCase: getIt.call()));

  //useCase
  getIt.registerLazySingleton<AddNewNoteUseCase>(
      () => AddNewNoteUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<GetNoteUseCase>(
      () => GetNoteUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: getIt.call()));
  getIt.registerLazySingleton<UpdateNoteUseCase>(
      () => UpdateNoteUseCase(repository: getIt.call()));

  //repository
  getIt.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: getIt.call()));

  //datasource
  getIt.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(
          auth: getIt.call(), firestore: getIt.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  getIt.registerLazySingleton(() => auth);
  getIt.registerLazySingleton(() => fireStore);
}
