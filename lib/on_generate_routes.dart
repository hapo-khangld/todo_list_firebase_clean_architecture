import 'package:flutter/material.dart';
import 'package:todo_firebase/app_const.dart';
import 'package:todo_firebase/feature/presentation/pages/sign_in_page.dart';

import 'feature/domain/entities/note_entity.dart';
import 'feature/presentation/pages/add_new_note_page.dart';
import 'feature/presentation/pages/sign_up_page.dart';
import 'feature/presentation/pages/update_note_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.kSignInPage:
        {
          return materialPageRoute(widget: const SignInPage());
        }
      case PageConst.kSignUpPage:
        {
          return materialPageRoute(widget: const SignUpPage());
        }
      case PageConst.kAddNotePage:
        {
          if (args is String) {
            return materialPageRoute(
              widget: AddNewNotePage(
                uid: args,
              ),
            );
          } else {
            return materialPageRoute(
              widget: const ErrorPage(),
            );
          }
        }
      case PageConst.kUpDateNotePage:
        {
          if (args is NoteEntity) {
            return materialPageRoute(
              widget: UpdateNotePage(
                noteEntity: args,
              ),
            );
          } else {
            return materialPageRoute(
              widget: const ErrorPage(),
            );
          }
        }
      default:
        return materialPageRoute(widget: const ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("error"),
      ),
      body: const Center(
        child: Text("error"),
      ),
    );
  }
}

MaterialPageRoute materialPageRoute({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
