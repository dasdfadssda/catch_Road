import 'package:catch2_0_1/screen/MyPage/MyCash.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';
import '../../utils/widget.dart';
import '../notFound.dart';
import 'editMyinfo.dart';

class MYPage extends StatefulWidget {
  const MYPage({super.key});

  @override
  State<MYPage> createState() => _MYPageState();
}

class _MYPageState extends State<MYPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        leading: SizedBox(),
        backgroundColor: Color(0xffFAFBFB),
        title: Text(
          '마이 페이지',
          style: titleMediumStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.06, right: size.width * 0.06),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Center(
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(100), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(35), // Image radius
                                child: Image.asset('assets/icons/apple.png',
                                    fit: BoxFit.cover),
                              )),
                        ),
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.04),
                                  child: Row(
                                    children: [
                                      Text(
                                        '1234@handong.ac.kr',
                                        style: titleMediumStyle(
                                            color: Colors.black),
                                      ),
                                      Text(" 님",
                                          style: labelMediumStyle(
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.035,
                                  left: size.width * 0.04),
                              child: Text(
                                '1234@handong.ac.kr',
                                style:
                                    labelSmallStyle(color: Color(0xff9FA5B2)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.55),
                              child: IconButton(
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
                                  icon: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xffCFD2D9),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) => MyCash(),
                                          transitionDuration:
                                              Duration(seconds: 0),
                                          transitionsBuilder: (_, a, __, c) =>
                                              FadeTransition(
                                                  opacity: a, child: c)),
                                    );
                                  },
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.005),
                                    child: Text(
                                      "나의 캐시",
                                      style:
                                          labelSmallStyle(color: Colors.white),
                                    ),
                                  ),
                                  subtitle: Text("10,000",
                                      style:
                                          titleLargeStyle(color: Colors.white)),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(0))),
                                  tileColor: Color(0xff3A94EE),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                child: ListTile(
                                  onTap: () {},
                                  title: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.015),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        Text("캐시 현금화 하기  ",
                                            style: labelSmallStyle(
                                                color: Colors.black)),
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  tileColor: Color(0xffE7E8EC),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: size.height * 0.0, left: size.width * 0.57),
                          child: Image.asset(
                            'assets/icons/mypage/MYcoin.png',
                            width: 100,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: size.height * 0.005),
            _buildListTileButton('내가 올린 프로젝트'),
            _buildListTileButton('내가 작성한 커뮤니티 글'),
            _buildListTileButton('참여한 프로젝트'),
            MyWidget().DivderLine(),
            _buildListTileButton('결제 정보 수정'),
            _buildListTileButton('계좌 정보 수정'),
            MyWidget().DivderLine(),
            _buildListTileButton('공지 사항'),
            _buildListTileButton('약관 및 개인정보 처리'),
            MyWidget().DivderLine(),
            _buildListTileButton('로그아웃'),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.015, bottom: size.height * 0.05),
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 20),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.topLeft),
                  onPressed: () {},
                  child: Text(
                    "탈퇴하기",
                    style: bodySmallStyle(color: Color(0xff9FA5B2)),
                  )),
            )
          ]),
        ),
      ),
    );
  }

  Container _buildButtonColumn(String image, String label, Color color) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 25, 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => notFound(),
              ));
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('${image}', height: 40, width: 40),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTileButton(String word) {
    final Size size = MediaQuery.of(context).size;
    return ListTile(
        contentPadding: EdgeInsets.only(left: size.width * 0.014),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => notFound(),
              ));
        },
        leading: Text('${word}', style: labelLargeStyle(color: Colors.black)),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xffCFD2D9),
        ));
  }
}
