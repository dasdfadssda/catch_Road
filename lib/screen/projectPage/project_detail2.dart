import 'package:camera/camera.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Camera/camera_load.dart';
import '../album/catchbox2.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_text_styles.dart';
// import 'camera/camera_page.dart';
// import 'catchbox2.dart';

List<CameraDescription> cameras = [];


class todaycatchdetail3 extends StatefulWidget {
  final QueryDocumentSnapshot query;

  todaycatchdetail3({required this.query});

  @override
  State<todaycatchdetail3> createState() => _todaycatchdetail3State(query : query);
}

class _todaycatchdetail3State extends State<todaycatchdetail3> {
  final QueryDocumentSnapshot query;
  _todaycatchdetail3State({required this.query});

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async{
    cameras = await availableCameras();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Center(child: Text('오늘의 캐치',style: titleMediumStyle(color: Colors.black),)),
        ),
        body: ListView(
            padding: EdgeInsets.fromLTRB(24, 40, 24, 32),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [

                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Catcher', style: labelLargeStyle(color:Colors.black)),
                        ],
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.more_vert)
                              ]
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(query['title'], style: titleLargeStyle(color:Colors.black)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      //if(query['participate'] == 1)
                      Chip(
                          label: Container(
                              height: 15,
                              child: Text('참여중', style: labelMediumStyle(color:Colors.black))
                          ),
                          backgroundColor: Color(0xFF00D796)
                      ),
                      SizedBox(width: 5),
                      Text(query['cash'].toString(), style: titleSmallStyle(color:Colors.black)),
                      Text('캐시', style: titleSmallStyle(color:Colors.black)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(query['content'], style: bodyMediumStyle(color:Colors.black)),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      for(int i = 0; i<query['category'].length; i++)
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Chip(
                              label: Text(query['category'][i], style: labelMediumStyle(color:Colors.black)),
                              backgroundColor: Color(0xFFF3F4F5)
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height:30),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      value: 0.04,
                      minHeight: 8,
                      valueColor: AlwaysStoppedAnimation(Color(0xff00D796)),
                      backgroundColor: Color(0xFFF3F4F5),
                    ),
                  ),
                  SizedBox(height:10),
                  Row(
                    children: [
                      Text(query['percentage'].toString(), style: labelLargeStyle(color:Colors.black)),
                      Text('% 달성', style: labelLargeStyle(color:Colors.black)),
                      Expanded(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${query['final_day'].toString()}일 후 마감', style: labelSmallStyle(color:Colors.black))
                            ]
                        ),
                      )
                    ],
                  ),
                ],
              )
            ]
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 25),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: ()async {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return catchme();
                      // }));


                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                       return CamerLoad();
                      }));
                      //
                      // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //   return CameraPage(cameras);
                      // }));

                    },
                    icon: Icon(Icons.camera_alt_outlined),

                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: FloatingActionButton(
                    backgroundColor: Colors.blueAccent,
                    onPressed: () async{

                      Navigator.push(context, MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Catchbox2(query: query),));
                    },
                    child: Text('사진 업로드하기', style: titleMediumStyle(color:Colors.white)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                  ),
                )

              ],
            )


        )
    );
  }
}

class MyClipper extends CustomClipper<Rect>{

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 30, 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

