import 'package:flutter/material.dart';
import '../Auth/user_information.dart';
import '../utils/app_text_styles.dart';
import 'joinStep4.dart';


String _displayName = '';
String _id = '';
String _year = '';
String _month = '';
String _day = '';

class informationCode extends ChangeNotifier {
  String name = _displayName;
  String year = _year;
  String month = _month;
  String day = _day;
  notifyListeners();
}
class joinStep3 extends StatefulWidget {
  const joinStep3({super.key});

  @override
  State<joinStep3> createState() => _joinStep3State();
}

bool isObscure = false;
  final Namecontroller = TextEditingController();
    final Yearcontroller = TextEditingController();
    final Monthcontroller = TextEditingController();
    final Daycontroller = TextEditingController();
    final _formNameKey = GlobalKey<FormState>();
    final _formyearKey = GlobalKey<FormState>();
    final _formmonthKey = GlobalKey<FormState>();
    final _formdatKey = GlobalKey<FormState>();


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
      body: SingleChildScrollView(
        child: Column(
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
                      child: _formName()
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
                          child: formYear()
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
                          child: formMonth()
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
                          child: formDay()
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
                        backgroundColor: Color(0xff3174CD),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    onPressed: () {
                      if (_formNameKey.currentState!.validate()) {
                        if (_formyearKey.currentState!.validate()) {
                          if (_formmonthKey.currentState!.validate()) {
                            if (_formdatKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => joinStep4(),
                                    transitionDuration: Duration(seconds: 0),
                                    transitionsBuilder: (_, a, __, c) =>
                                        FadeTransition(opacity: a, child: c)),
                              );
                              _displayName = Namecontroller.text;
                              _year = Yearcontroller.text;
                              _month = Monthcontroller.text;
                              _day = Daycontroller.text;
                              print('이름은 : ${informationCode().name}');
                              print('${informationCode().year}년생 ${informationCode().month}월 ${informationCode().day}일');
                            }
                          }
                        }
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

  void nextEdit() {
    do {
      FocusScope.of(context).nextFocus();
    } while (
        FocusScope.of(context).focusedChild!.context!.widget is! EditableText);
  }

  Widget _formName() {
    return Form(
      key: _formNameKey,
      child: TextFormField(
        onEditingComplete: () => nextEdit(),
        validator: (val) {
          if (val?.length == 0) {
            return '이름은 필수사항입니다.';
          }
          return null;
        },
        controller: Namecontroller,
        obscureText: isObscure ? true : false,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(top: 20, left: 20),
            hintText: '홍길동',
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
      ),
    );
  }

  Widget formYear() {
    return Form(
      key: _formyearKey,
      child: TextFormField(
        controller: Yearcontroller,
        onEditingComplete: () => nextEdit(),
        validator: (val) {
          if (val?.length != 4) {
            return '4자리를 입력해주세요.';
          }
          return null;
        },
        // obscureText: isObscure ? true : false,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                top: 20, left: 40),
            hintText: '2023',
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
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget formMonth() {
    return Form(
      key: _formmonthKey,
      child: TextFormField(
        controller: Monthcontroller,
        onEditingComplete: () => nextEdit(),
        validator: (val) {
          if (val?.length != 2) {
            return '2자리를 입력해주세요..';
          }
          return null;
        },
        obscureText: isObscure ? true : false,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                top: 20, left: 25),
            hintText: '01',
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
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget formDay() {
    return Form(
      key: _formdatKey,
      child: TextFormField(
        controller: Daycontroller,
        onEditingComplete: () {},
        validator: (val) {
          if (val?.length != 2) {
            return '2자리를 입력해주세요.';
          }
          return null;
        },
        autofocus: true,
        obscureText: isObscure ? true : false,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                top: 20, left: 25),
            hintText: '01',
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
        keyboardType: TextInputType.number,
      ),
    );
  } 
}
