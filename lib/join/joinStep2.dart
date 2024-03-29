import 'package:catch2_0_1/join/emailVerify.dart';
import 'package:flutter/material.dart';
import '../Auth/auth_service .dart';
import '../Auth/user_information.dart';
import '../utils/app_text_styles.dart';
import 'joinStep3.dart';

String _password = '';
class passwordCode extends ChangeNotifier {
  String password= _password;
  notifyListeners();
}

class joinStep2 extends StatefulWidget {
  const joinStep2({super.key});

  @override
  State<joinStep2> createState() => _joinStep2State();
}

bool isObscure = false;

    final _formKey2 = GlobalKey<FormState>();
class _joinStep2State extends State<joinStep2> {
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              passwordcontroller.clear();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/step2.png', width: size.width * 0.87),
                SizedBox(width: 12),
                Text("2/7", style: labelMediumStyle(color: Color(0xff9FA5B2)))
              ],
            ),
            SizedBox(height: size.height * 0.07),
            Text("비밀번호", style: titleLargeStyle(color: Color(0xff3174CD))),
            SizedBox(height: size.height * 0.02),
            Text("계정에 사용하실 비밀번호를 입력해주세요.\n숫자를 포함하여 8자리이상으로 작성해주세요.",
                textAlign: TextAlign.center,
                style: labelMediumStyle(color: Color(0xff9FA5B2))),
            Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.07,
                    left: size.width * 0.06,
                    right: size.width * 0.06),
                child: SizedBox(
                  height: size.height * 0.08,
                  child:  Form(
                    key: _formKey2,
                    child: TextFormField(
                      validator: (val) {
                        if (val!.length == 0) {
                          return '비밀번호는 필수사항입니다.';
                        }
                        if (val.length < 8 || val.length >=13) {
                          return '8~12자리를 입력해주세요!';
                        }
                        if(!RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\w\W]{8,}$')
                            .hasMatch(val)){
                          return '숫자와 영문 조합 최소 8자리를 입력해주세요';
                        }


                        return null;
                      },
                      controller: passwordcontroller,
                      obscureText: isObscure ? true : false,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                  print(isObscure);
                                });
                              },
                              icon: isObscure
                                  ? Image.asset('assets/icons/eye_active.png')
                                  : Image.asset('assets/icons/eye_inactive.png')),
                          suffixIconConstraints: BoxConstraints(minHeight: 6, minWidth: 16),
                          focusColor: Color.fromARGB(6, 61, 50, 50),
                          contentPadding: EdgeInsets.only( left: 30),
                          hintText: '',
                          errorText: '',
                          errorStyle: labelSmallStyle(color: Colors.red),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide:
                            BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide:
                            BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide:
                            BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(36.0)),
                            borderSide:
                            BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    onPressed: () async {
                      if (_formKey2.currentState!.validate()) {

                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>EmailVerity(),//joinStep3(),
                              transitionDuration: Duration(seconds: 0),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c)),
                        );
                        _password = passwordcontroller.text;
                        print('새로 지정된 비밀번호는 : ${passwordCode().password}');
                      }
                    },
                    child: Text(
                      "다음",
                      style: titleMediumStyle(color: Color(0xffFAFBFB)),
                    )))
          ],
        ),
      ),
    );
  }

  // Widget _FormPassword() {
  //   return
  // }
 }
