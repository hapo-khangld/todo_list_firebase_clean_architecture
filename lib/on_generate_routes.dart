import 'package:flutter/material.dart';
import 'package:todo_firebase/app_const.dart';

class OnGenerateRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case PageConst.kAddNotePage:
        {
          return materialPageRoute(widget: const ErrorPage());
          break;
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
