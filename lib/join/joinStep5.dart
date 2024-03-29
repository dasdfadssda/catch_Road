import 'package:catch2_0_1/Auth/user_information.dart';
import 'package:catch2_0_1/join/joinStep6.dart';
import 'package:flutter/material.dart';
import '../utils/app_text_styles.dart';
//2/10

String _PhoneNum = '';
class phoneNumCode extends ChangeNotifier {
  String phoneNum= _PhoneNum;
  notifyListeners();
}
class joinStep5 extends StatefulWidget {
  const joinStep5({super.key});

  @override
  State<joinStep5> createState() => _joinStep5State();
}

class _joinStep5State extends State<joinStep5> {
  final PhoneNumcontroller = TextEditingController();
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
              Image.asset('assets/step5.png', width: size.width * 0.87),
              SizedBox(width: 12),
              Text("5/7", style: labelMediumStyle(color: Color(0xff9FA5B2)))
            ],
          ),
          SizedBox(height: size.height * 0.07),
          Text("추가 정보 입력", style: titleLargeStyle(color: Color(0xff3174CD))),
          SizedBox(height: size.height * 0.02),
          Text("필수 정보는 아니며,\n마이페이지에서 추가하실 수 있습니다.",
              textAlign: TextAlign.center,
              style: labelMediumStyle(color: Color(0xff9FA5B2))),
          Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.07,
                  left: size.width * 0.06,
                  right: size.width * 0.06),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("전화번호",
                          style: titleSmallStyle(color: Color(0xff9FA5B2))),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                    child: _formPhone()
                  ),
                ],
              )),
          SizedBox(height: size.height * 0.1),
          SizedBox(
              width: size.width * 0.85,
              height: size.height * 0.08,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xff3A94EE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  onPressed: () {
                    if (_formKey3.currentState!.validate()) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => joinStep6(),
                            transitionDuration: Duration(seconds: 0),
                            transitionsBuilder: (_, a, __, c) =>
                                FadeTransition(opacity: a, child: c)),
                      );
                    }




                   _PhoneNum = PhoneNumcontroller.text;
                   print('전화번호 : ${phoneNumCode().phoneNum}');
                  },
                  child: Text(
                    "다음",
                    style: titleMediumStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }

  final _formKey3 = GlobalKey<FormState>();

  Widget _formPhone() {
    return Form(
      key:_formKey3,
      child: TextFormField(
        validator: (val) {
          if (val!.length != 11) {
            return '11자리로 입력해주세요';
          }
          return null;
        },

        keyboardType: TextInputType.phone,
        controller: PhoneNumcontroller,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                 left: 30),
            hintText: '01012345678',
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
}
