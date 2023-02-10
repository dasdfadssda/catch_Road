import 'package:catch2_0_1/main.dart';
import 'package:catch2_0_1/screen/Camera/camera_page.dart';
import 'package:catch2_0_1/screen/projectPage/agree1.dart';
import 'package:catch2_0_1/screen/projectPage/progect_main.dart';
import 'package:catch2_0_1/screen/projectPage/project_detail2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../mainHome.dart';

class todaycatchdetail extends StatefulWidget {
  final QueryDocumentSnapshot query;

  todaycatchdetail({required this.query});

  @override
  State<todaycatchdetail> createState() => _todaycatchdetailState(query: query);
}

class _todaycatchdetailState extends State<todaycatchdetail> {
  final QueryDocumentSnapshot query;

  _todaycatchdetailState({required this.query});

  Color _color = Color(0xFFCFD2D9);
  bool Tap1 = false;
  bool Tap2 = false;
  bool Tap3 = false;
  bool Tap4 = false;

  bool _allTap = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    dynamic userInform2;
    //List objectList = [];

    // FirebaseFirestore.instance
    //     .collection("user")
    //     .doc("${FirebaseAuth.instance.currentUser!.email}")
    //     .get()
    //     .then((DocumentSnapshot ds) async {
    //   userInform2 = await ds.data();
    //   objectList = userInform2['object'];
    //   print(objectList);
    //   c_object_list=objectList;
    //   print("c_object_list${c_object_list}");
    // });

