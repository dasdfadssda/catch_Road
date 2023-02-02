import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../Auth/auth_service .dart';
import 'HomePage.dart';

class DetailScreen extends StatefulWidget {
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

final Chatcontroller = TextEditingController();
final data = FirebaseFirestore.instance.collection('Contents').doc().get();

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    int _mylike = 0;
    int _Likes = 0;

    final _index = ModalRoute.of(context)!.settings.arguments;
    int _Index = int.parse(_index.toString());
    return Scaffold(
      bottomNavigationBar: BottomAppBar(child: _ChatUpload()),
      backgroundColor: Color(0XFFF3F4F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0XFFCFD2D9),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        elevation: 1,
        backgroundColor: Color(0XFFFAFBFB),
        centerTitle: true,
        title: Text(
          '커뮤니티',
          style: titleLargeStyle(),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Contents').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(23, 17, 25, 12.58),
                    // height: _height(snapshot.data!.docs[_Index]['imageUrl']),
                    //  decoration: BoxDecoration(
                    //    border: Border.all(color: Colors.blueAccent),
                    //    color: Colors.white
                    //           ),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xffCFD2D9),
                                      width: 1,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.005,
                                      bottom: size.height * 0.005,
                                      left: size.width * 0.02,
                                      right: size.width * 0.02),
                                  child: Text(
                                    snapshot.data!.docs[_Index]['category']
                                        ? '도로 위가 궁금해요'
                                        : '캐치가 궁금해요',
                                    style: labelSmallStyle(
                                        color: Color(0xff9FA5B2)),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(width: size.width * 0.4),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _showSnapBarForReport(
                                          context,
                                          snapshot.data!.docs[_Index]['id'],
                                          FirebaseAuth.instance.currentUser!
                                              .displayName);
                                    });
                                  },
                                  child: Text(
                                    '신고하기',
                                    style: labelSmallStyle(
                                        color: Color(0xff9FA5B2)),
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // 질문 부분
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'assets/logo.png',
                                  height: 25,
                                  width: 25,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        snapshot.data!.docs[_Index]
                                            ['displayName'],
                                        style: labelSmallStyle(
                                            color: Color(0xFF1A1A1A))),
                                    Text(snapshot.data!.docs[_Index]['adress'],
                                        style: labelSmallStyle(
                                            color: Color(0XFF9FA5B2))),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(snapshot.data!.docs[_Index]['contents'],
                              style: bodyMediumStyle(color: Color(0xFF1A1A1A))),
                          _image(
                              snapshot.data!.docs[_Index]['imageUrl']), // 사진 위젯
                          SizedBox(height: 20),
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
                            height: 12,
                            child: Row(
                              children: [
                                Spacer(),
                                IconButton(
                                  color: Color(0XFF878E9F),
                                  constraints: BoxConstraints(maxHeight: 15),
                                  //alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(0.0),
                                  iconSize: 14,
                                  icon: Icon(Icons.chat_bubble_outline),
                                  onPressed: () {
                                    print(('chat'));
                                  },
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                    snapshot.data!.docs[_Index]['_comment']
                                                .length ==
                                            0
                                        ? '댓글'
                                        : '댓글 ${snapshot.data!.docs[_Index]['_comment'].length.toString()}',
                                    style: labelSmallStyle(
                                        color: Color(0XFF9FA5B2))),
                                SizedBox(
                                  width: 17,
                                ),
                                IconButton(
                                  color: Color(0XFF878E9F),
                                  constraints: BoxConstraints(maxHeight: 15),
                                  padding: EdgeInsets.all(0.0),
                                  // alignment: Alignment.topLeft,
                                  iconSize: 14,
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {},
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  snapshot.data!.docs[_Index]['_like'].length
                                      .toString(),
                                  style:
                                      labelSmallStyle(color: Color(0XFF9FA5B2)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  );
                } else {
                  return Text('No data');
                }
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(docID().docid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(top: 70),
                    child: Align(
                      child: Text('       아직 댓글이 없어요 :(\n\n가장 먼저 댓글을 남겨보세요',
                          style: labelSmallStyle(color: Color(0XFF9FA5B2))),
                      alignment: Alignment.center,
                    ),
                  );
                } else
                  return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, _index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.03,
                                  left: size.width * 0.04),
                              child: Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        snapshot.data!.docs[_index]
                                            ['image_url'],
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[_index]
                                                ['profileName'],
                                            style: labelMediumStyle(),
                                          ),
                                          Text(
                                            snapshot.data!.docs[_index]['time'],
                                            style: labelMediumStyle(
                                                color: Color.fromRGBO(
                                                    159, 165, 178, 1)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: size.width * 0.1),
                                    child: Text(
                                      snapshot.data!.docs[_index]['contents'],
                                      style: labelLargeStyle(),
                                    ),
                                  ),
                                ],
                              )),
                            );
                          }));
              }),
        ],
      ),
    );
  }

  Widget _ChatUpload() {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.13,
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.05, left: size.width * 0.01),
            child: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/chat_map.png',
                    width: size.width * 0.1)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: size.height * 0.05, right: size.width * 0.01),
            child: IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/chat_photo.png')),
          ),
          Expanded(
              child: Container(
            height: size.height * 0.05,
            margin: EdgeInsets.only(
                bottom: size.height * 0.05, right: size.width * 0.03),
            child: TextField(
                controller: Chatcontroller,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.005,
                            bottom: size.height * 0.005),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent, elevation: 0.0),
                          child: Image.asset('assets/icons/chat_send.png'),
                          onPressed: () {
                            print("doc id ${docID().docid}");
                            uplaodChat(docID().docid, Chatcontroller.text,
                                docID().comment);
                            print(Chatcontroller.text);
                            Chatcontroller.clear();
                          },
                        )
                        // child: IconButton(
                        //   icon: Image.asset('assets/icons/chat_send.png'),
                        //   onPressed: (){

                        //   },
                        // )
                        ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffCFD2D9),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30)))),
          )),
        ],
      ),
    );
  }

  Widget _image(List imageList) {
    final Size size = MediaQuery.of(context).size;
    // 이미지 위젯
    int _num = imageList.length - 2;
    if (imageList.length == 0) {
      // 사진 없을 때
      return SizedBox(height: 22);
    } else if (imageList.length == 1) {
      return Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          height: size.height * 0.2,
          width: size.width * 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(7.0),
              child: Image.network(imageList[0].toString(), fit: BoxFit.fill)));
      // SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      //   child: Container(
      //       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      //       height: size.height * 0.1,
      //       width: double.infinity,
      //       child: ClipRRect(
      //           borderRadius: BorderRadius.circular(7.0),
      //           child:
      //               Image.network(imageList[0].toString(), fit: BoxFit.fill))),
      // );
    } else {
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
                  width: 165,
                )),
            SizedBox(width: 10),
            ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.network(
                  imageList[1].toString(),
                  fit: BoxFit.fill,
                  height: 160,
                  width: 165,
                )),
          ]));
    }
  }

  _height(List length) {
    if (length.length == 0) {
      return 165.0;
    } else if (length.length == 1) {
      return 365.0;
    }
  }

  void _showSnapBarForReport(context, id, user) {
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
                    "해당 게시물을 신고하시겠습니까?",
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
                        onPressed: () {
                          ReportFunction(id, user);
                          Navigator.pop(context);
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
}
