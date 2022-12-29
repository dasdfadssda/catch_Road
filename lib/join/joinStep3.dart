import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';
import 'joinStep4.dart';

class joinStep3 extends StatefulWidget {
  const joinStep3({super.key});

  @override
  State<joinStep3> createState() => _joinStep3State();
}

bool isObscure = false;

class _joinStep3State extends State<joinStep3> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Color(0xffCFD2D9),
            )),
        centerTitle: true,
        title: Text(
          "회원가입",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/step3.png', width: size.width * 0.87),
              SizedBox(width: 12),
              Text("3/7", style: labelMediumStyle(color: Color(0xff9FA5B2)))
            ],
          ),
          SizedBox(height: size.height * 0.07),
          Text("사용자 정보 입력", style: titleLargeStyle(color: Color(0xff3174CD))),
          SizedBox(height: size.height * 0.02),
          Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.07,
                  left: size.width * 0.06,
                  right: size.width * 0.06),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("이름",
                          style: titleSmallStyle(color: Color(0xff9FA5B2))),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                    child: TextField(
                      obscureText: isObscure ? true : false,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          focusColor: Color.fromARGB(6, 61, 50, 50),
                          contentPadding: EdgeInsets.only(
                              top: size.height * 0.01, left: size.width * 0.04),
                          hintText: '',
                          errorText: '',
                          errorStyle: labelSmallStyle(color: Colors.red),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(36.0)),
                            borderSide: BorderSide(
                                width: 0.5,
                                color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
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
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Row(
                    children: [
                      Text("생년월일",
                          style: titleSmallStyle(color: Color(0xff9FA5B2))),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Row(
                    children: [
                      // 태어난 년도
                      SizedBox(
                        width: size.width * 0.26,
                        child: TextField(
                          obscureText: isObscure ? true : false,
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                              focusColor: Color.fromARGB(6, 61, 50, 50),
                              contentPadding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.04),
                              hintText: '',
                              errorText: '',
                              errorStyle: labelSmallStyle(color: Colors.red),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36.0)),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36.0)),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2)),
                              ),
                              hintStyle:
                                  bodyMediumStyle(color: Color(0xff9FA5B2)),
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.04,
                            bottom: size.height * 0.02),
                        child: Text(
                          "년",
                          style: bodyLargeStyle(color: Colors.black),
                        ),
                      ),
                      // 태어난 월
                      SizedBox(
                        width: size.width * 0.155,
                        child: TextField(
                          obscureText: isObscure ? true : false,
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                              focusColor: Color.fromARGB(6, 61, 50, 50),
                              contentPadding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.04),
                              hintText: '',
                              errorText: '',
                              errorStyle: labelSmallStyle(color: Colors.red),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36.0)),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36.0)),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2)),
                              ),
                              hintStyle:
                                  bodyMediumStyle(color: Color(0xff9FA5B2)),
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.04,
                            bottom: size.height * 0.02),
                        child: Text(
                          "월",
                          style: bodyLargeStyle(color: Colors.black),
                        ),
                      ),
                      //태어난 일
                      SizedBox(
                        width: size.width * 0.155,
                        child: TextField(
                          obscureText: isObscure ? true : false,
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                              focusColor: Color.fromARGB(6, 61, 50, 50),
                              contentPadding: EdgeInsets.only(
                                  top: size.height * 0.01,
                                  left: size.width * 0.04),
                              hintText: '',
                              errorText: '',
                              errorStyle: labelSmallStyle(color: Colors.red),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36.0)),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(36.0)),
                                borderSide: BorderSide(
                                    width: 0.5,
                                    color: Color.fromRGBO(0, 0, 0, 0.2)),
                              ),
                              hintStyle:
                                  bodyMediumStyle(color: Color(0xff9FA5B2)),
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02,
                            right: size.width * 0.04,
                            bottom: size.height * 0.02),
                        child: Text(
                          "일",
                          style: bodyLargeStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(height: size.height * 0.1),
          SizedBox(
              width: size.width * 0.85,
              height: size.height * 0.08,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      disabledBackgroundColor: Color(0xffCFD2D9),
                      foregroundColor: Color(0xff3A94EE),
                      backgroundColor: Color(0xffCFD2D9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => joinStep4(),
                          transitionDuration: Duration(seconds: 0),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c)),
                    );
                  },
                  child: Text(
                    "다음",
                    style: titleMediumStyle(color: Color(0xff9FA5B2)),
                  )))
        ],
      ),
    );
  }
}
