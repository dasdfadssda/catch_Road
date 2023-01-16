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
  var doc = FirebaseFirestore.instance.collection('Contents').doc(id);
  doc.update({
    '_like': _likes,
  }).whenComplete(() => print('좋아요 업데이트 성공'));
}

LikeCancelFunction(like, id, user) async {
  // 좋아요 기능
  List _likes = like;
  _likes.remove(user);
  var doc = FirebaseFirestore.instance.collection('Contents').doc(id);
  doc.update({
    '_like': _likes,
  }).whenComplete(() => print('좋아요 업데이트 성공'));
}

Future<void> signUpWithEmailAndPassword() async {
  // 이메일 로그인 생성
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
          '수취인': bankInformationCode().nameForBank
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
  // try {
  //   // sign in with email and password using signInWithEmailAndPassword()
  //   print('로그인');
  //   print(email.text);
  //   print(password.text);
  //   UserCredential userCredential = await FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email.text, password: password.text);
  //
  //   // navigate to Homepage
  // } on FirebaseAuthException catch (e) {
  //   if (e.code == 'user-not-found') {
  //     print('No user found for that email.');
  //   } else if (e.code == 'wrong-password') {
  //     print('Wrong password provided for that user.');
  //   }
  // }
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email.text,
        password: password.text) //아이디와 비밀번호로 로그인 시도
        .then((value) {
      print(value);
      value.user!.emailVerified == true //이메일 인증 여부
          ? print('로그인 성공')
          : print('이메일 확인 안댐');
      return value;
    });
  } on FirebaseAuthException catch (e) {
    //로그인 예외처리
    if (e.code == 'user-not-found') {
      print('등록되지 않은 이메일입니다');
    } else if (e.code == 'wrong-password') {
      print('비밀번호가 틀렸습니다');
    } else {
      print(e.code);
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

