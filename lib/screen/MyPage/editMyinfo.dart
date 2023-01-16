import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';
import 'MyPage.dart';

class editinfo extends StatefulWidget {
  const editinfo({super.key});

  @override
  State<editinfo> createState() => _editinfoState();
}

class _editinfoState extends State<editinfo> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => MYPage(),
                  transitionDuration: Duration(seconds: 0),
                  transitionsBuilder: (_, a, __, c) =>
                      FadeTransition(opacity: a, child: c)),
            );
          },
          iconSize: 22,
          color: Color(0xffCFD2D9),
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text(
          "내 정보 수정",
          style: titleMediumStyle(),
        ),
        backgroundColor: Colors.white,
        elevation: 0.2,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _smalltitle('이름'),
            _dataStyle('김캐처'),
            _smalltitle('생년월일'),
            _dataStyle('2000년 1월 1일'),
            _smalltitle('전화번호'),
            _dataStyle('010-0000-0000'),
            Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.09, right: size.width * 0.08),
                child: Divider(thickness: 1)),
            _smalltitle('아이디'),
            _dataStyle('turnyourpoint@gmail.com'),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.02, right: size.width * 0.01),
              child: _listTiles('비밀번호 변경'),
            )
          ],
        ),
      )),
    );
  }

  Padding _smalltitle(String title) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(top: size.height * 0.04, bottom: size.height * 0.006),
      child: Text(title,
          style: TextStyle(
              fontFamily: 'NotoSansKR',
              fontWeight: FontWeight.w700,
              fontSize: 10,
              color: Color(0xff9FA5B2))),
    );
  }

  Text _dataStyle(String datas) {
    return Text(
      datas,
      style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black),
    );
  }

  ListTile _listTiles(String word) {
    final Size size = MediaQuery.of(context).size;
    return ListTile(
        hoverColor: Colors.transparent,
        contentPadding: EdgeInsets.only(right: size.width * 0.08),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => changePwd(),
              ));
        },
        leading: Text('${word}', style: labelLargeStyle(color: Colors.black)),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xffCFD2D9),
        ));
  }
}

class changePwd extends StatefulWidget {
  const changePwd({super.key});

  @override
  State<changePwd> createState() => _changePwdState();
}

class _changePwdState extends State<changePwd> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            "비밀번호 변경",
            style: titleMediumStyle(),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding:
            EdgeInsets.only(left: size.width * 0.08, right: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.05),
            _textfieldLabel('현재 비밀번호'),
            TextFormField(
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 6, minWidth: 16),
                  focusColor: Color.fromARGB(6, 61, 50, 50),
                  contentPadding: EdgeInsets.only(top: 8, left: 24),
                  hintText: '',
                  errorText: '',
                  errorStyle: labelSmallStyle(color: Colors.red),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                    borderSide: BorderSide(
                        width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                  ),
                  errorBorder: OutlineInputBorder(
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
            _textfieldLabel('새 비밀번호'),
            TextFormField(
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 6, minWidth: 16),
                  focusColor: Color.fromARGB(6, 61, 50, 50),
                  contentPadding: EdgeInsets.only(top: 8, left: 24),
                  hintText: '',
                  errorText: '',
                  errorStyle: labelSmallStyle(color: Colors.red),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                    borderSide: BorderSide(
                        width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                  ),
                  errorBorder: OutlineInputBorder(
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
            _textfieldLabel('새 비밀번호 확인'),
            TextFormField(
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 6, minWidth: 16),
                  focusColor: Color.fromARGB(6, 61, 50, 50),
                  contentPadding: EdgeInsets.only(top: 8, left: 24),
                  hintText: '',
                  errorText: '',
                  errorStyle: labelSmallStyle(color: Colors.red),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(36.0)),
                    borderSide: BorderSide(
                        width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                  ),
                  errorBorder: OutlineInputBorder(
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
            SizedBox(height: size.height * 0.05),
            _buttonlay('변경하기')
          ],
        ),
      )),
    );
  }

  Padding _textfieldLabel(String labels) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(top: size.height * 0.005, bottom: size.height * 0.01),
      child: Text(
        labels,
        style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w700,
            fontSize: 11,
            color: Color(0xff9FA5B2)),
      ),
    );
  }

  SizedBox _buttonlay(String buttonName) {
    return SizedBox(
        width: double.infinity,
        height: 40,
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xff3A94EE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder:
                        (BuildContext context, StateSetter bottomState) {
                      return Container(
                        height: 380,
                        child: Column(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(100, 40, 100, 20),
                            child: Image.asset(
                              'assets/checkToFinish.gif',
                              height: 160,
                              width: 160,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                            child: Text(
                              "비밀번호가 변경되었습니다",
                              style: TextStyle(
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 26 / 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Container(
                              height: 40,
                              width: 312,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0XFF3A94EE)),
                              margin: EdgeInsets.fromLTRB(46, 0, 46, 50),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              editinfo(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                          transitionsBuilder: (_, a, __, c) =>
                                              FadeTransition(
                                                  opacity: a, child: c)),
                                    );
                                  },
                                  child: Text('확인',
                                      style: titleMediumStyle(
                                          color: Colors.white))))
                        ]),
                      );
                    });
                  });
            },
            child: Text(
              buttonName,
              style: titleMediumStyle(color: Colors.white),
            )));
  }
}
