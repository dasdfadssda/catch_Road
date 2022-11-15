import 'package:catch2_0_1/screen/communityPage/communitypage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/auth_service.dart';
import 'Camera/cameraPage.dart';
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

var my_list2 = ['오늘의 캐치', '커뮤니티', '카메라','앨범','프로필'];

 final List<Widget> _widgetOptions = <Widget>[
    projectPage(),
    communityPage(),
   CameraPage(),
   albumPage(),
    MYPage(),
 ];

  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // appBar: AppBar(
      //   leading: Drawer(
      //     elevation: 0,
      //     backgroundColor: Colors.blueAccent,
      //     child: Icon(Icons.menu)
      //     ),
      //   title: Text(my_list2.elementAt(_selectedIndex)),
      //   actions: [
      //     Row(children: [
      //       IconButton(
      //         onPressed: () {
      //           signOut();
      //         }, 
      //         icon: Icon(Icons.notifications)),
      //         SizedBox(
      //           width: 5,
      //         )
      //     ],)
      //   ],
      //   backgroundColor: Colors.blueAccent,
      // ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _bottomNavigationBar()
    );
  }
   Widget _bottomNavigationBar(){
     return Container(
       height: 80,
       child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
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
            type: BottomNavigationBarType.fixed,
            backgroundColor: bgColorBottomNavigationBar,
            onTap: _onItemTapped,
          ),
        ),
     );
   }
}