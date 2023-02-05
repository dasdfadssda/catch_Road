import 'dart:async';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:math' as math;

import '../../utils/app_text_styles.dart';
import 'catchbox_detail2.dart';

class Catchbox2 extends StatefulWidget {
  final QueryDocumentSnapshot query;

  Catchbox2({required this.query});

  @override
  _Catchbox2State createState() => _Catchbox2State(query: query);
}

class _Catchbox2State extends State<Catchbox2> {
  final storageRef = FirebaseStorage.instance.ref();

  final QueryDocumentSnapshot query;
  _Catchbox2State({required this.query});

  Reference ref = FirebaseStorage.instance
      .ref()
      .child('gallery')
      .child('motorcycle')
      .child('motorcycle1.png');

  Future<void> _downloadLink(Reference ref) async {
    final link = await ref.getDownloadURL();

    await Clipboard.setData(
      ClipboardData(
        text: link,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Success!\n Copied download URL to Clipboard!',
        ),
      ),
    );
  }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String imageName) async {
    String url = await storage.ref('$imageName').getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    bool isgo = false;
    final Size size = MediaQuery.of(context).size;
    bool isSearch = false;
    int len=0;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height*0.085),
        child: AppBar(
            centerTitle: true,
            // leading: TextButton(
            //     onPressed: () {
            //
            //       Navigator.pop(context);
            //     },
            //     child: Text(
            //       "취소",//pressed ? "취소" : "선택",
            //       style: TextStyle(fontSize: 12, color: Colors.grey),
            //     )
            //   // Container(
            //   //   child: Center(
            //   //       child: Text(
            //   //         pressed ? "취소" : "선택",
            //   //         style: TextStyle(fontSize: 12, color: Colors.white),
            //   //       )),
            //   //   width: 60,
            //   //   height: 30,
            //   //   decoration: BoxDecoration(
            //   //       color: Color.fromRGBO(58, 148, 238, 1),
            //   //       borderRadius: BorderRadius.circular(100.0)),
            //   //   //padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            //   //   //  child: Center(child: Text(_selectCheck, style: TextStyle(color: _selectCheckTextColor))),
            //   // ),
            // ),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       setState(() {
            //         isSearch = !isSearch;
            //       });
            //     },
            //     icon: Icon(
            //       Icons.search,
            //       color: isSearch ? Color(0xff3A94EE) : Color(0xff9FA5B2),
            //     ),
            //   ),
            // ],
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0.3,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      width: (size.width-35)/3,
                      child:Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            onPressed: () {
                              check_num=0;
                              Navigator.pop(context);
                              // setState(() {
                              //   if (_selectCheckIcon) {
                              //     pressed = true;
                              //     _selectCheck = '취소';
                              //     _selectCheckColor = Colors.blue; // primary[40]!;
                              //     _selectCheckTextColor = Color(0XFFF3F4F5);
                              //     // _selectPlaceTextColor = Colors.red;
                              //     _selectCheckIcon = false;
                              //   } else {
                              //     pressed = false;
                              //     _selectCheckColor = Color(0XFFF3F4F5);
                              //     _selectCheck = '선택';
                              //     _selectCheckTextColor = Color(0xFF9FA5B2);
                              //     _selectCheckIcon = true;
                              //     check_num=0;
                              //     _checks.fillRange(0, _checks.length-1,false);
                              //     print(_checks.length);
                              //     _checks_url.fillRange(0, _checks_url.length-1,'');
                              //   }
                              // });
                            },
                            child: Text(
                              "취소",//pressed ? "취소" : "선택",
                              style: SubTitleStyle(color: Colors.grey),
                            )
                        ),
                      ),
                    ),
                    Container(
                        width: (size.width-35)/3,
                        child:Center(
                          child: Text(
                            '캐치박스',
                            style: titleMediumStyle(color: Colors.black),
                          ),
                        )
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      width: (size.width-35)/3,
                      // child:Align(
                      //   alignment: Alignment.centerRight,
                      //   child: TextButton(//pressed==true?
                      //     onPressed: () async {
                      //
                      //       var urllist=query2['url'];
                      //
                      //
                      //
                      //       for(int i = 0; i < 1000; i++){
                      //         if(_checks[i]){
                      //           urllist.add(_checks_url[i]);}
                      //       }
                      //       print(urllist);
                      //
                      //       await FirebaseFirestore.instance
                      //           .collection('project')
                      //           .doc(query2['id'])
                      //           .update({
                      //         'participate':1,
                      //         'url':urllist
                      //       });
                      //
                      //
                      //
                      //       showModalBottomSheet<void>(
                      //         enableDrag: true,
                      //         isScrollControlled: true,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.only(
                      //                 topLeft: Radius.circular(30.0),
                      //                 topRight: Radius.circular(30.0))),
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return StatefulBuilder(
                      //               builder: (BuildContext context, StateSetter setState) {
                      //                 return Container(
                      //                   height: size.height * 0.5,
                      //                   padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      //                   child: Column(
                      //                     children: [
                      //                       SizedBox(
                      //                         height: size.height * 0.06,
                      //                       ),
                      //
                      //                       SizedBox(
                      //                           height:150,
                      //                           child: Image.asset('assets/checkToFinish.gif')),
                      //                       SizedBox(
                      //                         height: size.height * 0.0475,
                      //                       ),
                      //                       Text('사진이 업로드 되었습니다. '),
                      //
                      //                       SizedBox(height: size.height * 0.025),
                      //
                      //                       SizedBox(
                      //                         height: 20,
                      //                       ),
                      //                       ElevatedButton(
                      //                           style:ButtonStyle(
                      //                             fixedSize:
                      //                             MaterialStateProperty.all(Size(307, 50)),
                      //                             backgroundColor: MaterialStateProperty.all(
                      //                               Color(0xff3A94EE),
                      //                               //_onTap3? primary[40] : onSecondaryColor,
                      //                             ),
                      //                             shape: MaterialStateProperty.all<
                      //                                 RoundedRectangleBorder>(
                      //                                 RoundedRectangleBorder(
                      //                                   borderRadius: BorderRadius.circular(30.0),
                      //                                 )),
                      //                           ),
                      //
                      //                           child: Text('확인',
                      //                               style: titleMediumStyle(
                      //                                   color: Color(0xffFAFBFB))),
                      //                           onPressed: () {
                      //
                      //                             check_num=0;
                      //                             print("here");
                      //                             print(_checks_url);
                      //
                      //                             Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //                               return MainHomePage();
                      //                             }));
                      //
                      //
                      //                             // Navigator.pop(context);
                      //                             // Navigator.pop(context);
                      //                             // Navigator.pop(context);
                      //                             //
                      //                           }
                      //
                      //                       )
                      //                     ],
                      //                   ),
                      //                 );
                      //               });
                      //         },
                      //       );
                      //       // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //       //   return uploadCheck();
                      //       // }));
                      //
                      //       // await Future.delayed(Duration(seconds: 3));
                      //       //
                      //       // Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //       //   return MainHomePage();
                      //       // }));
                      //
                      //     },
                      //     child: Text('업로드', style: TextStyle(color: Colors.blue)),
                      //   ),
                      // ),

                    ),









                  ],

                ),

              ],
            ),
        ),
      ),
      body: Container(

        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('category')
                          .doc('${FirebaseAuth.instance.currentUser!.email!}')
                          .collection('category')
                          .orderBy('order', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Container(
                              padding:EdgeInsets.all(0),
                              margin: EdgeInsets.fromLTRB(size.width * 0.03,
                                  size.height * 0, size.width * 0.03, 0),
                              child: Center(
                                  child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      childAspectRatio: 16 / 18,
                                      children: List.generate(
                                        snapshot.data!.docs.length,
                                        (index) {

                                          QueryDocumentSnapshot x =
                                              snapshot.data!.docs[index];

                                          FirebaseFirestore.instance
                                              .collection('category')
                                              .doc('${FirebaseAuth.instance.currentUser!.email!}')
                                              .collection(x['category']).get().then((value) async {
                                                len=value.size;
                                                print('len $len');
                                                await FirebaseFirestore.instance
                                                    .collection("category")
                                                    .doc("${FirebaseAuth.instance.currentUser!.email!}")//FirebaseAuth.instance.currentUser!.email
                                                    .collection('category')
                                                    .doc(x['category'])
                                                    .update({
                                                  "num": value.size,
                                                });
                                          });
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Catchbox_detail2(query: x, query2: query),
                                                  ));
                                              //
                                              // 밑에꺼로 정보 넘겨줘야함.
                                              //Catchbox_detail(query: x),));
                                            },
                                            child:Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,

                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left:0,right: 0,top:0),
                                                  child:  Container(
                                                    height: size.height * 0.2,
                                                    width: size.height * 0.2,
                                                    child: SizedBox(
                                                      height: 119.04,
                                                      width: 118.08,
                                                      child: Card(
                                                          clipBehavior: Clip.antiAlias,
                                                          child: Transform.rotate(
                                                            angle: 90 * math.pi / 180,
                                                            child: ExtendedImage.network(
                                                              x['new'],
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )),
                                                    ),
                                                  ),

                                                ),
                                                SizedBox(
                                                    height: size.height * 0.005),
                                                Center(
                                                  child: Container(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: size.width * 0.05),
                                                          Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    '${x['category']} ',
                                                                    style: Theme.of(
                                                                        context)
                                                                        .textTheme
                                                                        .labelLarge,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                  ),
                                                                  Text(
                                                                    '${x['num']}',
                                                                    style: bodySmallStyle(
                                                                        color: Color(
                                                                            0xff9FA5B2)),
                                                                  ),
                                                                  // SizedBox(height: size.height*0.5),
                                                                  //const SizedBox(height: 8.0),
                                                                  // Text(
                                                                  //   "${snapshot.data!.docs[index]['count']}",
                                                                  //   //FirebaseFirestore.instance.collection('category').doc('user1').collection(snapshot.data!.docs[index]['category']).doc('date').collection('date').snapshots().length.toString(),
                                                                  //   style: Theme.of(context).textTheme.labelSmall,
                                                                  // ),
                                                                ],
                                                              ))
                                                        ],
                                                      )),
                                                ),

                                              ],
                                            ),

                                            // Padding(
                                            //   padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 5.0),
                                            //   child: Column(
                                            //     crossAxisAlignment: CrossAxisAlignment.start,
                                            //     children: <Widget>[
                                            //       Text(
                                            //         x['category'],
                                            //         style: Theme.of(context).textTheme.headline6,
                                            //         maxLines:1,
                                            //         overflow: TextOverflow.ellipsis,
                                            //       ),
                                            //       const SizedBox(height: 8.0),
                                            //       Text(
                                            //         //"${x['price'].toString()}원",
                                            //         '몇개인지',
                                            //         style: Theme.of(context).textTheme.subtitle2,
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                          );

                                        },
                                      ))),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
