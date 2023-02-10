import 'package:catch2_0_1/screen/MyPage/MyPage.dart';
import 'package:catch2_0_1/screen/mainHome.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//2/10
import 'MyCash.dart';

String lack_error_test = '';
String format_error = '';
String zero_error = '';

String cc_bankName = '';
String cc_bankNum = '';
String cc_nameForBank = '';
var cc_userInform;

final cashcontroller = TextEditingController();

class cashChange extends StatefulWidget {
  const cashChange({super.key});

  @override
  State<cashChange> createState() => _cashChangeState();
}

class _cashChangeState extends State<cashChange> {
  void initState() {
    FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser!.email}")
        .get()
        .then((DocumentSnapshot ds) async {
      cc_userInform = await ds.data();
      setState(() {
        cc_bankName = cc_userInform['Bank'];
        cc_bankNum = cc_userInform['Bank - Num'];
        cc_nameForBank = cc_userInform['예금주명'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    no_account = false;

    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            "캐시 현금화",
            style: titleMediumStyle(color: Colors.black),
          )),
      body: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "보유 캐시",
                style: titleSmallStyle(color: Color(0xff9FA5B2)),
              ),
              Text(
                "${f.format(total_cash)}",
                style: bodyLargeStyle(color: Colors.black),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                '현금화 할 캐시',
                style: titleSmallStyle(color: Color(0xff9FA5B2)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.01, right: size.width * 0.06),
                child: TextFormField(
                  controller: cashcontroller,
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 6, minWidth: 16),
                      focusColor: Color.fromARGB(6, 61, 50, 50),
                      contentPadding: EdgeInsets.only(
                          top: size.height * 0.01, left: size.width * 0.04),
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
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  // Image.asset(
                  //   'assets/icons/mypage/cash_warn.png',
                  //   width: 16,
                  // ),
                  Text(
                    lack_error_test,
                    style: labelMediumStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  // Image.asset(
                  //   'assets/icons/mypage/cash_warn.png',
                  //   width: 16,
                  // ),
                  Text(
                    format_error,
                    style: labelMediumStyle(color: Colors.red),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  // Image.asset(
                  //   'assets/icons/mypage/cash_warn.png',
                  //   width: 16,
                  // ),
                  Text(
                    zero_error,
                    style: labelMediumStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: OutlinedButton(
                    child: Text(
                      "현금화 하기",
                      style: titleMediumStyle(color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff3A94EE),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    onPressed: () async {
                      if (int.parse(cashcontroller.text) % 1000 == 0 &&
                          int.parse(cashcontroller.text) < total_cash &&
                          cashcontroller.text != "0") {
                        await FirebaseFirestore.instance
                            .collection("user_change_cash_request")
                            .doc(Timestamp.fromDate(DateTime.now()).toString())
                            .set({
                          "user_email":
                              FirebaseAuth.instance.currentUser!.email!,
                          "은행명": cc_bankName,
                          "계좌번호": cc_bankNum,
                          "예금주명": cc_nameForBank,
                          "캐시": int.parse(cashcontroller.text),
                        });
                        //입금이 자동으로 될경우만 사용 가능한 코드임
                        await FirebaseFirestore.instance
                            .collection("user_cash")
                            .doc("${FirebaseAuth.instance.currentUser!.email!}")
                            .collection(
                                "${FirebaseAuth.instance.currentUser!.email!}")
                            .doc(Timestamp.fromDate(DateTime.now()).toString())
                            .set({
                          "project_title": "캐시현금화",
                          "image length": -1,
                          "cash": int.parse(cashcontroller.text),
                          "time": Timestamp.fromDate(DateTime.now()),
                        });

                        cashcontroller.clear();
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
                                height: size.height * 0.575,
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    SizedBox(
                                        height: 150,
                                        child: Image.asset(
                                            'assets/checkToFinish.gif')),
                                    SizedBox(
                                      height: size.height * 0.025,
                                    ),
                                    Text(
                                        '캐시가 현금화 되었습니다.\n\n현금화는 영업일 기준으로\n최대 7일까지 소요될 수 있습니다',
                                        textAlign: TextAlign.center,
                                        style: bodyLargeStyle(
                                            color: Colors.black)),
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        MainHomePage(),
                                              ));
                                        })
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      }

                      if (cashcontroller.text == "0") {
                        print("0원이다!");
                        setState(() {
                          zero_error = "0원입니다";
                        });
                      } else {
                        zero_error = "";
                      }

                      if (int.parse(cashcontroller.text) % 1000 != 0) {
                        setState(() {
                          format_error = "캐시 현금화는 1,000 캐시 단위로 가능합니다.";
                        });
                      } else {
                        format_error = '';
                      }
                      if (int.parse(cashcontroller.text) < total_cash) {
                        setState(() {
                          lack_error_test = "";
                        });
                      }

                      if (int.parse(cashcontroller.text) > total_cash) {
                        setState(() {
                          lack_error_test = "현금화 가능한 캐시가 부족합니다.";
                        });
                      }
                    },
                  ))
            ]),
      ),
    );
  }
}
