import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../screen/LoginPage.dart';
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
// final GoogleSignInAccount? gCurrentUser = googleSignIn.currentUser;

final userReference = FirebaseFirestore.instance.collection('users');
// User? currentUser;

signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: <String>["email"]).signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  // saveUserInfoFirestore();
  DocumentSnapshot documentSnapshot =
      await userReference.doc(googleUser.email).get();

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

userstart() {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((doc) async {
    print('회원 관리');
    if (!doc.exists) {
      userReference.doc().set({
        'profileName': FirebaseAuth.instance.currentUser!.displayName!,
        'url': FirebaseAuth.instance.currentUser!.photoURL!,
        'email': FirebaseAuth.instance.currentUser!.email,
        'status_message': 'I promise to take the test honestly before GOD.',
        'uid': FirebaseAuth.instance.currentUser!.uid
      }).whenComplete(() {
        print('완료');
      });
    } else {
      print('이미 있는 아이디');
    }
  });
}

Future<void> signOut() async {
  // logOut 기능
  await _auth.signOut();
  print('logOut');
}

contentsFunction(
    user, _photo, TitleController, contentsController, priceController) async {
  //파이어 베이스 저장 (유저 이름, 사진, 제목, 글 내용 )

  // 스토리지에 먼저 사진 업로드 하는 부분.
  final firebaseStorageRef = FirebaseStorage.instance;
  List _like = [];
  List wish = [];
  if (_photo != null) {
    TaskSnapshot task = await firebaseStorageRef
        .ref() // 시작점
        .child('post') // collection 이름
        .child(
            '${_photo} + ${FirebaseAuth.instance.currentUser!.displayName!}') // 업로드한 파일의 최종이름
        .putFile(_photo!);
    //  var doc = FirebaseFirestore.instance.collection('Product').doc(priceController.text);
    //     doc.set({
    //       'id': doc.id,
    //       'datetime' : DateTime.now().toString(),
    //       'displayName':FirebaseAuth.instance.currentUser!.displayName!,
    //       'title' : TitleController.text,
    //       'content' : contentsController.text,
    //       'imageUrl' : _photo,
    //       'price' : priceController.text,
    //       'like' : _like,
    //     }).whenComplete(() => print('데이터 저장 성공'));
    if (task != null) {
      var downloadUrl = await task.ref
          .getDownloadURL()
          .whenComplete(() => print('사진 만들기 성공'));
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
      }).whenComplete(() => print('데이터 저장 성공'));
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
    }).whenComplete(() => print('데이터 저장 성공'));
  }
}

contentsUpdate(user, _photo, TitleController, contentsController,
    priceController, url) async {
  final firebaseStorageRef = FirebaseStorage.instance;
  List _like = [];
  if (_photo != null) {
    TaskSnapshot task = await firebaseStorageRef
        .ref() // 시작점
        .child('post') // collection 이름
        .child(
            '${_photo} + ${FirebaseAuth.instance.currentUser!.displayName!}') // 업로드한 파일의 최종이름
        .putFile(_photo!);

    if (task != null) {
      var downloadUrl = await task.ref
          .getDownloadURL()
          .whenComplete(() => print('사진 만들기 성공'));
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
      }).whenComplete(() => print('데이터 저장 성공'));
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
  // 좋아요 기능
  List _likes = like;
  _likes.add(user);
  var doc = FirebaseFirestore.instance.collection('Product').doc(id);
  doc.update({'like': _likes, '${user}': user}).whenComplete(
      () => print('좋아요 업데이트 성공'));
}

Wishlist(
    user, TitleController, contentsController, priceController, url, wish) {
  var doc = FirebaseFirestore.instance
      .collection('${FirebaseAuth.instance.currentUser!.displayName!}Wish')
      .doc(priceController.text);
  doc.set({
    'id': doc.id,
    'displayName': FirebaseAuth.instance.currentUser!.displayName!,
    'title': TitleController.text,
    'content': contentsController.text,
    'imageUrl': url,
    'price': priceController.text,
    'wish': wish
  }).whenComplete(() => print('데이터 저장 성공'));
}

wishupdate(user, priceController, num, list) {
  //
  var doc = FirebaseFirestore.instance
      .collection('Product')
      .doc(priceController.text);
  if (num == 0) {
    doc.update({'wish': list}).whenComplete(() => print('위시 성공'));
  } else {
    doc.update({'wish': list}).whenComplete(() => print('위시 삭제'));
  }
}

wishupdateTowish(user, priceController, num, list) {
  //
  var doc =
      FirebaseFirestore.instance.collection('Product').doc(priceController);
  if (num == 0) {
    doc.update({'wish': list}).whenComplete(() => print('위시 성공'));
  } else {
    doc.update({'wish': list}).whenComplete(() => print('위시 삭제'));
  }
}
