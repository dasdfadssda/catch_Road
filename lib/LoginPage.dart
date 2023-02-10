import 'package:catch2_0_1/screen/MyPage/MyPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Auth/auth_service .dart';
import 'join/joinPage.dart';
import 'join/joinStep3.dart';
import 'main.dart';
import 'screen/Camera/camera_load.dart';
import 'screen/mainHome.dart';
import 'utils/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

bool maintain = false;

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    login = false;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.25),
                child: Image.asset('assets/catch_road_logo.png', width: 170),
              ),
              // 아이디 또는 이메일 textfield
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.07,
                      left: size.width * 0.04,
                      right: size.width * 0.04),
                  child: SizedBox(
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(6, 61, 50, 50),
                          contentPadding: EdgeInsets.only(
                              top: size.height * 0.01, left: size.width * 0.04),
                          hintText: '아이디 또는 이메일',
                          hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )),
              // 비밀번호 textfield
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.015,
                      left: size.width * 0.04,
                      right: size.width * 0.04),
                  child: SizedBox(
                    child: TextField(
                      controller: passwordController,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          focusColor: Color.fromRGBO(0, 0, 0, 0.03),
                          contentPadding: EdgeInsets.only(top: 7, left: 15),
                          hintText: '비밀번호',
                          hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
                          // hintStyle: bodyLargeStyle(color: Color(0xff9FA5B2)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.0, left: size.width * 0.02
                        // right: size.width * 0.8,
                        ),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            maintain = !maintain;
                          });
                        },
                        icon: maintain
                            ? Image.asset('assets/checkbox_on.png', height: 23)
                            : Image.asset('assets/checkbox_un.png',
                                height: 23)),
                  ),
                  ////text style 적용하기
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.0),
                    child: Text("로그인 유지",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.2),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => forgotLogin(),
                                transitionDuration: Duration(seconds: 0),
                                transitionsBuilder: (_, a, __, c) =>
                                    FadeTransition(opacity: a, child: c)),
                          );
                        },
                        child: Text("로그인 정보를 잊으셨나요?",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xff2C63BB),
                                fontWeight: FontWeight.w700))),
                  )
                ],
              ),
              // 로그인 버튼
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.03),
                child: SizedBox(
                  width: size.width * 0.92,
                  height: size.height * 0.06,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Color.fromRGBO(58, 148, 238, 1)),
                      onPressed: () async {
                         print(login);
                        print(FirebaseAuth.instance.currentUser?.emailVerified);
                        await loginWithIdandPassword(
                            emailController.text, passwordController.text);
                        if (login&&FirebaseAuth.instance.currentUser?.emailVerified==true) {
                          //

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MainHomePage();
                          }));
                          setState(() {
                            loginplatform="email";
                          });
                        }
                      },
                      child: Text(
                        "로그인",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/icons/google_icon.png',
                        width: 50,
                      ),
                      onPressed: () async {
                        await signInWithGoogle();
                        //await Future.delayed(Duration(seconds: 10));
                        setState(() {
                          loginplatform="google";
                        });
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MainHomePage();
                        }));

                        userstart();
                      },
                      iconSize: 50,
                    ),
                    SizedBox(
                      width: size.width * 0.04,
                    ),
                    IconButton(
                        onPressed: () async {
                          signInWithApple();
                          print('apple login');
                        },
                        iconSize: 50,
                        icon: Image.asset(
                          'assets/icons/apple_icon.png',
                          width: 50,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.04),
                child: Text(
                  "계정이 없으신가요?",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      // joinPage
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return joinPage();
                      }));
                    },
                    child: Text("회원가입",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff2C63BB),
                            fontWeight: FontWeight.w500))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/////////로그인 정보를 잊으셨나요 ? //////////
class forgotLogin extends StatefulWidget {
  const forgotLogin({super.key});

  @override
  State<forgotLogin> createState() => _forgotLoginState();
}

class _forgotLoginState extends State<forgotLogin> {
  final TextEditingController emailController2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Center(child: Image.asset('assets/lock.png', width: 50)),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.04),
            child: Text("비밀번호를 잊으셨나요?"),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: Text("이메일을 입력하시면 \n 비밀번호 재설정 링크를 전송해드립니다",
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.04,
                left: size.width * 0.04,
                right: size.width * 0.04),
            child: Image.asset('assets/divider.png'),
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.019,
                  left: size.width * 0.04,
                  right: size.width * 0.04),
              child: SizedBox(
                width: size.width * 2.2,
                child: TextField(
                  controller: emailController2,
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                      focusColor: Color.fromRGBO(0, 0, 0, 0.03),
                      contentPadding: EdgeInsets.only(
                          top: size.height * 0.01, left: size.width * 0.04),
                      hintText: '이메일',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(0, 0, 0, 0.4)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                            width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.4)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide: BorderSide(
                            width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.4)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      filled: true,
                      fillColor: Color.fromRGBO(0, 0, 0, 0.03)),
                  keyboardType: TextInputType.emailAddress,
                ),
              )),
          // 다음 버튼
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: SizedBox(
              width: size.width * 0.92,
              height: size.height * 0.05,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      backgroundColor: Color(0xff2C63BB)),
                  onPressed: () async {
                    await resetPassword(emailController2.text.toString());

                    showModalBottomSheet<void>(
                      enableDrag: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Container(
                            height: size.height * 0.475,
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.05,
                                ),
                                SizedBox(
                                    height: 150,
                                    child: Image.asset(
                                        'assets/checkToFinish.gif')),
                                SizedBox(
                                  height: size.height * 0.025,
                                ),
                                Text('비밀번호 재설정 메일이 전송 되었습니다.'),
                                SizedBox(height: size.height * 0.025),
                                ElevatedButton(
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                          Size(307, 50)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Color(0xff3A94EE),
                                        //_onTap3? primary[40] : onSecondaryColor,
                                      ),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                    ),
                                    child: Text('확인',
                                        style: titleMediumStyle(
                                            color: Color(0xffFAFBFB))),
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return LoginPage();
                                      }));
                                    })
                              ],
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: Text(
                    "다음",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: TextButton(
                onPressed: () {
                  // signInWithGoogle();
                },
                child: Text("비밀번호를 잊으셨나요?",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff2C63BB),
                        fontWeight: FontWeight.w700))),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.04),
            child: Image.asset(
              'assets/divider.png',
              width: size.width * 0.9,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LoginPage(),
                        transitionDuration: Duration(seconds: 0),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c)),
                  );
                },
                child: Text("로그인으로 돌아가기",
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff2C63BB),
                        fontWeight: FontWeight.w700))),
          ),
        ],
      ),
    ));
  }
}

class findId extends StatefulWidget {
  const findId({super.key});

  @override
  State<findId> createState() => _findIdState();
}

class _findIdState extends State<findId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [Icon(Icons.exit_to_app)]),
    );
  }
}
