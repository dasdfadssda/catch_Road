import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../utils/widget.dart';
import 'cashCahnge.dart';
import 'makeAccount.dart';

class MyCash extends StatefulWidget {
  const MyCash({super.key});

  @override
  State<MyCash> createState() => _MyCashState();
}

class _MyCashState extends State<MyCash> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.08,
        child: FloatingActionButton.extended(
          onPressed: () {
            // 계좌정보가 없는 경우
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

            // 계좌정보가 있는 경우
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //       pageBuilder: (_, __, ___) => cashChange(),
            //       transitionDuration: Duration(seconds: 0),
            //       transitionsBuilder: (_, a, __, c) =>
            //           FadeTransition(opacity: a, child: c)),
            // );
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
      body: Column(
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
                    child: Text(
                      "10,000",
                      style: displaySmallStyle(color: Colors.white),
                    ),
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
            height: size.height * 0.670,
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
                      _addListTile("자전거 사진 구합니다", "2022년 11월 31일", 300),
                      MyWidget().DivderLineMyCash(),
                      _subListTile('캐시 현금화', '2022년 11월 31일', 300),
                      MyWidget().DivderLineMyCash(),
                      _subListTile('캐시 현금화', '2022년 11월 31일', 300),
                      MyWidget().DivderLineMyCash(),
                      _addListTile("자전거 사진 구합니다", "2022년 11월 31일", 300),
                      MyWidget().DivderLineMyCash(),
                      _subListTile('캐시 현금화', '2022년 11월 31일', 300),
                      MyWidget().DivderLineMyCash(),
                      _subListTile('캐시 현금화', '2022년 11월 31일', 300),
                      MyWidget().DivderLineMyCash(),
                      _addListTile("자전거 사진 구합니다", "2022년 11월 31일", 300),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ListTile _addListTile(String title, String subtitle, int cash) {
    final Size size = MediaQuery.of(context).size;
    return ListTile(
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
    );
  }

  ListTile _subListTile(String title, String subtitle, int cash) {
    final Size size = MediaQuery.of(context).size;
    return ListTile(
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
    );
  }
}
