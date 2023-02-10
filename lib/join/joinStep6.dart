import 'package:catch2_0_1/Auth/user_information.dart';
import 'package:catch2_0_1/LoginPage.dart';
import 'package:catch2_0_1/join/emailVerify.dart';
import 'package:catch2_0_1/join/joinPage7.dart';
import 'package:flutter/material.dart';
import '../Auth/auth_service .dart';
import '../utils/app_text_styles.dart';
import 'joinStep3.dart';



String _bankName = '';
String _bankNum = '';
String _nameForBank = '';

class bankInformationCode extends ChangeNotifier {
  String bankName = _bankName;
  String bankNum = _bankNum;
  String nameForBank = _nameForBank;
  notifyListeners();
}
class joinStep6 extends StatefulWidget {
  const joinStep6({super.key});

  @override
  State<joinStep6> createState() => _joinStep6State();
}


class _joinStep6State extends State<joinStep6> {

  final BankNamecontroller = TextEditingController();
  final BankNumcontroller = TextEditingController();
  final nameforBankcontroller = TextEditingController();


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
              Image.asset('assets/step6.png', width: size.width * 0.87),
              SizedBox(width: 12),
              Text("6/7", style: labelMediumStyle(color: Color(0xff9FA5B2)))
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
                      Text("은행",
                          style: titleSmallStyle(color: Color(0xff9FA5B2))),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                    child: _formBank()
                  ),
                  Row(
                    children: [
                      Text("계좌번호",
                          style: titleSmallStyle(color: Color(0xff9FA5B2))),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                    child: _formBankNum()
                  ),
                  Row(
                    children: [
                      Text("예금주명",
                          style: titleSmallStyle(color: Color(0xff9FA5B2))),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    height: size.height * 0.08,
                    child: _formNameForBank()
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

                    Navigator.push(context,
                      MaterialPageRoute(builder: (context){
                        return joinPage7();

                      })
                    );

                    _bankName = BankNamecontroller.text;
                    _bankNum = BankNumcontroller.text;
                    _nameForBank = nameforBankcontroller.text;

                    userInformUpdate();











                  },
                  child: Text(
                    "다음",
                    style: titleMediumStyle(color: Colors.white),
                  )))
        ],
      ),
    );
  }

  Widget _formBank() {
    return Form(
      child: TextField(
        onTap: () {},
        controller: BankNamecontroller,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                 left: 20),
            hintText: 'EX) 포항은행',
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
        showCursor: false,
      ),
    );
  }

  Widget _formBankNum() {
    return Form(
      child: TextField(
        style: TextStyle(fontSize: 13),
        controller: BankNumcontroller,
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                 left: 20),
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
        keyboardType: TextInputType.number,
      ),
    );
  }
  
  Widget _formNameForBank() {
    return Form(
      child: TextField(
        controller: nameforBankcontroller,//BankNamecontroller,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(
                left: 20),
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
        keyboardType: TextInputType.text,
      ),
    );
  }
}
