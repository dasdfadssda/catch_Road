
import 'package:catch2_0_1/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../utils/app_text_styles.dart';
// import 'package:persistent_bottom_nav_bar/nav_bar_styles/style_12_bottom_nav_bar.widget.dart';

class projectPage extends StatefulWidget {
  const projectPage({super.key});

  @override
  State<projectPage> createState() => _projectPageState();
}

class _projectPageState extends State<projectPage> {
  @override
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

class _add_personalState extends State<add_personal> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0x9FA5B2),
          leading: TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("취소", style: TextStyle(color: Color(0xff9FA5B2))),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Padding(
                padding: EdgeInsets.only(right: size.width * 0.03),
                child: Text(
                  "업로드",
                  style: TextStyle(color: primary[50]),
                ),
              ),
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
          ],
          title: Text("개인 프로젝트 올리기")),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.06,
              right: size.width * 0.06),
          child: TextFormField(
            cursorColor: Color(0xffBCBCBC),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCFD2D9)),
              ),
              contentPadding: EdgeInsets.only(left: size.width * 0.02),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffCFD2D9)),
              ),
              focusColor: Colors.transparent,
              hintText: '프로젝트 이름',
            ),
            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@'))
                  ? 'Do not use the @ char.'
                  : null;
            },
          ),
        ),
        // TextButton(onPressed: () {}, child: Text("수집 객체"))
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.045, right: size.width * 0.045),
          child: ListTile(
            trailing: Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: Color(0xffCFD2D9),
              ),
            ),
            onTap: () {},
            title: Text("수집 객체"),
          ),
        ),
        Image.asset('assets/divider.png', width: size.width * 0.88),
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.045, right: size.width * 0.045),
          child: ListTile(
            trailing: Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: Text("총 100 캐시"),
            ),
            onTap: () {},
            title: Text("최대 50장  X  장 당 캐시",
                style: TextStyle(color: Color(0xffCFD2D9))),
          ),
        ),
        Image.asset('assets/divider.png', width: size.width * 0.88),
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.045, right: size.width * 0.045),
          child: ListTile(
            trailing: Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: Color(0xffCFD2D9),
              ),
            ),
            onTap: () {},
            title: Text("프로젝트 기간"),
          ),
        ),
        Image.asset('assets/divider.png', width: size.width * 0.88),
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.045, right: size.width * 0.045),
          child: ListTile(
            trailing: Padding(
              padding: EdgeInsets.only(right: size.width * 0.02),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 35,
                color: Color(0xffCFD2D9),
              ),
            ),
            onTap: () {},
            title: Text("예시 사진 추가"),
          ),
        ),
        Image.asset('assets/divider.png', width: size.width * 0.88),
        Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.045, right: size.width * 0.045),
          child: ListTile(
            // onTap: () {},
            subtitle: Padding(
              padding: EdgeInsets.only(top: size.height * 0.015),
              child: Text("수집하고자 하는 사진에 대한 자세한 설명을 추가해주세요 !",
                  style: TextStyle(color: Color(0xffCFD2D9))),
            ),
          ),
        ),
      ]),
    );
  }
}
