import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/feature/presentation/cubit/authen/auth_cubit.dart';
import 'package:todo_firebase/feature/presentation/cubit/note/note_cubit.dart';
import 'package:todo_firebase/feature/presentation/cubit/user/user_cubit.dart';
import 'package:todo_firebase/on_generate_routes.dart';

import 'feature/presentation/pages/home_page.dart';
import 'feature/presentation/pages/sign_in_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => di.getIt<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (context) => di.getIt<UserCubit>()),
        BlocProvider<NoteCubit>(create: (context) => di.getIt<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                print('User Logged');
                return HomePage(
                  uid: authState.uid,
                );
              }
              if (authState is UnAuthenticated) {
                print("User not Logged");
                return const SignInPage();
              }
              return const Center(child: CircularProgressIndicator());
            });
          }
        },
      ),
    );
  }
}
