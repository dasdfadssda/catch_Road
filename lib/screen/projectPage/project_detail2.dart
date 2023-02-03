import 'package:camera/camera.dart';
import 'package:catch2_0_1/screen/Camera/camera_page.dart';
import 'package:catch2_0_1/screen/projectPage/progect_main.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../main.dart';
import '../Camera/camera_load.dart';
import '../Camera/camera_viewer.dart';
import '../album/catchbox2.dart';
import '../mainHome.dart';

List<CameraDescription> cameras = [];

dynamic userInform3;
// List objectList=[];

class todaycatchdetail3 extends StatefulWidget {
  final QueryDocumentSnapshot query;

  todaycatchdetail3({required this.query});

  @override
  State<todaycatchdetail3> createState() =>
      _todaycatchdetail3State(query: query);
}

class _todaycatchdetail3State extends State<todaycatchdetail3> {
  final QueryDocumentSnapshot query;


  _todaycatchdetail3State({required this.query});


  @override
  void initState() {
    super.initState();
    initCamera();
  }


  void initCamera() async {
    cameras = await availableCameras();
  }

  List user_object2=[];
  @override
  Widget build(BuildContext context) {
     user_object2=user_object;

    final Size size = MediaQuery
        .of(context)
        .size;


    // FirebaseFirestore.instance.collection("user").doc(
    //     "${FirebaseAuth.instance.currentUser!.email}").get().then((
    //     DocumentSnapshot ds) async {
    //   userInform3 = await ds.data();
    //   objectList = userInform3['object'];
    //   print("here");
    //   print(objectList);});




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
                  Text(
                      ddaycalc(query['final_day2']) > 0
                          ? "D- ${ddaycalc(query['final_day2'])}"
                          : ddaycalc(query['final_day2']) == 0
                          ? "D-day"
                          : "finished project",
                      style: labelLargeStyle(color: Color(0xff9FA5B2))),
                ],
              ),
              SizedBox(height: size.height * 0.015),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    width: size.width * 0.795,
                    child: Row(

                      children: [
                        Text(query['title'],
                            style: titleLargeStyle(color: Colors.black)),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Image.asset('assets/icons/greenCheck.png',
                            height: size.height * 0.03),
                      ],
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.only(left: 3),
                    padding: const EdgeInsets.only(right: 0),
                    width: size.width * 0.067,
                    child: IconButton(
                      padding: const EdgeInsets.all(0.0),

                      iconSize: size.width * 0.067,
                      icon: Padding(
                        padding: EdgeInsets.all(0),
                        child: Icon(Icons.more_vert),
                      ),
                      onPressed: () {
                        print('취소');
                        print('user_object${user_object}');
                       _showActionSheet(context);


                      },
                    ),

                  )
                ],
              ),
              SizedBox(height: size.height * 0.015),
              Row(
                children: [
                  //if(query['participate'] == 1)
                  Container(
                      width: size.width * 0.1,
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
                  SizedBox(width: size.width * 0.02),
                  // 텍스트 다름
                  Text('${query['user']}',
                      style: labelMediumStyle(color: Color(0xff9FA5B2))),
                  //Text('캐시', style: titleSmallStyle(color: Colors.black)),
                ],
              ),
              SizedBox(height: 20),
              Text(query['content'],
                  style: bodyMediumStyle(color: Colors.black)),
              SizedBox(height: 30),
              Container(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (int i = 0; i < query['url'].length; i++)
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          //height: 25.h,

                          child: Card(
                            margin: EdgeInsets.all(0),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(14)),
                                ),
                                child: Expanded(
                                    child: Transform.rotate(
                                        angle: 90 * math.pi / 180,
                                        child: ExtendedImage.network(
                                            query['url'][i],
                                            fit: BoxFit.fill))

                                  //
                                )),
                          )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    'assets/coin2.png',
                    width: 20,
                  ),
                  SizedBox(width: size.width * 0.01),
                  Text('${query['cash'].toString()}00',
                      style: labelLargeStyle(color: Colors.black)),
                  SizedBox(width: size.width * 0.03),
                  for (int i = 0; i < query['object'].length; i++)
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Container(
                          height: size.height * 0.03,
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
                                left: size.width * 0.03,
                                right: size.width * 0.03),
                            child: Center(
                              child: Text(query['object'][i],
                                  style: labelMediumStyle(color: Colors.black)),
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
                  minHeight: size.height * 0.015,
                  valueColor: AlwaysStoppedAnimation(Color(0xff00D796)),
                  backgroundColor: Color(0xFFF3F4F5),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${query['size']} 중 ${query['url']
                              .length}장이 수집되었어요 !',
                              style: labelSmallStyle(color: Color(0xff1A1A1A)))
                        ]),
                  )
                ],
              ),
            ],
          )
        ]),
        bottomNavigationBar: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 25),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 0)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xff3A94EE),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () async {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return catchme();
                        // }));

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return CamerLoad(cameras);
                            }));
                        //
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return CameraPage(cameras);
                        // }));
                      },
                      icon: Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff3A94EE),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Catchbox2(query: query),
                          ));
                    },
                    child: Text('사진 업로드하기',
                        style: titleMediumStyle(color: Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  ),
                )
              ],
            )));
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                // isDefaultAction: true,
                onPressed: () async {
                  //사용자 지우기
                  var userlist = query['part_user'];
                  userlist.remove(FirebaseAuth.instance.currentUser!.email!);
                  FirebaseFirestore.instance
                      .collection('project')
                      .doc(query['id'])
                      .update({'participate': 1, 'part_user': userlist});

                  print('취소2');
                  print('삭제전 user_object${user_object}');
                  print("길이 ${user_object.length}");
                  int length=user_object.length;

                  for(int i=0;i<query['object'].length;i++){
                    user_object.remove(query['object'][i]);
                  }

                  print('삭제후 user_object${user_object}');


                  //감지 객체 삭제
                  FirebaseFirestore.instance
                      .collection('user')
                      .doc(
                      FirebaseAuth.instance.currentUser!.email!)
                      .update({
                    'object': user_object,
                  });
                  //
                  //
                  // eng_objectList = objectList;


                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainHomePage();
                  }));
                },
                child: const Text('프로젝트 참여 취소하기'),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              // isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
          ),
    );
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
