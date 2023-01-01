import 'package:flutter/material.dart';
import '../Auth/user_information.dart';
import '../utils/app_text_styles.dart';
import 'joinStep2.dart';

class joinPage extends StatefulWidget {
  const joinPage({super.key});

  @override
  State<joinPage> createState() => _joinPageState();
}

class _joinPageState extends State<joinPage> {
  @override
  Widget build(BuildContext context) {
      final Emailcontroller = TextEditingController();
final _formKey = GlobalKey<FormState>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              Image.asset('assets/step1.png', width: size.width * 0.87),
              SizedBox(width: 12),
              Text("1/7", style: labelMediumStyle(color: Color(0xff9FA5B2)))
            ],
          ),
          SizedBox(height: size.height * 0.07),
          Text("이메일", style: titleLargeStyle(color: Color(0xff3174CD))),
          SizedBox(height: size.height * 0.02),
          Text("계정에 사용하실 이메일을 입력해주세요.\n이메일은 마에페이지에서 수정 가능합니다.",
              textAlign: TextAlign.center,
              style: labelMediumStyle(color: Color(0xff9FA5B2))),
          Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.07,
                  left: size.width * 0.06,
                  right: size.width * 0.06),
              child: SizedBox(
                height: size.height * 0.08,
                child: Form(
                   key: _formKey,
                  child: TextFormField(
                    validator: (val) {
                  if(val?.length == 0) {
                    return '이메일은 필수사항입니다.';
                  }
                  if(!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(val!)){
                    return '잘못된 이메일 형식입니다.';
                  }

                  return null;
                },
                    controller: Emailcontroller,
                    style: TextStyle(fontSize: 13),
                    decoration: InputDecoration(
                        focusColor: Color.fromARGB(6, 61, 50, 50),
                        contentPadding: EdgeInsets.only(
                            top: size.height * 0.01, left: size.width * 0.04),
                        hintText: '이메일을 입력해주세요',
                        // errorText: '이메일 형식으로 작성해주세요',
                        errorStyle: labelSmallStyle(color: Colors.red),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36.0)),
                          borderSide: BorderSide(
                              width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36.0)),
                          borderSide: BorderSide(
                              width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36.0)),
                          borderSide: BorderSide(
                              width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(36.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              )),
          SizedBox(height: size.height * 0.1),
          SizedBox(
              width: size.width * 0.85,
              height: size.height * 0.08,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xff3174CD),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  onPressed: () async {
                     if (_formKey.currentState!.validate()) {
                       Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => joinStep2(),
                            transitionDuration: Duration(seconds: 0),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c)),
                      );
                      code().email = Emailcontroller.text;
                     }
                  },
                  child: Text(
                    "이메일 입력하기",
                    style: titleMediumStyle(color: Color(0xffFAFBFB)),
                  )))
        ],
      ),
    );
  }
}
