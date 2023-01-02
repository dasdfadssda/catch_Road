import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:catch2_0_1/Auth/auth_service.dart';
import 'package:catch2_0_1/screen/mainHome.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddPAge.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

bool toggle1 = true;
bool toggle2 = false;
bool toggle3 = false;

// snapshot.data!.docs[index][''] // 불러올 떄 쓰는 방법
class _HomePageState extends State<HomePage> {
  var _listTextTabToggle = ["전체", "도로 위가 궁금해요", "캐치가 궁금해요"];
  var _tabTextIndexSelected = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _toDay = DateTime.now(); // 시간 비교 하기
  int _mylike = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFF3F4F5),
      appBar: AppBar(
          centerTitle: true,
          // 앱바
          titleTextStyle: titleMediumStyle(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainHomePage()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: TextButton(
            child: Center(
                child: Text(
              '양덕동 외 1곳',
              style: SubTitleStyle(color: Colors.black),
            )),
            onPressed: () {},
          ),
          // Row(
          //   children: [
          //     TextButton(
          //       child: Center(
          //           child: Text(
          //         '양덕동 외 1곳',
          //         style: SubTitleStyle(color: Colors.black),
          //       )),
          //       onPressed: () {},
          //     ),
          //     // IconButton(
          //     //     onPressed: () {}, icon: Icon(Icons.arrow_drop_down_sharp))
          //   ],
          // ),
          actions: [
            Row(
              children: [
                IconButton(
                    // 추후 검색 버튼
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Color(0XFF3A94EE),
                    )),
                SizedBox(width: 23.2)
              ],
            )
          ],
          bottom: buildAppBarBottom()),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Contents').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: Text(
                '  업로드 된\n글이 없어요 :(',
                style: labelLargeStyle(color: Color(0XFF9FA5B2)),
              ));
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, '/detail', arguments: index);
                      print(index);
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 7),
                        color: Colors.white,
                        padding: EdgeInsets.fromLTRB(19, 17, 19, 12.43),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(2, 3, 2, 3),
                                height: 20,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0XFFCFD2D9)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * 0.01,
                                      right: size.width * 0.01),
                                  child: Text(
                                    snapshot.data!.docs[index]['category']
                                        ? '도로 위가 궁금해요'
                                        : '캐치가 궁금해요',
                                    style: labelSmallStyle(
                                        color: Color(0XFF9FA5B2)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                // 질문 부분
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['contents'],
                                    style: bodyMediumStyle(
                                        color: Color(0xFF1A1A1A)),
                                  ),
                                ],
                              ),

                              _image(snapshot.data!.docs[index]['imageUrl']),
                              // 사진 위젯

                              Row(
                                children: [
                                  Text(
                                      '${snapshot.data!.docs[index]['displayName']}',
                                      style: labelSmallStyle(
                                          color: Color(0XFF9FA5B2))),
                                  Text(
                                      ' ·${snapshot.data!.docs[index]['adress']}',
                                      style: labelSmallStyle(
                                          color: Color(0XFF9FA5B2))),
                                  Flexible(child: SizedBox(width: 300)),
                                  // Container(
                                  //   child: Text('33분 전',style: LabelsmallStyle(color: Color(0XFF9FA5B2)),),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Center(
                                // 디바이더 위젯
                                child: SizedBox(
                                  width: 350,
                                  child: Divider(
                                    thickness: 1,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 13),
                              SizedBox(
                                height: 15,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                                      child: IconButton(
                                        color: Color(0XFF878E9F),
                                        constraints:
                                            BoxConstraints(maxHeight: 15),
                                        //alignment: Alignment.topLeft,
                                        padding: EdgeInsets.all(0.0),
                                        iconSize: 20,
                                        icon: Image.asset(
                                            'assets/icons/likeicon.png',
                                            width: 20),
                                        onPressed: () {
                                          print(('chat'));
                                        },
                                      ),
                                    ),
                                    SizedBox(width: size.width * 0.1),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.0),
                                      child: Image.asset(
                                          'assets/icons/chaticon.png'),
                                    ),
                                    SizedBox(width: size.width * 0.01),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                          snapshot.data!.docs[index]['_comment']
                                                      .length ==
                                                  0
                                              ? ' 댓글'
                                              : ' 댓글 ${snapshot.data!.docs[index]['_comment'].length.toString()}',
                                          style: labelMediumStyle(
                                              color: Color(0XFF9FA5B2))),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    // IconButton(
                                    //   color: Colors.grey,
                                    //   constraints:
                                    //       BoxConstraints(maxHeight: 15),
                                    //   padding: EdgeInsets.all(0.0),
                                    //   iconSize: 20,
                                    //   icon: Icon(snapshot
                                    //               .data!
                                    //               .docs[index]['_like']
                                    //               .length ==
                                    //           0
                                    //       ? Icons.favorite_border
                                    //       : Icons.favorite),
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       if (snapshot
                                    //               .data!
                                    //               .docs[index]['_like']
                                    //               .length !=
                                    //           0) {
                                    //         for (int i = 0;
                                    //             i <
                                    //                 snapshot
                                    //                     .data!
                                    //                     .docs[index]['_like']
                                    //                     .length;
                                    //             i++) {
                                    //           if (snapshot.data!.docs[index]
                                    //                   ['_like'][i] ==
                                    //               "바ㄱ정규") {
                                    //             print('좋아요 취소');
                                    //             LikeCancelFunction(
                                    //                 snapshot.data!.docs[index]
                                    //                     ['_like'],
                                    //                 snapshot.data!.docs[index]
                                    //                     ['id'],
                                    //                 "바ㄱ정규");
                                    //             break;
                                    //           } else {
                                    //             print('좋아요');
                                    //             LikeFunction(
                                    //                 snapshot.data!.docs[index]
                                    //                     ['_like'],
                                    //                 snapshot.data!.docs[index]
                                    //                     ['id'],
                                    //                 '바ㄱ정규');
                                    //           }
                                    //         }
                                    //       } else {
                                    //         print('좋아요');
                                    //         LikeFunction(
                                    //             snapshot.data!.docs[index]
                                    //                 ['_like'],
                                    //             snapshot.data!.docs[index]
                                    //                 ['id'],
                                    //             "바ㄱ정규");
                                    //       }
                                    //     });
                                    //   },
                                    // ),

                                    SizedBox(width: 6),
                                    Image.asset(
                                      'assets/icons/likeicon.png',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          0, 0, 0, size.height * 0.0),
                                      child: Text(
                                        ' 좋아요 ',
                                        style: labelMediumStyle(
                                            color: Color(0XFF9FA5B2)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                                      child: Text(
                                        snapshot
                                            .data!.docs[index]['_like'].length
                                            .toString(),
                                        style: labelMediumStyle(
                                            color: Color(0XFF9FA5B2)),
                                      ),
                                    ),
                                    SizedBox(width: 17),
                                  ],
                                ),
                              ),
                            ])),
                  );
                });
          }),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          // 플로팅 액션 버튼

          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
          },
          child: Icon(
            Icons.edit_outlined,
            color: Colors.white,
            size: 27,
          ),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }

  bool _all = true;
  bool _catch = false;
  bool _road = false;

  PreferredSizeWidget buildAppBarBottom() {
    final Size size = MediaQuery.of(context).size;
    // 바텀바 부분
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      // child:Container(
      //   height: 30,
      //   margin: EdgeInsets.fromLTRB(25, 0, 15,20),
      //     child :  Row(
      //        mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         _AllButton(),
      //         _roadButton(),
      //         _catchButton()
      //     ],),
      //   )
      child: // Here default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
          Stack(
        children: [
          Container(
            height: size.height * 0.07,
            color: Color.fromRGBO(243, 244, 245, 1),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.013),
            child: Center(
              child: FlutterToggleTab(
// width in percent
                width: 93.3,
                borderRadius: 30,
                height: 33,
                selectedIndex: _tabTextIndexSelected,
                selectedBackgroundColors: [Colors.white],
                selectedTextStyle: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 20 / 14,
                    letterSpacing: 0.1,
                    color: Color(0xff3A94EE)),
                unSelectedTextStyle: TextStyle(
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    height: 20 / 14,
                    letterSpacing: 0.1,
                    color: Color(0xff9FA5B2)),
                labels: _listTextTabToggle,
                marginSelected:
                    EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 2),
                selectedLabelIndex: (index) {
                  setState(() {
                    _tabTextIndexSelected = index;
                  });
                },
                isScroll: false,
              ),
            ),
          ),
        ],
      ),
      // AnimatedButtonBar(
      //   radius: 20.0,
      //   padding: const EdgeInsets.all(16.0),
      //   invertedSelection: true,
      //   backgroundColor: Colors.yellow,
      //   foregroundColor: Colors.white,
      //   children: [
      //     ButtonBarEntry(
      //         onTap: () => setState(() {
      //               toggle1 = !toggle1;
      //             }),
      //         child: Text(
      //           '전체',
      //           style: TextStyle(
      //               color: toggle1 ? Color(0XFF3A94EE) : Color(0XFF9FA5B2)),
      //         )),
      //     ButtonBarEntry(
      //         onTap: () => print('Second item tapped'),
      //         child: Text(
      //           '도로 위 궁금해요.',
      //           style: TextStyle(color: Color(0XFF9FA5B2)),
      //         )),
      //     ButtonBarEntry(
      //         onTap: () => print('Third item tapped'),
      //         child: Text(
      //           '캐치가 궁금해요.',
      //           style: TextStyle(color: Color(0XFF9FA5B2)),
      //         )),
      //   ],
      // ),
    );
  }

  Widget _AllButton() {
    // 앱바의 전체 버튼
    return Container(
      width: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 0,
            textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: _all ? Color(0XFF3A94EE) : Color(0XFFF2F8FE)),
            primary: _all ? Color(0XFF3A94EE) : Color(0XFFF2F8FE),
            onPrimary: _all ? Colors.white : Color(0XFF9FA5B2),
          ),
          onPressed: () {
            setState(() {
              _all = true;
              _road = false;
              _catch = false;
              print("전체 ${_all}");
            });
          },
          child: Text(
            '전체',
            style:
                TextStyle(color: _all ? Color(0XFF3A94EE) : Color(0XFFF2F8FE)),
          )),
    );
  }

  Widget _roadButton() {
    // 앱바의 로드 버튼
    return Container(
      margin: EdgeInsets.only(left: 17),
      alignment: Alignment.center,
      width: 130,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            primary: _road ? Color(0XFF3A94EE) : Color(0XFFF2F8FE),
            onPrimary: _road ? Colors.white : Color(0XFF9FA5B2),
          ),
          onPressed: () {
            setState(() {
              _road = true;
              _all = false;
              _catch = false;
              print("도로가 ${_road}");
            });
          },
          child: Text('도로 위가 궁금해요')),
    );
  }

  Widget _catchButton() {
    // 앱바의 캐피 버튼
    return Container(
      margin: EdgeInsets.only(left: 12),
      alignment: Alignment.center,
      width: 122,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            primary: _catch ? Color(0XFF3A94EE) : Color(0XFFF2F8FE),
            onPrimary: _catch ? Colors.white : Color(0XFF9FA5B2),
          ),
          onPressed: () {
            setState(() {
              _road = false;
              _all = false;
              _catch = true;
              print("캐치가 ${_catch}");
            });
          },
          child: Text('캐치가 궁금해요')),
    );
  }

  Widget _image(List imageList) {
    // 이미지 위젯
    int _num = imageList.length - 2;
    if (imageList.length == 0) {
      // 사진 없을 때
      return SizedBox(height: 22);
    } else if (imageList.length == 1) {
      return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          height: 190,
          width: double.infinity,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image.network(imageList[0].toString(), fit: BoxFit.fill)));
    } else if (imageList.length == 2) {
      //사진 있을 때
      return Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.network(
                  imageList[0].toString(),
                  fit: BoxFit.fill,
                  height: 160,
                  width: 161,
                )),
            SizedBox(width: 10),
            ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.network(
                  imageList[1].toString(),
                  fit: BoxFit.fill,
                  height: 160,
                  width: 161,
                )),
          ]));
    } else {
      return Container(
        // 사진 3개 이상
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.network(
                  imageList[0].toString(),
                  fit: BoxFit.fill,
                  height: 160,
                  width: 161,
                )),
            SizedBox(width: 10),
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: Image.network(
                      imageList[1].toString(),
                      fit: BoxFit.fill,
                      height: 160,
                      width: 161,
                    )),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.black54,
                  ),
                  height: 160,
                  width: 161,
                  child: Text(
                    '+${_num}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
