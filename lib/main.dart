import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/on_generate_routes.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: OnGenerateRoutes.routes,
      routes: {
        "/": (context) {
          return Container();
        }
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material AppBar'),
        ),
        body: const Center(
          child: Text("Hello Word"),
        ),
      ),
    );
  }
}
