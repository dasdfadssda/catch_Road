import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Auth/auth_service .dart';
import '../../Auth/user_information.dart' as user;
import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';
import '../../LoginPage.dart';
import 'MyPage.dart';

//2/10
String birthyear='2000';
String birthmonth='01';
String birthday='01';
String name='김캐쳐';

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
        leading: Container(),
        centerTitle: true,
        title: Text(
          "내 정보",
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
                _dataStyle(userInform['name']),
                _smalltitle('닉네임'),
                _dataStyle(userInform['NickName']),
                if(loginplatform!="google")
                _smalltitle('생년월일'),
                if(loginplatform!="google")
                _dataStyle('${birthyear}년 ${birthmonth}월 ${birthday}일'),
                //_smalltitle('전화번호'),
                //_dataStyle('010-0000-0000'),
                Padding(
                    padding:
                    EdgeInsets.only(
                        top: size.height * 0.03, right: size.width * 0.08),
                    child: Divider(thickness: 1)),
                _smalltitle('아이디'),
                _dataStyle("${FirebaseAuth.instance.currentUser!.email!}"),
                Padding(
                  padding: const EdgeInsets.all(0.0),

                  child: TextButton(
                    style: TextButton.styleFrom(
                       padding: EdgeInsets.all(0),
                    ),


                      onPressed:(){
                    resetPassword(FirebaseAuth.instance.currentUser!.email!.toString());
                  }
                      , child: Text('비밀번호 재설정')),
                ),
           //      TextButton(onPressed: ()async{
           // //   FirebaseAuth.instance.currentUser?.emailVerified=true;
           //      }, child: Text('이메일 인증'))

                // Padding(
                //   padding: EdgeInsets.only(
                //       top: size.height * 0.02, right: size.width * 0.01),
                //   child: _listTiles('비밀번호 변경'),
                // )
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
  final _formKey = GlobalKey<FormState>();

  String present_pwd = '';
  String new_pwd = '';
  String new_pwd_check = '';
  String doc_id = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Form(
      key : _formKey,
      child: Scaffold(
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
                    onSaved: (value) {
                      setState(() {
                        present_pwd = value!;
                      });
                    },
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
                    onSaved: (value) {
                      setState(() {
                        new_pwd = value!;
                      });
                    },
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
                    onSaved: (value) {
                      setState(() {
                        new_pwd_check = value!;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: size.height * 0.05),
                  //_buttonlay('변경하기')
                ],
              ),
            )),
      ),
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

  // SizedBox _buttonlay(String buttonName) {
  //   return SizedBox(
  //       width: double.infinity,
  //       height: 40,
  //       child: OutlinedButton(
  //           style: OutlinedButton.styleFrom(
  //               backgroundColor: Color(0xff3A94EE),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(30)))),
  //           onPressed: () async {
  //             if(_formKey.currentState!.validate()){
  //               _formKey.currentState!.save();
  //             }
  //             await FirebaseFirestore.instance.collection("user").where("id", isEqualTo: id).snapshots().listen((data){
  //               setState(() {
  //                 doc_id = data.docs[0].id;
  //               });
  //               FirebaseFirestore.instance.collection("user").doc(doc_id).update({
  //                 "pwd" : new_pwd
  //               });
  //             });
  //             showModalBottomSheet(
  //                 context: context,
  //                 shape: const RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.vertical(
  //                     top: Radius.circular(30),
  //                   ),
  //                 ),
  //                 builder: (BuildContext context) {
  //                   return StatefulBuilder(builder:
  //                       (BuildContext context, StateSetter bottomState) {
  //                     return Container(
  //                       height: 380,
  //                       child: Column(children: [
  //                         Container(
  //                           margin: EdgeInsets.fromLTRB(100, 40, 100, 20),
  //                           child: Image.asset(
  //                             'assets/checkToFinish.gif',
  //                             height: 160,
  //                             width: 160,
  //                           ),
  //                         ),
  //                         Container(
  //                           margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
  //                           child: Text(
  //                             "비밀번호가 변경되었습니다",
  //                             style: TextStyle(
  //                               fontFamily: 'NotoSansKR',
  //                               fontWeight: FontWeight.w400,
  //                               fontSize: 14,
  //                               height: 26 / 16,
  //                               letterSpacing: 0.5,
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                             height: 40,
  //                             width: 312,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(20),
  //                                 color: Color(0XFF3A94EE)),
  //                             margin: EdgeInsets.fromLTRB(46, 0, 46, 50),
  //                             child: TextButton(
  //                                 onPressed: (){
  //                                   print("here!");
  //                                   Navigator.push(
  //                                     context,
  //                                     PageRouteBuilder(
  //                                         pageBuilder: (_, __, ___) =>
  //                                             editinfo(),
  //                                         transitionDuration:
  //                                         Duration(seconds: 0),
  //                                         transitionsBuilder: (_, a, __, c) =>
  //                                             FadeTransition(
  //                                                 opacity: a, child: c)),
  //                                   );
  //                                 },
  //                                 child: Text('확인',
  //                                     style: titleMediumStyle(
  //                                         color: Colors.white))))
  //                       ]),
  //                     );
  //                   });
  //                 });
  //
  //           },
  //           child: Text(
  //             buttonName,
  //             style: titleMediumStyle(color: Colors.white),
  //           )));
  // }
}