    Tap1 = false;
    Tap2 = false;
    Tap3 = false;
    Tap4 = false;
    _allTap = false;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Center(
              child: Text(
            '오늘의 캐치',
            style: titleMediumStyle(color: Colors.black),
          )),
        ),
        body: ListView(padding: EdgeInsets.fromLTRB(24, 40, 24, 32), children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Text(
                          ddaycalc(query['final_day2']) > 0
                              ? "D- ${ddaycalc(query['final_day2'])}"
                              : ddaycalc(query['final_day2']) == 0
                                  ? "D-day"
                                  : "finished project",
                          style: labelLargeStyle(color: Color(0xff9FA5B2))),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(query['title'],
                      style: titleLargeStyle(color: Color(0xff1A1A1A))),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Container(
                      width: size.width * 0.15,
                      height: size.height * 0.03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffCFD2D9),
                        ),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(query['type'],
                            style: labelMediumStyle(color: Color(0xff9FA5B2))),
                      )),
                  SizedBox(width: size.width * 0.016),
                  Text(query['user'], //query['cash'].toString(),
                      style: labelMediumStyle(color: Color(0xff9FA5B2))),
                  // Text('캐시', style: labelMediumStyle(color: Color(0xff9FA5B2))),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Text(query['content'],
                  style: bodyMediumStyle(color: Color(0xff1A1A1A))),
              SizedBox(height: 30),
              // Container(
              //   height: 70,
              //   child: ListView(
              //       scrollDirection: Axis.horizontal,
              //       children: <Widget>[
              //         for (int i = 0; i < query['url'].length; i++)
              //           Padding(
              //             padding: EdgeInsets.only(right: 10),
              //             //height: 25.h,
              //             child: Container(
              //               height: 70,
              //               width: 70,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.all(Radius.circular(14))
              //               ),
              //               child: Expanded(
              //                 child: Image.network(query['url'][i], fit: BoxFit.fitHeight)
              //               )
              //             ),
              //           ),
              //       ],
              //     ),
              // ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    'assets/coin.png',
                    width: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.01, right: size.width * 0.03),
                    child: Text(
                        //snapshot.data!.docs[index]['cash']
                        //   .toString() +
                        query['cash'].toString(),
                        style: labelLargeStyle(color: Color(0xff1A1A1A))),
                  ),
                  for (int i = 0; i < query['object'].length; i++)
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      //height: 25.h,
                      child: Container(
                          // width: size.width * 0.18,
                          height: size.height * 0.035,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              width: 1,
                              color: Color(0xffCFD2D9),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.02,
                                right: size.width * 0.02),
                            child: Center(
                              child: Text(query['object'][i],
                                  style: labelMediumStyle(
                                      color: Color(0xff1A1A1A))),
                              // Text('기업',
                              //     style: labelMediumStyle(color: Color(0xff9FA5B2))),
                            ),
                          )),
                    ),
                ],
              ),
              SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: query['url'].length / query['size'],
                  //int.parse(query['percentage'].toString()) * 0.01,
                  minHeight: size.height * 0.015,
                  valueColor: AlwaysStoppedAnimation(primary[50]),
                  backgroundColor: primary[0]!.withOpacity(0.05),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  // Text(query['percentage'].toString(),
                  //     style: labelLargeStyle(color: Color(0xff9FA5B2))),
                  // Text('% 달성',
                  //     style: labelLargeStyle(color: Color(0xff9FA5B2))),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '${query['size']}장 중 ${query['url'].length}장이 수집되었어요 !',
                              style: labelSmallStyle(color: Color(0xff1A1A1A)))
                        ]),
                  ),
                ],
              ),
            ],
          )
        ]),
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 62),
          child: FloatingActionButton(
            backgroundColor: primary[40],
            onPressed: () {
              showModalBottomSheet<void>(
                enableDrag: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0))),
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                      height: size.height * 0.85,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.0175,
                          ),
                          Container(
                              height: size.height * 0.16,
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.055,
                                  size.height * 0.02,
                                  size.width * 0.055,
                                  size.height * 0.02),
                              decoration: BoxDecoration(
                                border: Tap1
                                    ? Border.all(
                                        width: 2.0,
                                        color: Color(0xFF3A94EE),
                                      )
                                    : Border.all(
                                        color: Color(0xffCFD2D9),
                                      ),
                                color: Tap1 ? Color(0xFFF2F8FE) : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              width: size.width * 0.9,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.57,
                                              child: Text('이용 약관 동의',
                                                  style: titleSmallStyle(
                                                      color:
                                                          Color(0xff1A1A1A))),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.15,
                                            ),
                                            SizedBox(
                                              width: size.height * 0.025,
                                              child: IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                color: Tap1
                                                    ? Colors.blueAccent
                                                    : Color(0xFFCFD2D9),
                                                onPressed: () {
                                                  setState(() {
                                                    Tap1 = !Tap1;
                                                    print(Tap1);
                                                  });
                                                  if (Tap1 == true &&
                                                      Tap2 == true &&
                                                      Tap3 == true &&
                                                      Tap4 == true)
                                                    _allTap = true;
                                                  else
                                                    _allTap = false;
                                                },
                                                icon: Icon(Icons.check_circle),
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            Tap1 = !Tap1;
                                            print(Tap1);
                                          });
                                          if (Tap1 == true &&
                                              Tap2 == true &&
                                              Tap3 == true &&
                                              Tap4 == true)
                                            _allTap = true;
                                          else
                                            _allTap = false;
                                        },
                                      ),

                                      //SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Text('개인정보 통합 관리 및 조회',
                                              style: SubTitleStyle(
                                                  color: Color(0xff9FA5B2))),
                                          //SizedBox(width: 81.w),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            color: Color(0xFFCFD2D9),
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                return Agree1();
                                              }));

                                            },
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                      //SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text('응답내용',
                                              style: SubTitleStyle(
                                                  color: Color(0xff9FA5B2))),
                                          //SizedBox(width: 174.w),
                                          IconButton(
                                            color: Color(0xFFCFD2D9),
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: size.height * 0.015),
                          Container(
                              height: size.height * 0.16,
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.055,
                                  size.height * 0.02,
                                  size.width * 0.055,
                                  size.height * 0.02),
                              decoration: BoxDecoration(
                                border: Tap2
                                    ? Border.all(
                                        width: 2.0,
                                        color: Color(0xFF3A94EE),
                                      )
                                    : Border.all(
                                        color: Color(0xffCFD2D9),
                                      ),
                                color: Tap2 ? Color(0xFFF2F8FE) : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              width: size.width * 0.9,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.57,
                                                child: Text('개인 정보 수집 및 이용 동의',
                                                    style: titleSmallStyle(
                                                        color:
                                                            Color(0xff1A1A1A))),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                              ),
                                              SizedBox(
                                                width: size.height * 0.025,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  color: Tap2
                                                      ? Colors.blueAccent
                                                      : Color(0xFFCFD2D9),
                                                  onPressed: () {
                                                    setState(() {
                                                      Tap2 = !Tap2;
                                                      print(Tap2);
                                                    });
                                                    if (Tap1 == true &&
                                                        Tap2 == true &&
                                                        Tap3 == true &&
                                                        Tap4 == true)
                                                      _allTap = true;
                                                    else
                                                      _allTap = false;
                                                  },
                                                  icon:
                                                      Icon(Icons.check_circle),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              Tap2 = !Tap2;
                                              print(Tap2);
                                            });
                                            if (Tap1 == true &&
                                                Tap2 == true &&
                                                Tap3 == true &&
                                                Tap4 == true)
                                              _allTap = true;
                                            else
                                              _allTap = false;
                                          }),

                                      //SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Text('개인정보 통합 관리 및 조회',
                                              style: SubTitleStyle(
                                                  color: Color(0xff9FA5B2))),
                                          //SizedBox(width: 81.w),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            color: Color(0xFFCFD2D9),
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                      //SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text('응답내용',
                                              style: SubTitleStyle(
                                                  color: Color(0xff9FA5B2))),
                                          //SizedBox(width: 174.w),
                                          IconButton(
                                            color: Color(0xFFCFD2D9),
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Container(
                              height: size.height * 0.16,
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.055,
                                  size.height * 0.02,
                                  size.width * 0.055,
                                  size.height * 0.02),
                              decoration: BoxDecoration(
                                border: Tap3
                                    ? Border.all(
                                        width: 2.0,
                                        color: Color(0xFF3A94EE),
                                      )
                                    : Border.all(
                                        color: Color(0xffCFD2D9),
                                      ),
                                color: Tap3 ? Color(0xFFF2F8FE) : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              width: size.width * 0.9,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.57,
                                                child: Text('위치 기반 서비스 이용약관 동의',
                                                    style: titleSmallStyle(
                                                        color:
                                                            Color(0xff1A1A1A))),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                              ),
                                              SizedBox(
                                                width: size.height * 0.025,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  color: Tap3
                                                      ? Colors.blueAccent
                                                      : Color(0xFFCFD2D9),
                                                  onPressed: () {
                                                    setState(() {
                                                      Tap3 = !Tap3;
                                                      print(Tap3);
                                                    });
                                                    if (Tap1 == true &&
                                                        Tap2 == true &&
                                                        Tap3 == true &&
                                                        Tap4 == true)
                                                      _allTap = true;
                                                    else
                                                      _allTap = false;
                                                  },
                                                  icon:
                                                      Icon(Icons.check_circle),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              Tap3 = !Tap3;
                                              print(Tap3);
                                            });
                                            if (Tap1 == true &&
                                                Tap2 == true &&
                                                Tap3 == true &&
                                                Tap4 == true)
                                              _allTap = true;
                                            else
                                              _allTap = false;
                                          }),

                                      //SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Text('개인정보 통합 관리 및 조회',
                                              style: SubTitleStyle(
                                                  color: Color(0xff9FA5B2))),
                                          //SizedBox(width: 81.w),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            color: Color(0xFFCFD2D9),
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                      //SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text('응답내용',
                                              style: SubTitleStyle(
                                                  color: Color(0xff9FA5B2))),
                                          //SizedBox(width: 174.w),
                                          IconButton(
                                            color: Color(0xFFCFD2D9),
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: size.height * 0.015),
                          Container(
                              height: size.height * 0.16,
                              padding: EdgeInsets.fromLTRB(
                                  size.width * 0.055,
                                  size.height * 0.02,
                                  size.width * 0.055,
                                  size.height * 0.02),
                              decoration: BoxDecoration(
                                border: Tap4
                                    ? Border.all(
                                  width: 2.0,
                                  color: Color(0xFF3A94EE),
                                )
                                    : Border.all(
                                  color: Color(0xffCFD2D9),
                                ),
                                color:
                                Tap4 ? Color(0xFFF2F8FE) : Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ),
                              width: size.width * 0.9,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: size.width * 0.57,
                                                child: Text('프로모션 정보 수신 동의',
                                                    style: titleSmallStyle(
                                                        color: Color(
                                                            0xff1A1A1A))),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                              ),
                                              SizedBox(
                                                width: size.height * 0.025,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints:
                                                  BoxConstraints(),
                                                  color: Tap4
                                                      ? Colors.blueAccent
                                                      : Color(0xFFCFD2D9),
                                                  onPressed: () {
                                                    setState(() {
                                                      Tap4 = !Tap4;
                                                      print(Tap4);
                                                    });
                                                    if (Tap1 == true &&
                                                        Tap2 == true &&
                                                        Tap3 == true &&
                                                        Tap4 == true)
                                                      _allTap = true;
                                                    else
                                                      _allTap = false;
                                                  },
                                                  icon: Icon(
                                                      Icons.check_circle),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              Tap4 = !Tap4;
                                              print(Tap3);
                                            });
                                            if (Tap1 == true &&
                                                Tap2 == true &&
                                                Tap3 == true &&
                                                Tap4 == true)
                                              _allTap = true;
                                            else
                                              _allTap = false;
                                          }),

                                      //SizedBox(height: 16.h),
                                      Row(
                                        children: [
                                          Text('개인정보 통합 관리 및 조회',
                                              style: SubTitleStyle(
                                                  color:
                                                  Color(0xff9FA5B2))),
                                          //SizedBox(width: 81.w),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            color: Color(0xFFCFD2D9),
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                      //SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text('응답내용',
                                              style: SubTitleStyle(
                                                  color:
                                                  Color(0xff9FA5B2))),
                                          //SizedBox(width: 174.w),
                                          IconButton(
                                            color: Color(0xFFCFD2D9),
                                            constraints: BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Icon(Icons.navigate_next),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: size.height * 0.015),
                          ElevatedButton(
                              // backgroundColor: _onTap3? primary[40] : Color(0xFFCFD2D9),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(30.0))
                              // ),
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(
                                    size.width * 0.86, size.height * 0.075)),
                                backgroundColor: MaterialStateProperty.all(
                                  _allTap ? primary[40] : Color(0xFFCFD2D9),
                                  //_onTap3? primary[40] : onSecondaryColor,
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                )),
                              ),
                              child: Text('모두 동의하고 시작하기',
                                  style: titleMediumStyle(
                                      color: Color(0xffFAFBFB))),
                              onPressed: () {
                                print("here");

                                if (_allTap == true) {
                                  // print(FirebaseFirestore.instance
                                  //     .collection('project')
                                  //     .doc(
                                  //     'cLxKtSGWwhUVJp972FCh').toString());

                                  print(query['id']);
                                  var userlist = query['part_user'];
                                  print(userlist);
                                  if (!userlist.contains(
                                      '${FirebaseAuth.instance.currentUser!.email!}'))
                                    userlist.add(
                                        '${FirebaseAuth.instance.currentUser!.email!}');

                                  FirebaseFirestore.instance
                                      .collection('project')
                                      .doc(query['id'])
                                      .update({'part_user': userlist});

                                  for (int i = 0;
                                      i < query['object'].length;
                                      i++) {
                                    if (!user_object
                                        .contains(query['object'][i])) {
                                      user_object.add(query['object'][i]);
                                    }
                                  }

                                  print("user_object${user_object}");

                                  // //감지 객체 저장
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email!)
                                      .update({'object': user_object});

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (BuildContext context) =>
                                  //           MainHomePage(),
                                  //     ));

                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            todaycatchdetail3(query: query),
                                      ));
                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return MainHomePage();
                                  // }));
                                }

                                // if(_onTap3 == true)
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                                //     return todaycatchdetail3(query: query);
                                //   }));
                              })
                        ],
                      ),
                    );
                  });
                },
              );
            },
            child: Text('프로젝트 참여하기',
                style: titleMediumStyle(color: Color(0xffFAFBFB))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 30, 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
