import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/app_text_styles.dart';
import 'catchbox_detail.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:math' as math;
import 'package:extended_image/extended_image.dart';

class Catchbox extends StatefulWidget {
  const Catchbox({Key? key}) : super(key: key);

  @override
  _CatchboxState createState() => _CatchboxState();
}

class _CatchboxState extends State<Catchbox> {
  final storageRef = FirebaseStorage.instance.ref();

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
    final Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    int len=0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Center(child: Text('캐치박스',style: titleMediumStyle(color: Colors.black),)),
      ),
      body:  Container(

        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('category')
                          .doc("${FirebaseAuth.instance.currentUser!.email!}")
                          .collection('category')
                          .orderBy('order', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                              padding:EdgeInsets.all(0),
                              margin: EdgeInsets.fromLTRB(size.width * 0.03,
                                  size.height * 0.0375, size.width * 0.0, 0),
                              child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 16 / 18,
                                  children: List.generate(
                                    snapshot.data!.docs.length,
                                        (index) {
                                      QueryDocumentSnapshot x = snapshot.data!.docs[index];
                                      FirebaseFirestore.instance
                                          .collection('category')
                                          .doc("${FirebaseAuth.instance.currentUser!.email!}")//
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
                                                    Catchbox_detail(
                                                      query: x,
                                                      //  query2: query
                                                    ),
                                              ));
                                          //
                                          // 밑에꺼로 정보 넘겨줘야함.
                                          //Catchbox_detail(query: x),));
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,

                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(left:0,top:0,right: 0),
                                                child:  Container(
                                                  height: size.height * 0.2,
                                                  width: size.height * 0.2,
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
                                            SizedBox(height: size.height * 0.005),
                                            Center(
                                              child: Container(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: size.width * 0.05),
                                                      Container(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ))
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