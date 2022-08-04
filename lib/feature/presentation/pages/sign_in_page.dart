import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/feature/presentation/cubit/authen/auth_cubit.dart';
import 'package:todo_firebase/feature/presentation/pages/home_page.dart';

import '../../../app_const.dart';
import '../../domain/entities/user_entity.dart';
import '../cubit/user/user_cubit.dart';
import '../widgets/common.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldGlobalKey =
      GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            print('User Success');
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                print("User authen");
                return HomePage(
                  uid: authState.uid,
                );
              } else {
                print("User not authen");
                return _bodyWidget();
              }
            });
          }
          print("user failed");
          return _bodyWidget();
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (userState is UserFailure) {
            snackBarError(
                msg: "invalid email", scaffoldState: _scaffoldGlobalKey);
          }
        },
      ),
    );
  }

  _bodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30.0,
        ),
        SizedBox(
          height: 120.0,
          child: Image.network(
            'https://raw.githubusercontent.com/amirk3321/my-notes-app/main/assets/notebook.png',
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                hintText: 'Enter your email', border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
                hintText: 'Enter your Password', border: InputBorder.none),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            submitSignIn();
          },
          child: Container(
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.deepOrange.withOpacity(.8),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                context, PageConst.kSignUpPage, (route) => false);
          },
          child: Container(
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.8),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  void submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
        userEntity: UserEntity(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }
}
