import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../Auth/auth_service.dart';

import 'Camera/camera_load.dart';
import 'Community/HomePage.dart';

import 'MyPage/MyPage.dart';
import 'album/catchbox.dart';
//import 'album/albumPage.dart';
import 'projectPage/progect_main.dart';

List<CameraDescription> cameras2 = [];

class MainHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
  }

  void initCamera() async {
    cameras2 = await availableCameras();
  }

  Color? bgColorBottomNavigationBar;
  Color? iconColor;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var my_list2 = ['홈', '커뮤니티', '앨범', '프로필'];

  final List<Widget> _widgetOptions = <Widget>[
    projectPage(),
    HomePage(),
    Catchbox(),
    MYPage(),
  ];

  // String? user = FirebaseAuth.instance.currentUser!.email ??
  // FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //       topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        //   boxShadow: [
        //     BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 1),
        //   ],
        // ),
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
                icon: Icon(
                  Icons.home,
                  color: iconColor,
                ),
                label: '오늘의 캐치',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.bookmark,
                  color: iconColor,
                ),
                label: '커뮤니티',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.add, color: Colors.transparent,),
              //   label: '카메라',
              // ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.image,
                  color: iconColor,
                ),
                label: '캐치박스',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: iconColor,
                ),
                label: '마이페이지',
              ),
            ],
            currentIndex: _selectedIndex,
            //selectedLabelStyle: Theme.of(context).primaryTextTheme.caption,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColorBottomNavigationBar,
            onTap: _onItemTapped,
            selectedFontSize: 10,
            unselectedFontSize: 10,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: SizedBox(
          width: 30,
          height: 24,
          child: Image.asset(
            'assets/camera.png',
          ),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CamerLoad();
          }));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
