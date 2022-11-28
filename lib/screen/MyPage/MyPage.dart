import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';
import '../../utils/widget.dart';

class MYPage extends StatefulWidget {
  const MYPage({super.key});

  @override
  State<MYPage> createState() => _MYPageState();
}

class _MYPageState extends State<MYPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        backgroundColor: Color(0xffFAFBFB),
        title: Text('마이 페이지',style: titleMediumStyle(color: Colors.black),),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Center(
              child: ClipRRect(
                 borderRadius: BorderRadius.circular(100), // Image border
                 child: SizedBox.fromSize(
                 size: Size.fromRadius(48), // Image radius
                 child: Image.asset('assets/catchRoad_logo.png', fit: BoxFit.cover),)
                ),
            ),
           SizedBox(height: 16),
           Text('${FirebaseAuth.instance.currentUser!.displayName} 님',style: labelMediumStyle(color: Colors.black),),
           SizedBox(height: 4),
           Text(FirebaseAuth.instance.currentUser!.email.toString(),style: labelSmallStyle(color: Color(0xff9FA5B2)),),
           SizedBox(height: 20),
           MyWidget().DivderLine(),
           SizedBox(height: 20),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
             _buildButtonColumn('assets/cash_icon.png','10000',Color(0xff3174CD)),
           _buildButtonColumn('assets/Union.png','내가 쓴 글',Colors.black),
           _buildButtonColumn('assets/real_project.png','참여 프로젝트',Colors.black)
           ],),
           MyWidget().DivderLine(),
           _buildListTileButton('내 정보 수정'),
           _buildListTileButton('결제 정보 수정'),
           _buildListTileButton('계좌 정보 수정'),
           MyWidget().DivderLine(),
           SizedBox(height: 20),
           _buildListTileButton('공지 사항'),
           _buildListTileButton('약관 및 개인정보 처리'),
          ]),
        )
      ]),
    );
  }
    Container _buildButtonColumn( String image ,String label,Color color) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 0, 25, 20),
      child: InkWell(
        onTap: (){},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('${image}', height: 40,width: 40),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label, 
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  ListTile _buildListTileButton(String word){
    return ListTile(
      onTap: (){},
      leading: Text('  ${word}',style: bodyLargeStyle()),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}