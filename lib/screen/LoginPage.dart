import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.3),
                child: Image.asset('assets/logo.png', width: 170),
              ),
              // 아이디 또는 이메일 textfield
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.07,
                      left: size.width * 0.04,
                      right: size.width * 0.04),
                  child: SizedBox(
                    child: TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(6, 61, 50, 50),
                          contentPadding: EdgeInsets.only(
                              top: size.height * 0.01, left: size.width * 0.04),
                          hintText: '아이디 또는 이메일',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.4)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.03)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )),
              // 비밀번호 textfield
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.015,
                      left: size.width * 0.04,
                      right: size.width * 0.04),
                  child: const SizedBox(
                    child: TextField(
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          focusColor: Color.fromRGBO(0, 0, 0, 0.03),
                          contentPadding: EdgeInsets.only(top: 7, left: 15),
                          hintText: '비밀번호',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(0, 0, 0, 0.4)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.4)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.4)),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.03)),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  )),
              // Container(
              //   width: size.width,
              //   padding:
              //       EdgeInsets.only(left: 20, right: 20, top: size.height * 0.1),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ElevatedButton(
              //         onPressed: () async {
              //           signInWithGoogle();
              //           await Future.delayed(Duration(seconds: 10));
              //           userstart();
              //         },
              //         child: Wrap(
              //           crossAxisAlignment: WrapCrossAlignment.center,
              //           children: [
              //             Text('Sign in with Google'),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.0, left: size.width * 0.06
                        // right: size.width * 0.8,
                        ),
                    child: Image.asset('assets/passCheck.png', height: 23),
                  ),
                  ////text style 적용하기
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.0, left: size.width * 0.02),
                    child: Text("비밀번호 저장",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(0, 0, 0, 0.4),
                            fontWeight: FontWeight.w700)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: size.width * 0.3),
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
                  height: size.height * 0.05,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          backgroundColor: Color(0xff2C63BB)),
                      onPressed: () {},
                      child: Text(
                        "로그인",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: Image.asset(
                  'assets/divider.png',
                  width: size.width * 0.9,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.04),
                child: Text(
                  "계정이 없으신가요?",
                  style: TextStyle(fontSize: 12),
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
                    onPressed: () {},
                    child: Text("회원가입",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff2C63BB),
                            fontWeight: FontWeight.w700))),
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
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Center(child: Image.asset('assets/lock.png', width: 50)),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.04),
            child: Text("아이디를 잊으셨나요?"),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: Text("이메일을 입력하시면 잊어버리신\n아이디를 알려드립니다.",
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => findId(),
                          transitionDuration: Duration(seconds: 0),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c)),
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
                onPressed: () {},
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
    );
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
