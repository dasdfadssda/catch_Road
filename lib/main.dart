import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Auth/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       initialRoute: '/',
      // routes : {    //route 설정
      // '/' :(context) => MyApp(),
      // '/detail' : ((context) => DetailScreen())},
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      // home: MainHomePage()
      home : AuthService().handleAuthState()
    );
  }
}
