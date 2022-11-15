import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Google Login"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
            left: 20, right: 20, top: size.height * 0.2, bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed:() async{
                signInWithGoogle();
                 await Future.delayed(Duration(seconds:10));
                userstart();
              },
              child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Sign in with Google'),
        ],
      ),
              ),
               ElevatedButton(
              onPressed:() async{
               FirebaseAuth.instance.signInAnonymously();
                await Future.delayed(Duration(seconds:10));
               var doc = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid,); 
      doc.set({
        'status_message' : 'I promise to take the test honestly before GOD.',
        uid : FirebaseAuth.instance.currentUser!.uid,
      }).whenComplete(() => print('익명 로그인 성공'));
              },
              child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Guest'),
        ],
      ),
              )
          ],
        ),
      ),
    );
  }
}