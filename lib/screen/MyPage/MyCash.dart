import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../../utils/widget.dart';
import 'cashCahnge.dart';
import 'makeAccount.dart';

int total_cash = 0;
bool cash_calc = false;
bool no_account=false;
var f = NumberFormat('###,###,###,###');
var account_inform;

String bank_num = '1111';
String bank = '은행';
String bank_userName = '';


// print(f.format(1000000);
// # ==> 1,000,000

class MyCash extends StatefulWidget {
  const MyCash({super.key});

  @override
  State<MyCash> createState() => _MyCashState();
}

class _MyCashState extends State<MyCash> {
  Stream<QuerySnapshot> stream_ordering() {
    return FirebaseFirestore.instance
        .collection('user_cash')
        .doc("${FirebaseAuth.instance.currentUser!.email!}")
        .collection("${FirebaseAuth.instance.currentUser!.email!}")
        .orderBy('time', descending: true) //최신순 정렬
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser!.email}")
        .get()
        .then((DocumentSnapshot ds) async {
      account_inform = await ds.data();
      bank_num = account_inform['Bank - Num'];
      bank = account_inform['Bank'];
      bank_userName = account_inform['예금주'];
      print(bank);
    });

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.08,
          child: FloatingActionButton.extended(
            onPressed: () async {
              // 계좌정보가 없는 경우
              print("계좌 : $bank_num");

              if(bank_num==''||bank==''||bank_userName==''){
                print("계좌정보 없음");
                no_account=true;
                print(no_account);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      insetPadding: EdgeInsets.only(top: size.height * 0.65),
                      content: Container(
                          height: size.height * 0.3,
                          width: size.width,
                          child: Column(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Text(
                                      "계좌정보가 등록되어 있지 않습니다.",
                                      style: bodyLargeStyle(color: Colors.black),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    Center(
                                      child: Text("등록하시겠습니까?",
                                          style:
                                              bodyLargeStyle(color: Colors.black)),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.06,
                                          right: size.width * 0.03),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            TextButton(
                                                child: Text(
                                                  '취소',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(0xff9FA5B2)),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(50, 30),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    alignment:
                                                        Alignment.centerLeft)),
                                            Spacer(),
                                            TextButton(
                                                child: Text(
                                                  '확인',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 16,
                                                      color: Color(0xff3A94EE)),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                        pageBuilder: (_, __, ___) =>
                                                            makeAccount(),
                                                        transitionDuration:
                                                            Duration(seconds: 0),
                                                        transitionsBuilder:
                                                            (_, a, __, c) =>
                                                                FadeTransition(
                                                                    opacity: a,
                                                                    child: c)),
                                                  );
                                                },
                                                style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(50, 30),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    alignment:
                                                        Alignment.centerLeft)),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                );



              }
              else{
                lack_error_test='';
                format_error='';
                zero_error='';
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => cashChange(),
                      transitionDuration: Duration(seconds: 0),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c)),
                );

              }





              //계좌정보가 있는 경우2


            },
            backgroundColor: Color(0xff3A94EE),
            label:
            Text("캐시 현금화 하기", style: titleMediumStyle(color: Colors.white)),
          ),
        ),
        backgroundColor: Color(0xff3A94EE),
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.white,
          title: Text(
            "나의 캐시",
            style: titleMediumStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.04,
                            left: size.width * 0.08,
                            bottom: size.height * 0.01),
                        child: Column(
                          children: [
                            Text("나의 캐시",
                                style: titleMediumStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.08),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: stream_ordering(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  int total_cash2 = 0;
                                  for (int i = 0; i <
                                      snapshot.data!.docs.length; i++) {
                                    QueryDocumentSnapshot x = snapshot.data!
                                        .docs[i];
                                    int cash = x['cash'] * x['image length'];
                                    total_cash2 = total_cash2 + cash;
                                  }
                                  return Text("${f.format(total_cash2)}",
                                      style: displaySmallStyle(
                                          color: Colors.white)
                                  );
                                } else {
                                  return Container(
                                  );
                                }
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.03, right: size.width * 0.05),
                    child: Image.asset(
                      'assets/icons/mypage/MYcoin.png',
                      width: 120,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),


              SizedBox(
                height: size.height * 0.70,
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0))),
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.01),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: stream_ordering(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != null) {
                                    total_cash = 0;
                                    return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.docs.length,
                                        itemBuilder: (BuildContext ctx,
                                            int idx) {
                                          QueryDocumentSnapshot x = snapshot
                                              .data!.docs[idx];
                                          String title = x['project_title'];
                                          DateTime date = x['time'].toDate();
                                          int cash = x['cash'] *
                                              x['image length'];
                                          total_cash = total_cash + cash;
                                          String time = "${date.year}년 ${date
                                              .month}월 ${date.day}일";

                                          if (x['image length'] == -1) {
                                            return _subListTile(
                                                title, time, cash * -1);
                                          } else {
                                            return _addListTile(
                                                title, time, cash);
                                          }
                                        }
                                    );
                                  } else {
                                    return Container(
                                        child: Center(
                                            child: Text(
                                              'Es wurden noch keine Fotos im Chat gepostet.',
                                              style:
                                              TextStyle(fontSize: 20.0,
                                                  color: Colors.grey),
                                              textAlign: TextAlign.center,
                                            )));
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),

                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

        )

    );
  }

  Column _addListTile(String title, String subtitle, int cash) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Text(
                      title,
                      style: labelLargeStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: Text(
                      subtitle,
                      style: labelMediumStyle(color: Color(0xff9FA5B2)),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text("+ ", style: titleMediumStyle(color: Color(0xff00D796))),
              Image.asset(
                'assets/icons/mypage/mycash_add_coin.png',
                width: 20,
              ),
              Text(
                cash.toString(),
                style: titleMediumStyle(color: Color(0xff00D796)),
              )
            ],
          ),
        ),
        MyWidget().DivderLineMyCash(),
      ],
    );
  }

  Column _subListTile(String title, String subtitle, int cash) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Text(
                      title,
                      style: labelLargeStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: Text(
                      subtitle,
                      style: labelMediumStyle(color: Color(0xff9FA5B2)),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text("- ", style: titleMediumStyle(color: Colors.red)),
              Image.asset(
                'assets/icons/mypage/Mycash_minus_coin.png',
                width: 20,
              ),
              Text(
                cash.toString(),
                style: titleMediumStyle(color: Colors.red),
              )
            ],
          ),
        ),
        MyWidget().DivderLineMyCash(),
      ],
    );
  }
}
