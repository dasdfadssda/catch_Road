import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Auth/auth_service.dart';
import 'firebase_options.dart';
import 'screen/Community/DetailPage.dart';
import 'screen/mainHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          //route 설정
          // '/': (context) => MyApp(),
          '/detail': ((context) => DetailScreen())
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        // home: test());
        // home: MainHomePage());
    home:MainHomePage());// AuthService().handleAuthState());
  }
}

class test extends StatefulWidget {
  const test({super.key});
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
