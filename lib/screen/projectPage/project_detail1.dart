import 'package:catch2_0_1/screen/projectPage/progect_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool onTap = false;

  bool onTap2 = false;
  bool _onTap3 = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    onTap = false;
    onTap2 = false;
    _onTap3 = false;
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
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Catcher',
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
                  // Expanded(
                  //     child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [Icon(Icons.more_vert)]))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Chip(
                      label: Container(
                          height: 15,
                          child: Text('기업',
                              style:
                                  labelMediumStyle(color: Color(0xff9FA5B2)))),
                      backgroundColor: Color(0xffF3F4F5)),
                  SizedBox(width: 5),
                  Text(query['cash'].toString(),
                      style: titleSmallStyle(color: Color(0xff9FA5B2))),
                  Text('캐시', style: titleSmallStyle(color: Color(0xff9FA5B2))),
                ],
              ),
              SizedBox(height: 20),
              Text(query['content'],
                  style: bodyMediumStyle(color: Color(0xff1A1A1A))),
              SizedBox(height: 30),
              Row(
                children: [
                  for (int i = 0; i < query['category'].length; i++)
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      //height: 25.h,
                      child: Chip(
                        label: Text(query['category'][i],
                            style: labelMediumStyle(color: Color(0xff1A1A1A))),
                        backgroundColor: Color(0xFFF3F4F5),
                        deleteIcon: Icon(
                          Icons.close,
                          size: 8,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: int.parse(query['percentage'].toString()) * 0.01,
                  minHeight: 8,
                  valueColor: AlwaysStoppedAnimation(primary[50]),
                  backgroundColor: primary[0]!.withOpacity(0.05),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(query['percentage'].toString(),
                      style: labelLargeStyle(color: Color(0xff9FA5B2))),
                  Text('% 달성',
                      style: labelLargeStyle(color: Color(0xff9FA5B2))),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${query['final_day'].toString()}일 후 마감',
                              style: labelSmallStyle(color: Color(0xff9FA5B2)))
                        ]),
                  )
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
                      height: size.height * 0.52,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(18, 20, 19, 20),
                                decoration: BoxDecoration(
                                  border: onTap
                                      ? Border.all(
                                          width: 2.0,
                                          color: Color(0xFF3A94EE),
                                        )
                                      : Border.all(
                                          color: Colors.white,
                                        ),
                                  color:
                                      onTap ? Color(0xFFF2F8FE) : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFCFD2D9),
                                      spreadRadius: 1,
                                      blurRadius: 50,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: 312,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      color: onTap
                                          ? Colors.blueAccent
                                          : Color(0xFFCFD2D9),
                                      onPressed: () {
                                        setState(() {
                                          onTap = !onTap;
                                          print(onTap);
                                        });
                                        if (onTap == true && onTap2 == true) //
                                          _onTap3 = true;
                                        else
                                          _onTap3 = false;
                                      },
                                      icon: Icon(Icons.check),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('개인정보 및 데이터 수집 및 이용 동의',
                                            style: titleSmallStyle(
                                                color: Color(0xff1A1A1A))),
                                        //SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Text('개인정보 통합 관리 및 조회',
                                                style: labelLargeStyle(
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
                                                style: labelLargeStyle(
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
                                    )
                                  ],
                                )),
                            onTap: () {
                              setState(() {
                                onTap = !onTap;
                                print(onTap);
                              });
                              if (onTap == true && onTap2 == true)
                                _onTap3 = true;
                              if (onTap2 == true && onTap == true)
                                _onTap3 = true;
                              else
                                _onTap3 = false;
                            },
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(18, 20, 19, 20),
                                decoration: BoxDecoration(
                                  border: onTap2
                                      ? Border.all(
                                          width: 2.0,
                                          color: Color(0xFF3A94EE),
                                        )
                                      : Border.all(
                                          color: Colors.white,
                                        ),
                                  color:
                                      onTap2 ? Color(0xFFF2F8FE) : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFCFD2D9),
                                      spreadRadius: 1,
                                      blurRadius: 50,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: 312,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      color: onTap2
                                          ? Colors.blueAccent
                                          : Color(0xFFCFD2D9),
                                      onPressed: () {
                                        setState(() {
                                          onTap2 = !onTap2;
                                          print(onTap);
                                        });
                                        if (onTap == true && onTap2 == true) //
                                          _onTap3 = true;
                                        else
                                          _onTap3 = false;
                                      },
                                      icon: Icon(Icons.check),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('개인정보 및 데이터 수집 및 이용 동의',
                                            style: titleSmallStyle(
                                                color: Color(0xff1A1A1A))),
                                        //SizedBox(height: 16.h),
                                        Row(
                                          children: [
                                            Text('개인정보 통합 관리 및 조회',
                                                style: labelLargeStyle(
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
                                                style: labelLargeStyle(
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
                                    )
                                  ],
                                )),
                            onTap: () {
                              setState(() {
                                onTap2 = !onTap2;
                                print(onTap);
                              });
                              if (onTap == true && onTap2 == true)
                                _onTap3 = true;
                              if (onTap2 == true && onTap == true)
                                _onTap3 = true;
                              else
                                _onTap3 = false;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              // backgroundColor: _onTap3? primary[40] : Color(0xFFCFD2D9),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.all(Radius.circular(30.0))
                              // ),
                              style: ButtonStyle(
                                fixedSize:
                                    MaterialStateProperty.all(Size(307, 58)),
                                backgroundColor: MaterialStateProperty.all(
                                  _onTap3 ? primary[40] : Color(0xFFCFD2D9),
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

                                if (_onTap3 == true) {
                                  // print(FirebaseFirestore.instance
                                  //     .collection('project')
                                  //     .doc(
                                  //     'cLxKtSGWwhUVJp972FCh').toString());
                                  print(query['id']);
                                  FirebaseFirestore.instance
                                      .collection('project')
                                      .doc(query['id'])
                                      .update({'participate': 1});
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return MainHomePage();
                                  }));
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
