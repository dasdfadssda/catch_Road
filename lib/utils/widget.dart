import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyWidget {
  Widget logoImage() {
  return Container(
    height: 49,
    width: 111,
    alignment: Alignment.topCenter,
    child: Image.asset('assets/LOGO.jpg'),
  );
}

  Widget IconImage(){
    return Image.asset(
      '',
      height: 70,
    );
  }

  Widget DivderLine() {
    return Divider(
      color: Color(0XFFE7E8EC),
      height: 1,
      thickness: 1,
      indent: 15,
      endIndent: 15
    );
  }

}
