
import 'package:catch2_0_1/screen/projectPage/progect_main.dart';
import 'package:catch2_0_1/screen/projectPage/project_detail2.dart';
import 'package:catch2_0_1/screen/projectPage/project_detail1.dart';
import 'package:catch2_0_1/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../../utils/app_text_styles.dart';
import '../notFound.dart';
import 'create_pproject.dart';



// import 'package:persistent_bottom_nav_bar/nav_bar_styles/style_12_bottom_nav_bar.widget.dart';

class partiprojectPage extends StatefulWidget {
  const partiprojectPage({super.key});

  @override
  State<partiprojectPage> createState() => _partiprojectPageState();
}

class _partiprojectPageState extends State<partiprojectPage> {


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle:true,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('참여 중인 프로젝트',style: titleMediumStyle(color: Colors.black),),
      ),
      body: Column(children: [
        SizedBox(height: 30,),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('project').snapshots(),
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
                      QueryDocumentSnapshot x = snapshot.data!.docs[index];
                      if((snapshot.data!.docs[index]['part_user'].contains('${FirebaseAuth.instance.currentUser!.email!}'))) //FirebaseAuth.instance.currentUser!.email!))
                        return Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.05,
                              right: size.width * 0.05,
                              bottom: size.height * 0.01),
                          child: Card(
                            elevation: 0.3,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                            child: InkWell(
                              onTap: () {
                                print('참여중 프로젝트');
                                print(snapshot.data!.docs[index]['id']
                                    .toString());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          todaycatchdetail3(query: x),
                                    ));
                              },
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.03,
                                          left: size.width * 0.045),
                                      child: Text(
                                        ddaycalc(snapshot.data!.docs[index]
                                        ['final_day2']) >
                                            0
                                            ? "D- ${ddaycalc(snapshot.data!.docs[index]['final_day2'])}"
                                            : ddaycalc(snapshot
                                            .data!.docs[index]
                                        ['final_day2']) ==
                                            0
                                            ? "D-day"
                                            : "finished project",
                                        style: labelSmallStyle(
                                            color: Color(0xff9FA5B2)),
                                      ),
                                    ),
                                    ListTile(
                                      title: Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.01),
                                        child: Text(
                                          snapshot.data!.docs[index]['title']
                                              .toString(),
                                          style: ddaycalc(
                                              snapshot.data!.docs[index]
                                              ['final_day2']) <
                                              0
                                              ? titleMediumStyle(
                                              color: Colors.grey)
                                              : titleMediumStyle(),
                                        ),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Container(
                                            height: size.height * 0.025,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              border: Border.all(
                                                width: 1,
                                                color: Color(0xffCFD2D9),
                                              ),
                                              color: Colors.white,
                                            ),
                                            margin: EdgeInsets.only(
                                                top: size.height * 0.01),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.002,
                                                  bottom: size.height * 0.000,
                                                  left: size.width * 0.02,
                                                  right: size.width * 0.02),
                                              child: Text(
                                                snapshot
                                                    .data!.docs[index]['type']
                                                    .toString(),
                                                style: labelMediumStyle(
                                                    color: Color(0xff9FA5B2)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.01,
                                                left: size.width * 0.02),
                                            child: Text(
                                              snapshot
                                                  .data!.docs[index]['user']
                                                  .toString(),
                                              style: labelMediumStyle(
                                                  color: Color(0xff9FA5B2)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: size.width * 0.05,
                                              bottom: size.height * 0.02,
                                              top: size.height * 0.02),
                                          width: size.width * 0.63,
                                          height: size.height * 0.01,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(46)),
                                            child: LinearProgressIndicator(
                                              value:  snapshot.data!.docs[index]['url'].length/snapshot.data!.docs[index]['size'],
                                              valueColor:ddaycalc(snapshot
                                                  .data!.docs[index]
                                              ['final_day2']) <
                                                  0
                                                  ? AlwaysStoppedAnimation<Color>(
                                                  Color(0xffCFD2D9))
                                                  : !snapshot
                                                  .data!
                                                  .docs[index]
                                              ['part_user']
                                                  .contains(FirebaseAuth
                                                  .instance
                                                  .currentUser!
                                                  .email!)
                                                  ? AlwaysStoppedAnimation<Color>(
                                                  Color(0xff3A94EE))
                                                  : AlwaysStoppedAnimation<
                                                  Color>(Color(0xff00D796)),
                                              backgroundColor:
                                              Color(0xffE7E8EC),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.02,
                                              bottom: size.height * 0.02,
                                              left: size.width * 0.03),
                                          child: ddaycalc(
                                              snapshot.data!.docs[index]
                                              ['final_day2']) <
                                              0
                                              ? Image.asset(
                                            'assets/grey_coin.png',
                                            width: 20,
                                          )
                                              : !snapshot.data!
                                              .docs[index]['part_user']
                                              .contains(FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .email!)
                                              ? Image.asset(
                                            'assets/coin.png',
                                            width: 20,
                                          )
                                              : Image.asset(
                                            'assets/coin2.png',
                                            width: 20,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.02,
                                              bottom: size.height * 0.02,
                                              left: size.width * 0.01),
                                          child: Text(
                                            snapshot.data!.docs[index]['cash']
                                                .toString(),
                                            style: ddaycalc(snapshot
                                                .data!.docs[index]
                                            ['final_day2']) <
                                                0
                                                ? labelMediumStyle(
                                                color: Colors.grey)
                                                : labelMediumStyle(
                                                color: Color(0xff1A1A1A)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      else return Container();
                    });

              }),
        )
      ]),

    );
  }
}

