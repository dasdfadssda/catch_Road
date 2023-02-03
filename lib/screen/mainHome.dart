import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';


import '../utils/app_text_styles.dart';
import 'Camera/camera_load.dart';
import 'Community/HomePage.dart';

import 'MyPage/MyPage.dart';
import 'album/catchbox.dart';

//import 'album/albumPage.dart';
import 'projectPage/progect_main.dart';

List<CameraDescription> cameras = [];
int selectedIndex0 = 0;
List user_object=[];
var user_Information;

List<Color> main_colorList=[Color(0xff3A94EE),Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9)];

class MainHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  void initCamera() async {
    cameras = await availableCameras();
  }

  Color? bgColorBottomNavigationBar;
  Color? iconColor;


  void _onItemTapped(int index) {
    setState(() {
      selectedIndex0 = index;
      print(selectedIndex0);
      main_colorList=[Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9)];
      main_colorList[index]=Color(0xff3A94EE);

    });
  }

  var my_list2 = ['홈', '커뮤니티', '캐치박스', '마이페이지'];

  final List<Widget> _widgetOptions = <Widget>[
    projectPage(),
    HomePage(),
    Catchbox(),
    MYPage(),
  ];

  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    FirebaseFirestore.instance
        .collection("user")
        .doc("${FirebaseAuth.instance.currentUser!.email}")
        .get()
        .then((DocumentSnapshot ds) async {
      user_Information = await ds.data();
      user_object = user_Information['object'];
      print(user_object);
      print("user_object${user_object}");
    });


    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(selectedIndex0),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 1),
          ],
        ),
        height: 70,
        child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              elevation: 10,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/bottombar/today_catch.png',
                    color: main_colorList[0],
                    width:size.width*0.055,
                  ),
                  label: '\n 오늘의 캐치',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/bottombar/community.png',
                    color: main_colorList[1],
                    width:size.width*0.055,
                  ),
                  label: '\n 커뮤니티',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.add, color: Colors.transparent,),
                //   label: '카메라',
                // ),
                BottomNavigationBarItem(
                  icon:Image.asset(
                    'assets/icons/bottombar/catchbox.png',
                    color: main_colorList[2],
                    width:size.width*0.055,
                  ),
                  label: '\n 캐치박스',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/bottombar/mypage.png',
                    color:main_colorList[3],
                    width:size.width*0.055,
                  ),
                  label: '\n 마이페이지',
                ),
              ],
              selectedItemColor: Color(0xff3A94EE),
              unselectedItemColor: Color(0xffCFD2D9),
              currentIndex: selectedIndex0,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: bgColorBottomNavigationBar,
              selectedLabelStyle: labelSmallStyle(color:Color(0xff3A94EE)),
              unselectedLabelStyle: labelSmallStyle(color:Color(0xffCFD2D9)),
              onTap: _onItemTapped,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 5,
        child: SizedBox(
          width: 20,
          height: 20,
          child: Image.asset('assets/camera.png'),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CamerLoad(cameras);
          }));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
