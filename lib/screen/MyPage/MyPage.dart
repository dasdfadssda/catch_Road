import 'package:catch2_0_1/LoginPage.dart';
import 'package:catch2_0_1/main.dart';
import 'package:catch2_0_1/screen/MyPage/MyCash.dart';
import 'package:catch2_0_1/screen/mainHome.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Auth/auth_service .dart';
import '../../utils/app_text_styles.dart';
import '../../utils/widget.dart';
import '../notFound.dart';
import '../projectPage/part_pro.dart';
import 'editMyinfo.dart';
import 'makeAccount.dart';

dynamic userInform;
String UserNickName = '';

class MYPage extends StatefulWidget {
  const MYPage({super.key});

  @override
  State<MYPage> createState() => _MYPageState();
}

class _MYPageState extends State<MYPage> {
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser!.email}")
        .get()
        .then((DocumentSnapshot ds) async {
      userInform = await ds.data();

      print(userInform['name']);
      print(userInform['birth'].toString().substring(0, 4));

      setState(() {
        birthyear = userInform['birth'].toString().substring(0, 4);
        birthmonth = userInform['birth'].toString().substring(6, 7);
        birthday = userInform['birth'].toString().substring(9, 10);
        UserNickName = userInform['NickName']!;
      });
    });
  }

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
                                child: Image.asset('assets/img.png',
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
                                        '${UserNickName}',
                                        //FirebaseAuth.instance.currentUser!.displayName!
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
                                '${FirebaseAuth.instance.currentUser!.email!}',
                                //FirebaseAuth.instance.currentUser!.email!
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
                            //set border radius more than 50% of height and width to make circle
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
            //_buildListTileButton('내가 올린 프로젝트', 'myUpLoadProject'), // 1.10일 mypage 회원 탈퇴 부분 밑으로 쭉
            //_buildListTileButton('내가 작성한 커뮤니티 글', 'myCommunity'),
            _buildListTileButton('참여한 프로젝트', 'myJoinProject'),
            MyWidget().DivderLine(),
            //_buildListTileButton('결제 정보 수정', 'myPayInformation'),
            _buildListTileButton('계좌 정보 수정', 'myBankInformation'),
            // MyWidget().DivderLine(),
            //_buildListTileButton('공지 사항', 'announcement'),
            //_buildListTileButton('약관 및 개인정보 처리', 'myInformation'),
            MyWidget().DivderLine(),
            _buildListTileButton('로그아웃', 'logout'),
            // 1.10일 mypage 회원 탈퇴 부분 여기까지
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.015, bottom: size.height * 0.05),
              child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(0, 20),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.topLeft),
                  onPressed: () {
                    setState(() {
                      print('탈퇴하기');
                      _showSnapBarForwithdraw(context);
                    });
                  },
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

  ListTile _buildListTileButton(String word, String route) {
    // 1.10일 mypage 회원 탈퇴 부분 밑으로 쭉
    final Size size = MediaQuery.of(context).size;
    return ListTile(
        contentPadding: EdgeInsets.only(left: size.width * 0.014),
        onTap: () {
          print('onTap');
          if (route == 'logout') {
            print('logout');
            _showSnapBarForLogOut(context);
          } else if (route == 'myJoinProject') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => partiprojectPage()),
            );
          } else if (route == 'myBankInformation') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => makeAccount()),
            );
          }
        },
        leading: Text('${word}', style: labelLargeStyle(color: Colors.black)),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xffCFD2D9),
        ));
  }

  void _showSnapBarForLogOut(context) {
    // 나가기 관련 스냅바
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return Container(
              height: 150,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 40, 14, 17),
                  child: Text(
                    "로그아웃 하시겠습니까?",
                    style: labelLargeStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(39, 0, 39, 0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소',
                            style: labelMediumStyle(color: Color(0XFF9FA5B2))),
                      ),
                      SizedBox(width: 150),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                          await signOut();
                          user_object=[];
                          print('초기화$user_object');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text('확인',
                            style: labelMediumStyle(color: Color(0XFF3A94EE))),
                      ),
                    ],
                  ),
                )
              ]),
            );
          });
        });
  }

  void _showSnapBarForwithdraw(context) {
    // 나가기 관련 스냅바
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return Container(
              height: 310,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 30, 14, 20),
                  child: Text(
                    "정말 탈퇴하시겠습니까?",
                    style: titleLargeStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                  child: Text(
                    "${FirebaseAuth.instance.currentUser!.email!}님, 탈퇴시 삭제/유지되는 정보를 확인해주세요!\n한 번 삭제된 정보는 복구가 불가능합니다.",
                    //FirebaseAuth.instance.currentUser!.displayName!
                    style: labelLargeStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  height: 95,
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0XFF3A94EE),
                      width: 1,
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                  padding: EdgeInsets.fromLTRB(9, 10, 10, 5),
                  child: Text(
                    "계정을 삭제하면 회원님의 모든 콘텐츠와 활동 기록, 포인트 적립·사용 내역이 삭제됩니다. 프로젝트 참여를 통해 적립한 포인트는 계정 삭제 시 환불이 불가합니다. 또한 삭제된 정보는 복구할 수 없으니 신중하게 결정해주세요.\n\n회원님이 참여한 프로젝트 데이터셋과 커뮤니티 관련 컨텐츠와 댓글은 정보가 유지됩니다.",
                    style: labelMediumStyle(color: Color(0XFF3A94EE)),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('취소',
                            style: labelMediumStyle(color: Color(0XFF9FA5B2))),
                      ),
                      SizedBox(width: 200),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                          // deleteUserFromFirebase();
                        },
                        child: Text('탈퇴하기',
                            style: labelMediumStyle(color: Color(0XFF3A94EE))),
                      ),
                    ],
                  ),
                )
              ]),
            );
          });
        });
  }
}
