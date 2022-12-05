
import 'package:catch2_0_1/screen/projectPage/project_detail2.dart';
import 'package:catch2_0_1/screen/projectPage/todaycatch_detail.dart';
import 'package:catch2_0_1/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../../utils/app_text_styles.dart';
import '../notFound.dart';
import 'create_pproject.dart';

bool part=false;

// import 'package:persistent_bottom_nav_bar/nav_bar_styles/style_12_bottom_nav_bar.widget.dart';

class projectPage extends StatefulWidget {
  const projectPage({super.key});

  @override
  State<projectPage> createState() => _projectPageState();
}

class _projectPageState extends State<projectPage> {

  /* @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.017),
              child: Center(
                child: Image.asset(
                  'assets/catch_tap1.png',
                  width: size.width * 0.9,
                ),
              ),
            ),
            Container(
              child: StreamBuilder<QuerySnapshot>( // stack이라 그런지 안보여ㅜㅜ
        stream: FirebaseFirestore.instance.collection('project').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('  업로드 된\n글이 없어요 :(',style: labelLargeStyle(color: Color(0XFF9FA5B2)),));
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(24, 30, 24, 16),
                    decoration: BoxDecoration(
                      border: Border.all( 
                        width: 1,
                        ),
                    ),
                    child: Column(children: [
                      Text('D - ${snapshot.data!.docs[index]['final_day']}'), // datetime으로 날짜 계산해야할듯 이렇게 '' 사이에 field 이름 넣어서 받아오면 될듯!
                    ]),
                  );
                  }
                 );
                }
              ))
          ]),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.67, left: size.width * 0.8),
            child: FloatingActionButton(
              backgroundColor: primary[50],
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => add_personal(),
                      transitionDuration: Duration(seconds: 0),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c)),
                );
              },
              child: Image.asset(
                'assets/edit.png',
                width: size.width * 0.08,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class add_personal extends StatefulWidget {
  const add_personal({super.key});

  @override
  State<add_personal> createState() => _add_personalState();
}

class _add_personalState extends State<add_personal> {*/

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('오늘의 캐치',style: titleMediumStyle(color: Colors.black),),
      ),
      body: Column(children: [
        Container(
          // margin: EdgeInsets.fromLTRB(10, 22, 24, 10),
          margin: EdgeInsets.only(top: size.height*0.03, bottom: size.height*0.03),
          child: Center(
                  // padding: EdgeInsets.only(top: size.height * 0.017),
                  child: SlidingSwitch(
                    value: false,
                    width: size.width * 0.9,
                    onChanged: (bool value) {

                      setState(() {
                        part=value;
                        print(part);
                      });
                    },
                    height: 40,
                    
                    animationDuration: const Duration(milliseconds: 200),
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                    textOff: "모든 프로젝트",
                    textOn: "참여 중인 프로젝트",
                    contentSize: 15,
                    colorOn: Color(0xff6682c0),
                    colorOff: const Color(0xff6682c0),
                    background: const Color(0xffe4e5eb),
                    buttonColor: const Color(0xfff7f5f7),
                    // inactiveColor: Colors.red,
                  ),
                ),
        ),
        Padding(
          padding:  EdgeInsets.only(right: size.width*0.6, bottom: size.height*0.03),
          child: Text("캐치가 추천해요!", style: titleSmallStyle(color: Color(0xff9FA5B2)),),
        ),
       
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            
        stream: FirebaseFirestore.instance.collection('project').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('  업로드 된\n글이 없어요 :(',style: labelLargeStyle(color: Color(0XFF9FA5B2)),));
          if(part==true) return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot x = snapshot.data!.docs[index];

                if(snapshot.data!.docs[index]['participate']==1)

                return  Padding(
                  padding:  EdgeInsets.only(left: size.width * 0.05, right : size.width * 0.05, bottom: size.height * 0.01),
                  child: Card(
                    elevation: 0.2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: InkWell(
                      //카드 누르는 경우
                      onTap: (){
                        print('참여중 프로젝트');
                       print(snapshot.data!.docs[index]['id'].toString());


                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  todaycatchdetail3(query: x),
                            ));

                      },
                      child: Column(children: [
                        Padding(
                          padding:  EdgeInsets.only(top: size.height * 0.03, right: size.width * 0.7),
                          child: Text("D-" + snapshot.data!.docs[index]['final_day'].toString(), style: labelLargeStyle(color: Color(0xff9FA5B2)),),
                        ),
                        ListTile(
                          title: Padding(
                            padding:  EdgeInsets.only(top: size.height*0.01),
                            child: Text(snapshot.data!.docs[index]['title'].toString(), style: titleMediumStyle(),),
                          ),
                          subtitle: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffF3F4F5),),
                                margin: EdgeInsets.only(top: size.height*0.01),
                                child: Padding(
                                  padding:  EdgeInsets.all(8),
                                  child: Text(snapshot.data!.docs[index]['type'].toString(), style: labelMediumStyle(color: Color(0xff9FA5B2)),),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: size.height * 0.01, left: size.width*0.02),
                                child: Text(snapshot.data!.docs[index]['user'].toString(), style: labelMediumStyle(color: Color(0xff9FA5B2)),),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: size.width*0.05, bottom: size.height*0.03, top: size.height*0.01),
                              width: size.width*0.60,
                              height: size.height*0.01,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                child: LinearProgressIndicator(
                                  value: snapshot.data!.docs[index]['percentage'].toDouble() *0.01,
                                  valueColor:snapshot.data!.docs[index]['participate']==0? AlwaysStoppedAnimation<Color>(Color(0xff3A94EE)):AlwaysStoppedAnimation<Color>(Color(0xff00D796)),
                                  backgroundColor: Color(0xffE7E8EC),
                                ),
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom: size.height*0.02, left: size.width*0.03),
                              child:snapshot.data!.docs[index]['participate']==0? Image.asset('assets/coin.png', width: 20,):Image.asset('assets/coin2.png', width: 20,),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(bottom: size.height*0.02, left: size.width*0.01),
                              child: Text(snapshot.data!.docs[index]['cash'].toString() + "00"),
                            )

                          ],
                        ),




                      ]),
                    ),
                  ),
                );
                else return Container();
              }
          );
          if(part==false) return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot x =
                  snapshot.data!.docs[index];
                  return  Padding(
                    padding:  EdgeInsets.only(left: size.width * 0.05, right : size.width * 0.05, bottom: size.height * 0.01),
                    child: Card(
                      elevation: 0.2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: InkWell(
                              //카드 누르는 경우
                              onTap: (){

                                if(snapshot.data!.docs[index]['participate']==1){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            todaycatchdetail3(query: x),
                                      ));
                                }else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            todaycatchdetail(query: x),
                                      ));

                                }



                                print('모든 프로젝트');
                                print(snapshot.data!.docs[index]['id'].toString());
                              },
                              child: Column(children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: size.height * 0.03, right: size.width * 0.7),
                                  child: Text("D-" + snapshot.data!.docs[index]['final_day'].toString(), style: labelLargeStyle(color: Color(0xff9FA5B2)),),
                                ),
                                ListTile(
                                  title: Padding(
                                  padding:  EdgeInsets.only(top: size.height*0.01),
                                  child: Text(snapshot.data!.docs[index]['title'].toString(), style: titleMediumStyle(),),
                                ),
                                  subtitle: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffF3F4F5),),

                                        margin: EdgeInsets.only(top: size.height*0.01),
                                        child: Padding(
                                          padding:  EdgeInsets.all(8),
                                          child: Text(snapshot.data!.docs[index]['type'].toString(), style: labelMediumStyle(color: Color(0xff9FA5B2)),),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(top: size.height * 0.01, left: size.width*0.02),
                                        child: Text(snapshot.data!.docs[index]['user'].toString(), style: labelMediumStyle(color: Color(0xff9FA5B2)),),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: size.width*0.05, bottom: size.height*0.03, top: size.height*0.01),
                                      width: size.width*0.60,
                                      height: size.height*0.01,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        child: LinearProgressIndicator(
                                          value: snapshot.data!.docs[index]['percentage'].toDouble() *0.01,
                                          valueColor:snapshot.data!.docs[index]['participate']==0? AlwaysStoppedAnimation<Color>(Color(0xff3A94EE)):AlwaysStoppedAnimation<Color>(Color(0xff00D796)),
                                          backgroundColor: Color(0xffE7E8EC),
                                        ),
                                      ),
                                    ),
                                   Padding(
                                     padding:  EdgeInsets.only(bottom: size.height*0.02, left: size.width*0.03),
                                     child:snapshot.data!.docs[index]['participate']==0? Image.asset('assets/coin.png', width: 20,):Image.asset('assets/coin2.png', width: 20,),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.only(bottom: size.height*0.02, left: size.width*0.01),
                                     child: Text(snapshot.data!.docs[index]['cash'].toString() + "00"),
                                   )

                                  ],
                                ),




                              ]),
                            ),
                          ),
                  );
                }
                );
          else return Container();
        }),
        )
      ]),
      floatingActionButton: SpeedDial(
/*
        key: key,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
*/
        backgroundColor: Colors.blueAccent,
        child:Icon(Icons.edit_outlined,
        color: Colors.white,
          size:25,
      ),
        buttonSize: const Size(60, 60),
        useRotationAnimation: false,
        //animatedIcon: AnimatedIcons.menu_close,
        // icon: Image.asset('assets/images/catch_logo.png',
        //     height: 30.w,
        //     fit : BoxFit.fitWidth),
        activeIcon: Icons.close,
        animatedIconTheme: IconThemeData(
          size: 25,
          color: primary[0]?.withOpacity(0.4),
        ),
        // this is ignored if animatedIcon is non null
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        activeBackgroundColor: Colors.black.withOpacity(0.8),
        //childrenButtonSize: (const Size.round(100)),
        //activeForegroundColor: Colors.white,

        foregroundColor: Colors.white,
        elevation: 0.0,
        direction: SpeedDialDirection.up,
        shape: const CircleBorder(),
        children: [
          SpeedDialChild(
              child: Image.asset(
                'assets/icons/Subtract.png',
                height: 20,
                width: 16,
                //fit : BoxFit.fitWidth
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), //모서리
                //side: BorderSide(color: Colors.black),
              ),
              elevation: 0,
              backgroundColor: primary[50],
              label: '기업, 공공기관 프로젝트 의뢰하기',
              // labelWidget,
              //labelShadow : Colors.black.withOpacity(0.6),
              labelStyle: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 22 / 16,
                letterSpacing: 0,
                //fontWeight: FontWeight.w500,
                color: Colors.white,
                //color: primary[0]?.withOpacity(0.02),
              ),
              labelBackgroundColor: Colors.black.withOpacity(0.6),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          notFound(),
                    ));

              }),
          SpeedDialChild(
              child: Image.asset(
                'assets/icons/Union.png',
                height: 24,
                width: 21.61,
                //fit : BoxFit.fitWidth
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), //모서리
                //side: BorderSide(color: Colors.black),
              ),
              backgroundColor: primary[50],
              label: '개인 프로젝트 올리기',
              labelStyle: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                height: 22 / 16,
                letterSpacing: 0,
                //fontWeight: FontWeight.w500,
                color: Colors.white,
                //color: primary[0]?.withOpacity(0.02),
              ),
              //color: primary[0]?.withOpacity(0.02)),
              labelBackgroundColor: Colors.black.withOpacity(0.6),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CreatePproject(),
                    ));
              }),
        ],
      ),
    );
  }
}

