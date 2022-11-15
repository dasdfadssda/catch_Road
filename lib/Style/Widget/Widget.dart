import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../font.dart';

class MyWidget {
  Widget logoImage() {
  return Container(
    height: 49,
    width: 111,
    alignment: Alignment.topCenter,
    child: Image.asset('assets/LOGO.jpg'),
  );
}
  Widget AppBarK() {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
         shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)),
      title: Text('양덕동',style: titleStyle()),
      );
  }

  Widget IconImage(){
    return Image.asset(
      '',
      height: 70,
    );
  }

  Widget EnterRoomButton() {
    return IconButton(
      onPressed: (){},
      icon: Image.asset('assets/Make_room_button.png',
      height: 200,
      width: 145,
      )
      );
  }

   Widget MakeRoomButton() {
    return IconButton(
      onPressed: (){},
      icon: Image.asset('assets/Go_room_button.png',
      height: 200,
      width: 145,
      )
      );
  }

  Widget DivderLine() {
    return Divider(
      color: Color(0XFFE7E8EC),
      height: 1,
      thickness: 1,
      indent: 20,
      endIndent: 20
    );
  }

}
