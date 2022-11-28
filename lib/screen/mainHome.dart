import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../Auth/auth_service.dart';
// import 'Camera/cameraPage.dart';
import 'Community/HomePage.dart';
// import 'HomaPage/HomePage.dart';
import 'MyPage/MyPage.dart';
import 'album/albumPage.dart';
import 'projectPage/progectpage.dart';

class MainHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MainHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;
  Color? bgColorBottomNavigationBar;
  Color? iconColor;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var my_list2 = ['오늘의 캐치', '커뮤니티', '카메라', '앨범', '프로필'];

  final List<Widget> _widgetOptions = <Widget>[
    projectPage(),
    HomePage(),
    HomePage(),
    albumPage(),
    MYPage(),
  ];

  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFFF3F4F5),
      appBar: AppBar(
        elevation: 0,
        title: Text(my_list2.elementAt(_selectedIndex)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
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
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              color: iconColor,
            ),
            label: '카메라',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
              color: iconColor,
            ),
            label: '앨범',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: iconColor,
            ),
            label: '프로필',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedLabelStyle: Theme.of(context).primaryTextTheme.caption,
        showUnselectedLabels: true,
        // type: BottomNavigationBarType.fixed,
        backgroundColor: bgColorBottomNavigationBar,
        onTap: _onItemTapped,
      ),
    );
  }
}
