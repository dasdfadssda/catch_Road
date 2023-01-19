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
            title: Center(
              child: Text(
                '캐치박스',
                style: titleMediumStyle(color: Colors.black),
              ),
            )),
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
                          .doc('1234@handong.ac.kr')
                          .collection('category')
                          .orderBy('order', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Center(
                            child: Container(
                              padding:EdgeInsets.all(0),
                              margin: EdgeInsets.fromLTRB(size.width * 0.03,
                                  size.height * 0.0375, size.width * 0.03, 0),
                              child: Center(
                                  child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      childAspectRatio: 16 / 20,
                                      children: List.generate(
                                        snapshot.data!.docs.length,
                                        (index) {

                                          QueryDocumentSnapshot x =
                                              snapshot.data!.docs[index];

                                          FirebaseFirestore.instance
                                              .collection('category')
                                              .doc('1234@handong.ac.kr')
                                              .collection(x['category']).get().then((value) async {
                                                len=value.size;
                                                print('len $len');
                                                await FirebaseFirestore.instance
                                                    .collection("category")
                                                    .doc("1234@handong.ac.kr")//FirebaseAuth.instance.currentUser!.email
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
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(left:8,right: 8),
                                                  child: SizedBox(
                                                    height: size.height * 0.21,
                                                    width: size.width * 0.6,
                                                    child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.76),
                                                        ),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: Transform.rotate(
                                                          angle: (x['category'] ==
                                                                      'kickboard' ||
                                                                  x['category'] ==
                                                                      'traffic light')
                                                              ? 0
                                                              : 90 *
                                                                  math.pi /
                                                                  180,
                                                          child: ExtendedImage.network(
                                                            x['new'],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height:
                                                        size.height * 0.005),
                                                Center(
                                                  child: Container(
                                                      child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: size.width *
                                                              0.02),
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
                                                          SizedBox(height: size.height*0.0019),
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
