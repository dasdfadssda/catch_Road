import 'package:catch2_0_1/Auth/user_information.dart';
import 'package:catch2_0_1/join/joinPage.dart';
import 'package:catch2_0_1/join/joinStep2.dart';
import 'package:catch2_0_1/join/joinStep4.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../LoginPage.dart';
import '../join/joinStep3.dart';
import '../join/joinStep6.dart';
import '../screen/mainHome.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return MainHomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  void signOut() {}

  void signInWithGoogle() {}
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final User? user = _auth.currentUser;
final uid = user!.uid;
final GoogleSignIn googleSignIn = new GoogleSignIn();

final DateTime timestamp = DateTime.now();

final userReference = FirebaseFirestore.instance.collection('users');
// User? currentUser;

signInWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: <String>["email"]).signIn();

  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  DocumentSnapshot documentSnapshot =
      await userReference.doc(googleUser.email).get();

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

userstart() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((doc) async {
    print('?????? ??????');
    if (!doc.exists) {
      userReference.doc().set({
        'profileName': FirebaseAuth.instance.currentUser!.displayName!,
        'url': FirebaseAuth.instance.currentUser!.photoURL!,
        'email': FirebaseAuth.instance.currentUser!.email,
        'status_message': 'I promise to take the test honestly before GOD.',
        'uid': FirebaseAuth.instance.currentUser!.uid
      }).whenComplete(() {
        print('??????');
      });
    } else {
      print('?????? ?????? ?????????');
    }
  });
}

Future<void> signOut() async {
  // logOut ??????
  await _auth.signOut();
  print('logOut');
}


contentsFunction(
    user, _photo, TitleController, contentsController, priceController) async {
  //????????? ????????? ?????? (?????? ??????, ??????, ??????, ??? ?????? )

  // ??????????????? ?????? ?????? ????????? ?????? ??????.
  final firebaseStorageRef = FirebaseStorage.instance;
  List _like = [];
  List wish = [];
  if (_photo != null) {
    TaskSnapshot task = await firebaseStorageRef
        .ref() // ?????????
        .child('post') // collection ??????
        .child(
            '${_photo} + ${FirebaseAuth.instance.currentUser!.displayName!}') // ???????????? ????????? ????????????
        .putFile(_photo!);
    if (task != null) {
      var downloadUrl = await task.ref
          .getDownloadURL()
          .whenComplete(() => print('?????? ????????? ??????'));
      var doc = FirebaseFirestore.instance
          .collection('Product')
          .doc(priceController.text);
      doc.set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'id': doc.id,
        'datetime': DateTime.now().toString(),
        'displayName': FirebaseAuth.instance.currentUser!.displayName!,
        'title': TitleController.text,
        'content': contentsController.text,
        'imageUrl': downloadUrl,
        'price': priceController.text,
        'like': _like,
        'modify': ' ',
        'wish': wish
      }).whenComplete(() => print('????????? ?????? ??????'));
    } else {}
  } else {
    var doc = FirebaseFirestore.instance
        .collection('Product')
        .doc(priceController.text);
    doc.set({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'id': doc.id,
      'datetime': DateTime.now().toString(),
      'displayName': FirebaseAuth.instance.currentUser!.displayName!,
      'title': TitleController.text,
      'content': contentsController.text,
      'imageUrl': 'https://handong.edu/site/handong/res/img/logo.png',
      'price': priceController.text,
      'like': _like,
      'modify': ' ',
      'wish': wish
    }).whenComplete(() => print('????????? ?????? ??????'));
  }
}

contentsUpdate(user, _photo, TitleController, contentsController,
    priceController, url) async {
  final firebaseStorageRef = FirebaseStorage.instance;
  List _like = [];
  if (_photo != null) {
    TaskSnapshot task = await firebaseStorageRef
        .ref() // ?????????
        .child('post') // collection ??????
        .child(
            '${_photo} + ${FirebaseAuth.instance.currentUser!.displayName!}') // ???????????? ????????? ????????????
        .putFile(_photo!);

    if (task != null) {
      var downloadUrl = await task.ref
          .getDownloadURL()
          .whenComplete(() => print('?????? ????????? ??????'));
      var doc = FirebaseFirestore.instance
          .collection('Product')
          .doc(priceController.text);
      doc.update({
        'id': doc.id,
        'displayName': FirebaseAuth.instance.currentUser!.displayName!,
        'title': TitleController.text,
        'content': contentsController.text,
        'imageUrl': downloadUrl,
        'price': priceController.text,
        'like': _like,
        'modify': DateTime.now().toString(),
      }).whenComplete(() => print('????????? ?????? ??????'));
    }
  } else {
    var doc = FirebaseFirestore.instance
        .collection('Product')
        .doc(priceController.text);
    doc.update({
      'id': doc.id,
      'displayName': FirebaseAuth.instance.currentUser!.displayName!,
      'title': TitleController.text,
      'content': contentsController.text,
      'imageUrl': url,
      'price': priceController.text,
      'like': _like,
      'modify': DateTime.now().toString(),
    });
  }
}

LikeFunction(like, id, user) async {
  // ????????? ??????
  List _likes = like;
  _likes.add(user);
  var doc = FirebaseFirestore.instance.collection('Contents').doc(id);
  doc.update({
    '_like': _likes,
  }).whenComplete(() => print('????????? ???????????? ??????'));
}

LikeCancelFunction(like, id, user) async {
  // ????????? ??????
  List _likes = like;
  _likes.remove(user);
  var doc = FirebaseFirestore.instance.collection('Contents').doc(id);
  doc.update({
    '_like': _likes,
  }).whenComplete(() => print('????????? ???????????? ??????'));
}

Future<void> signUpWithEmailAndPassword() async {
  // ????????? ????????? ??????
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailCode().email, password: passwordCode().password);

    FirebaseFirestore.instance
        .collection('users')
        .doc()
        .set({
          'name': informationCode().name,
          'password': passwordCode().password,
          'email': emailCode().email,
          'birth': informationCode().year +
              '/' +
              informationCode().month +
              '/' +
              informationCode().day,
          'NickName': nicknameCode().nickname,
          'Bank': bankInformationCode().bankName,
          'Bank - Num': bankInformationCode().bankNum,
          '?????????': bankInformationCode().nameForBank
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to add user: $error'));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<void> loginWithIdandPassword(email, password) async {
  try {
    // sign in with email and password using signInWithEmailAndPassword()
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    // navigate to Homepage
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

void deleteUserFromFirebase() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  users.doc(FirebaseAuth.instance.currentUser!.uid).delete();
  User user = FirebaseAuth.instance.currentUser!;
  user.delete();
  await signOut();
}

