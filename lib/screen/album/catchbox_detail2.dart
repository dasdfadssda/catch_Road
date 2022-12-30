import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../../utils/app_text_styles.dart';
import '../Camera/camera_load.dart';
import '../Community/HomePage.dart';
import '../MyPage/MyPage.dart';
import '../mainHome.dart';
import '../notFound.dart';
import '../projectPage/progect_main.dart';
import '../projectPage/upload_check.dart';
import 'catchbox.dart';

class Catchbox_detail2 extends StatefulWidget {
  final QueryDocumentSnapshot query;
  final QueryDocumentSnapshot query2;

  Catchbox_detail2({required this.query, required this.query2});

  @override
  State<Catchbox_detail2> createState() =>
      _Catchbox_detail2State(query: query, query2: query2);
}

class _Catchbox_detail2State extends State<Catchbox_detail2> {

  final QueryDocumentSnapshot query;
  final QueryDocumentSnapshot query2;
  _Catchbox_detail2State({required this.query, required this.query2});

  DateRangePickerController _dataPickerController = DateRangePickerController();

  final _valueList = ['오토바이', '퀵보드', '자전거'];
  String? _selectedValue;
  bool pressed = true;
  String _dateCount = '';
  String _selectedDate = '';
  String _rangeCount = '';
  String _range1 = '';
  //String _range2 = '';
  List<String> num_list = [];
  List<String> place_list = [];
  List<bool> _checks = List.generate(1000, (_) => false);
  List<String> _checks_url = List.generate(1000, (_) => '');

  // 1
  String _selectDate = '날짜';
  Color _selectDateColor = Color(0XFFF3F4F5);
  Color _selectDateTextColor = Color(0xFF9FA5B2);
  double _selectDateSize = 67.2;
  var _selectDateIcon = true;

  // 2
  String _selectPlace = '장소';
  Color _selectPlaceColor = Color(0XFFF3F4F5);
  Color _selectPlaceTextColor = Color(0xFF9FA5B2);
  double _selectPlaceSize = 67.2;
  var _selectPlaceIcon = true;

  // 3
  String _selectCheck = '선택';
  Color _selectCheckColor = Color(0XFFF3F4F5);
  Color _selectCheckTextColor = Color(0xFF9FA5B2);
  double _selectCheckSize = 67.2;
  var _selectCheckIcon = true;

  Stream<QuerySnapshot> stream_ordering() {
    print("range1=");
    print(num_list);
    if (_selectPlace != '장소') {
      return FirebaseFirestore.instance
          .collection('category')
          .doc('1234@handong.ac.kr')
          .collection(query['category'])
          .doc('place')
          .collection('place_url')
          .where('place', whereIn: place_list)
          .snapshots();
    }
    if (_range1 != '') {
      return FirebaseFirestore.instance
          .collection('category')
          .doc('1234@handong.ac.kr')
          .collection(query['category'])
          .doc('date')
          .collection('date')
          .where('time', isEqualTo: _range1)
          .snapshots();
    }
    // if(num_list.isNotEmpty){
    //   print(num_list);
    //   return FirebaseFirestore.instance.collection('category').doc('user1').collection(query['category']).doc('date').collection('date').where('time', whereIn: num_list).snapshots();
    // }
    return FirebaseFirestore.instance
        .collection('category')
        .doc('1234@handong.ac.kr')
        .collection(query['category'])
        // .doc('date')
        // .collection('date')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Color? bgColorBottomNavigationBar;
    Color? iconColor;
    int _selectedIndex = 2;
    void _onItemTapped(int index) {

      if(index!=2){
        setState(() {
          _selectedIndex = index;
          print(_selectedIndex);

          selectedIndex0=_selectedIndex;

        });

        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return MainHomePage();
            }));

      }


    }

    final List<Widget> _widgetOptions = <Widget>[
      projectPage(),
      HomePage(),
      Catchbox(),
      MYPage(),
    ];
    TextTheme textTheme = Theme.of(context).textTheme;

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          //List<int> days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
          //_range1 = '${DateFormat('dd/MM/yyyy').format(args.value.Date)}';
          //_range2 = '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
          // I tried to use whereIn(), but only 10 elements are available.
          // for(int i = int.parse(_range1.substring(3,5)); i<= int.parse(_range2.substring(3,5)); i++){
          //   if(i == int.parse(_range1.substring(3,5)))
          //     for(int j = int.parse(_range1.substring(0,2)); j < days[i]; j++){
          //       String temp = (j.toString()) + (i.toString()) + _range1.substring(5,8);
          //       num_list.add(temp);
          //     }
          //   if(i == _range2.substring(3,5))
          //     for(int j = 1; j <= int.parse(_range2.substring(0,2)); j++){
          //       String temp = j.toString() + i.toString() + _range1.substring(5,8);
          //       num_list.add(temp);
          //     }
          //   else
          //     for(int j = 1; j <= days[i]; j++){
          //       String temp = j.toString() + i.toString() + _range1.substring(4,8);
          //       num_list.add(temp);
          //     }
          //   print(i);
          // }
          //print(num_list);
          //print(args.value.startDate - args.value.endDate);
        } else if (args.value is DateTime) {
          _selectedDate = args.value.toString();
          _range1 = '${DateFormat('dd/MM/yyyy').format(args.value)}';
        } else if (args.value is List<DateTime>) {
          _dateCount = args.value.length.toString();
        } else {
          _rangeCount = args.value.length.toString();
        }
      });
    }

    return Scaffold(
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
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(100),
        child:AppBar(
         // toolbarHeight: size.width*0.2,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                query['category'],
                //style: titleMediumStyle(color: Colors.black),
              ),
              Text("dsd"),
              Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //1
                        SizedBox(width: 23),
                        InkWell(
                          onTap: () {
                            if (_selectDateIcon)
                              setState(() {
                                _selectPlace = '장소';
                                _selectPlaceIcon = true;
                                _selectPlaceTextColor = Color(0xFF9FA5B2);
                                _selectPlaceColor = Color(0XFFF3F4F5);
                                _selectDateColor = Color(0XFFF3F4F5)!;
                                _selectDateTextColor = Colors.white;
                              });
                            if (_selectDateIcon)
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0))),
                                    insetPadding: EdgeInsets.only(top: 350),
                                    content: Container(
                                        height: 420,
                                        width: 360,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 30),
                                            SfDateRangePicker(
                                              controller: _dataPickerController,
                                              onSelectionChanged: _onSelectionChanged,
                                              //selectionMode: DateRangePickerSelectionMode.range,
                                            ),
                                            //SizedBox(height: 30.h),
                                            Container(
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 208),
                                                    TextButton(
                                                        child: Text('취소'),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                          setState(() {
                                                            _selectDateColor =
                                                                Color(0XFFF3F4F5);
                                                            _selectDateTextColor =
                                                                Color(0xFF9FA5B2);
                                                            _range1 = '';
                                                            //_range2 = '';
                                                            _dataPickerController
                                                                .selectedRanges = null;
                                                          });
                                                        },
                                                        style: TextButton.styleFrom(
                                                            padding: EdgeInsets.zero,
                                                            minimumSize: Size(50, 30),
                                                            tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                            alignment:
                                                            Alignment.centerLeft)),
                                                    SizedBox(width: 32),
                                                    TextButton(
                                                        child: Text('ㄴㄴ'),
                                                        onPressed: () {
                                                          setState(() {
                                                            _selectDateColor =
                                                            Color(0XFFF3F4F5)!;
                                                            _selectDateTextColor =
                                                                Colors.white;
                                                            _selectDate = _range1
                                                                .substring(8, 10) +
                                                                '.' +
                                                                _range1.substring(3, 5) +
                                                                '.' +
                                                                _range1.substring(0, 2);
                                                            _selectDateSize = 80;
                                                            _selectDateIcon = false;
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        style: TextButton.styleFrom(
                                                            padding: EdgeInsets.zero,
                                                            minimumSize: Size(50, 30),
                                                            tapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                            alignment:
                                                            Alignment.centerLeft))
                                                  ],
                                                ))
                                          ],
                                        )),
                                  );
                                },
                              );
                            else
                              setState(() {
                                _selectDateIcon = true;
                                _selectDate = '날짜';
                                _selectDateColor = Color(0XFFF3F4F5);
                                _selectDateTextColor = Color(0xFF9FA5B2);
                                _selectDateSize = 67.2;
                                _range1 = '';
                                //_range2 = '';
                              });
                          },
                          //1-1
                          child: Container(
                              width: _selectDateSize,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: _selectDateColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _selectDate,
                                    style: TextStyle(
                                      color: _selectDateTextColor,
                                    ),
                                  ),
                                  Icon(
                                      _selectDateIcon
                                          ? Icons.keyboard_arrow_down_outlined
                                          : Icons.clear_outlined,
                                      color: _selectDateTextColor),
                                ],
                              )),
                        ),
                        SizedBox(width: 10),

                        //2
                        InkWell(
                          onTap: () async {
                            setState(() {
                              //var respectsQuery = FirebaseFirestore.instance.collection('category').doc('user1').collection(query['category']).doc('place').collection('place'),

                              _selectDateIcon = true;
                              _selectDate = '날짜';
                              _selectDateColor = Color(0XFFF3F4F5);
                              _selectDateTextColor = Color(0xFF9FA5B2);
                              _selectDateSize = 67.2;
                              _range1 = '';
                              _selectPlaceColor = Color(0XFFF3F4F5)!;
                              _selectPlaceTextColor = Colors.white;
                              place_list = [];
                            });

                            if (_selectPlaceIcon)
                              showModalBottomSheet<void>(
                                context: context,
                                enableDrag: true,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0))),
                                builder: (BuildContext context) {
                                  return Center(
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0))),
                                      insetPadding: EdgeInsets.only(top: 519),
                                      content: Container(
                                          height: 244,
                                          width: 360,
                                          child: Column(
                                            children: [
                                              StreamBuilder<QuerySnapshot>(
                                                  stream: FirebaseFirestore.instance
                                                      .collection('category')
                                                      .doc(FirebaseAuth.instance
                                                      .currentUser!.email)
                                                      .collection(query['category'])
                                                      .doc('place')
                                                      .collection('place')
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      print(
                                                          snapshot.data!.docs.length);
                                                      if (snapshot.data != null) {
                                                        return GridView.builder(
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            childAspectRatio: 5 / 3,
                                                          ),
                                                          itemCount: snapshot
                                                              .data!.docs.length,
                                                          padding:
                                                          EdgeInsets.all(2.0),
                                                          itemBuilder:
                                                              (BuildContext context,
                                                              int index) {
                                                            QueryDocumentSnapshot x =
                                                            snapshot.data!
                                                                .docs[index];
                                                            return ListView(
                                                                children: [
                                                                  InkWell(
                                                                    child: Container(
                                                                        margin: EdgeInsets
                                                                            .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                        width: 67.2,
                                                                        height: 30,
                                                                        decoration: BoxDecoration(
                                                                            color: x[
                                                                            'choose']
                                                                                ? Color(
                                                                                0XFFF3F4F5)
                                                                                : Color(
                                                                                0xFFF3F4F5),
                                                                            borderRadius:
                                                                            BorderRadius.circular(
                                                                                20.0)),
                                                                        child: Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            Text(
                                                                                x['place'] +
                                                                                    '   ',
                                                                                style:
                                                                                TextStyle(color: x['choose'] ? Colors.white : Colors.black)),
                                                                            // Text(
                                                                            //     x['count'].toString(),
                                                                            //     style: TextStyle(color : x['choose']? Colors.white: Colors.black)
                                                                            // ),
                                                                          ],
                                                                        )),
                                                                    onTap: () {
                                                                      if (x[
                                                                      'choose']) {
                                                                        print(x[
                                                                        'choose']);
                                                                        setState(() {
                                                                          place_list.removeWhere(
                                                                                  (item) =>
                                                                              item ==
                                                                                  x['place']);
                                                                        });
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            'category')
                                                                            .doc(FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .email)
                                                                            .collection(
                                                                            query[
                                                                            'category'])
                                                                            .doc(
                                                                            'place')
                                                                            .collection(
                                                                            'place')
                                                                            .doc(x[
                                                                        'place'])
                                                                            .update({
                                                                          'choose':
                                                                          false
                                                                        });
                                                                      } else {
                                                                        setState(() {
                                                                          place_list
                                                                              .add(x[
                                                                          'place']);
                                                                        });
                                                                        FirebaseFirestore
                                                                            .instance
                                                                            .collection(
                                                                            'category')
                                                                            .doc(FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .email)
                                                                            .collection(
                                                                            query[
                                                                            'category'])
                                                                            .doc(
                                                                            'place')
                                                                            .collection(
                                                                            'place')
                                                                            .doc(x[
                                                                        'place'])
                                                                            .update({
                                                                          'choose':
                                                                          true
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ]);
                                                          },
                                                        );
                                                      } else {
                                                        return Container(
                                                            child: Center(
                                                                child: Text(
                                                                  '사진 없음.',
                                                                  style: TextStyle(
                                                                      fontSize: 20.0,
                                                                      color: Colors.grey),
                                                                  textAlign: TextAlign.center,
                                                                )));
                                                      }
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  }),
                                              Container(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: 208),
                                                      TextButton(
                                                          child: Text('취소'),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            setState(() {
                                                              _selectPlaceColor =
                                                                  Color(0XFFF3F4F5);
                                                              _selectPlaceTextColor =
                                                                  Color(0xFF9FA5B2);
                                                            });
                                                          },
                                                          style: TextButton.styleFrom(
                                                              padding: EdgeInsets.zero,
                                                              minimumSize: Size(50, 30),
                                                              tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                              alignment:
                                                              Alignment.centerLeft)),
                                                      SizedBox(width: 32),
                                                      TextButton(
                                                          child: Text('확인'),
                                                          onPressed: () {
                                                            print("place_list------->");
                                                            print(place_list);
                                                            setState(() {
                                                              _selectPlaceIcon = false;
                                                              _selectPlaceColor =
                                                                  Color(0XFFF3F4F5);
                                                              _selectPlaceTextColor =
                                                                  Colors.white;
                                                              if (place_list.isEmpty) {
                                                                _selectPlace = '장소';
                                                              } else
                                                                _selectPlace =
                                                                place_list[0];
                                                            });
                                                            Navigator.pop(context);
                                                          },
                                                          style: TextButton.styleFrom(
                                                              padding: EdgeInsets.zero,
                                                              minimumSize: Size(50, 30),
                                                              tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                              alignment:
                                                              Alignment.centerLeft))
                                                    ],
                                                  ))
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              );
                            else
                              setState(() {
                                _selectPlaceIcon = true;
                                _selectPlace = '장소';
                                _selectPlaceColor = Color(0XFFF3F4F5);
                                _selectPlaceTextColor = Color(0xFF9FA5B2);
                              });
                          },
                          child: Container(
                              width: 67.2,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: _selectPlaceColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _selectPlace,
                                    style: TextStyle(
                                      color: _selectPlaceTextColor,
                                    ),
                                  ),
                                  Icon(
                                      _selectPlaceIcon
                                          ? Icons.keyboard_arrow_down_outlined
                                          : Icons.clear_outlined,
                                      color: _selectPlaceTextColor),
                                ],
                              )),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          child: Container(
                              width: 102.2,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF3F4F5),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('미디어 형식',
                                      style: TextStyle(color: Color(0xFF9FA5B2))),
                                  Icon(Icons.keyboard_arrow_down_outlined,
                                      color: Color(0xFF9FA5B2))
                                ],
                              )),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          actions: <Widget>[
            pressed == true
                ? TextButton(
              onPressed: () async {
                for (int i = 0; i < 1000; i++) {
                  if (_checks[i]) {
                    try {
                      await FirebaseFirestore.instance
                          .collection("project_url")
                          .doc(query2['id'])
                          .collection(query2['id'])
                          .doc()
                          .set({
                        "project": query2['id'],
                        "category": query['category'],
                        "url": _checks_url[i],
                        "user": FirebaseAuth.instance.currentUser!.email,
                      });
                    } catch (e) {
                      print(e);
                    }
                    //_checks_url[i]
                  }
                }
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return uploadCheck();
                    }));

                // await Future.delayed(Duration(seconds: 3));
                //
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return MainHomePage();
                // }));
              },
              child: Text('올리기', style: TextStyle(color: Colors.black)),
            )
                : Container(),
          ],
        ),
      ),


      body: Container(
          // child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //1
                    SizedBox(width: 23),
                    InkWell(
                      onTap: () {
                        if (_selectDateIcon)
                          setState(() {
                            _selectPlace = '장소';
                            _selectPlaceIcon = true;
                            _selectPlaceTextColor = Color(0xFF9FA5B2);
                            _selectPlaceColor = Color(0XFFF3F4F5);
                            _selectDateColor = Color(0XFFF3F4F5)!;
                            _selectDateTextColor = Colors.white;
                          });
                        if (_selectDateIcon)
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0))),
                                insetPadding: EdgeInsets.only(top: 350),
                                content: Container(
                                    height: 420,
                                    width: 360,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30),
                                        SfDateRangePicker(
                                          controller: _dataPickerController,
                                          onSelectionChanged:
                                              _onSelectionChanged,
                                          //selectionMode: DateRangePickerSelectionMode.range,
                                        ),
                                        //SizedBox(height: 30.h),
                                        Container(
                                            child: Row(
                                          children: [
                                            SizedBox(width: 208),
                                            TextButton(
                                                child: Text('취소'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _selectDateColor =
                                                        Color(0XFFF3F4F5);
                                                    _selectDateTextColor =
                                                        Color(0xFF9FA5B2);
                                                    _range1 = '';
                                                    //_range2 = '';
                                                    _dataPickerController
                                                        .selectedRanges = null;
                                                  });
                                                },
                                                style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(50, 30),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    alignment:
                                                        Alignment.centerLeft)),
                                            SizedBox(width: 32),
                                            TextButton(
                                                child: Text('확인'),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectDateColor =
                                                        Color(0XFFF3F4F5)!;
                                                    _selectDateTextColor =
                                                        Colors.white;
                                                    _selectDate = _range1
                                                            .substring(8, 10) +
                                                        '.' +
                                                        _range1.substring(
                                                            3, 5) +
                                                        '.' +
                                                        _range1.substring(0, 2);
                                                    _selectDateSize = 80;
                                                    _selectDateIcon = false;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(50, 30),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    alignment:
                                                        Alignment.centerLeft))
                                          ],
                                        ))
                                      ],
                                    )),
                              );
                            },
                          );
                        else
                          setState(() {
                            _selectDateIcon = true;
                            _selectDate = '날짜';
                            _selectDateColor = Color(0XFFF3F4F5);
                            _selectDateTextColor = Color(0xFF9FA5B2);
                            _selectDateSize = 67.2;
                            _range1 = '';
                            //_range2 = '';
                          });
                      },
                      //1-1
                      child: Container(
                          width: _selectDateSize,
                          height: 24,
                          decoration: BoxDecoration(
                              color: _selectDateColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _selectDate,
                                style: TextStyle(
                                  color: _selectDateTextColor,
                                ),
                              ),
                              Icon(
                                  _selectDateIcon
                                      ? Icons.keyboard_arrow_down_outlined
                                      : Icons.clear_outlined,
                                  color: _selectDateTextColor),
                            ],
                          )),
                    ),
                    SizedBox(width: 10),

                    //2
                    InkWell(
                      onTap: () async {
                        setState(() {
                          //var respectsQuery = FirebaseFirestore.instance.collection('category').doc('user1').collection(query['category']).doc('place').collection('place'),

                          _selectDateIcon = true;
                          _selectDate = '날짜';
                          _selectDateColor = Color(0XFFF3F4F5);
                          _selectDateTextColor = Color(0xFF9FA5B2);
                          _selectDateSize = 67.2;
                          _range1 = '';
                          _selectPlaceColor = Color(0XFFF3F4F5)!;
                          _selectPlaceTextColor = Colors.white;
                          place_list = [];
                        });

                        if (_selectPlaceIcon)
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0))),
                                insetPadding: EdgeInsets.only(top: 519),
                                content: Container(
                                    height: 244,
                                    width: 360,
                                    child: Column(
                                      children: [
                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('category')
                                                .doc(FirebaseAuth.instance
                                                    .currentUser!.email)
                                                .collection(query['category'])
                                                .doc('place')
                                                .collection('place')
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                print(
                                                    snapshot.data!.docs.length);
                                                if (snapshot.data != null) {
                                                  return GridView.builder(
                                                    shrinkWrap: true,
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio: 5 / 2,
                                                    ),
                                                    itemCount: snapshot
                                                        .data!.docs.length,
                                                    padding:
                                                        EdgeInsets.all(2.0),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      QueryDocumentSnapshot x =
                                                          snapshot.data!
                                                              .docs[index];
                                                      return ListView(
                                                          children: [
                                                            InkWell(
                                                              child: Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          0,
                                                                          10,
                                                                          0),
                                                                  width: 67.2,
                                                                  height: 30,
                                                                  decoration: BoxDecoration(
                                                                      color: x[
                                                                              'choose']
                                                                          ? Color(
                                                                              0XFFF3F4F5)
                                                                          : Color(
                                                                              0xFFF3F4F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0)),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                          x['place'] +
                                                                              '   ',
                                                                          style:
                                                                              TextStyle(color: x['choose'] ? Colors.white : Colors.black)),
                                                                      // Text(
                                                                      //     x['count'].toString(),
                                                                      //     style: TextStyle(color : x['choose']? Colors.white: Colors.black)
                                                                      // ),
                                                                    ],
                                                                  )),
                                                              onTap: () {
                                                                if (x[
                                                                    'choose']) {
                                                                  print(x[
                                                                      'choose']);
                                                                  setState(() {
                                                                    place_list.removeWhere(
                                                                        (item) =>
                                                                            item ==
                                                                            x['place']);
                                                                  });
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'category')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .email)
                                                                      .collection(
                                                                          query[
                                                                              'category'])
                                                                      .doc(
                                                                          'place')
                                                                      .collection(
                                                                          'place')
                                                                      .doc(x[
                                                                          'place'])
                                                                      .update({
                                                                    'choose':
                                                                        false
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    place_list
                                                                        .add(x[
                                                                            'place']);
                                                                  });
                                                                  FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'category')
                                                                      .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .email)
                                                                      .collection(
                                                                          query[
                                                                              'category'])
                                                                      .doc(
                                                                          'place')
                                                                      .collection(
                                                                          'place')
                                                                      .doc(x[
                                                                          'place'])
                                                                      .update({
                                                                    'choose':
                                                                        true
                                                                  });
                                                                }
                                                              },
                                                            ),
                                                          ]);
                                                    },
                                                  );
                                                } else {
                                                  return Container(
                                                      child: Center(
                                                          child: Text(
                                                    '사진 없음.',
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.grey),
                                                    textAlign: TextAlign.center,
                                                  )));
                                                }
                                              } else {
                                                return CircularProgressIndicator();
                                              }
                                            }),
                                        Container(
                                            child: Row(
                                          children: [
                                            SizedBox(width: 208),
                                            TextButton(
                                                child: Text('취소'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  setState(() {
                                                    _selectPlaceColor =
                                                        Color(0XFFF3F4F5);
                                                    _selectPlaceTextColor =
                                                        Color(0xFF9FA5B2);
                                                  });
                                                },
                                                style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(50, 30),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    alignment:
                                                        Alignment.centerLeft)),
                                            SizedBox(width: 32),
                                            TextButton(
                                                child: Text('확인'),
                                                onPressed: () {
                                                  print("place_list------->");
                                                  print(place_list);
                                                  setState(() {
                                                    _selectPlaceIcon = false;
                                                    _selectPlaceColor =
                                                        Color(0XFFF3F4F5);
                                                    _selectPlaceTextColor =
                                                        Colors.white;
                                                    if (place_list.isEmpty) {
                                                      _selectPlace = '장소';
                                                    } else
                                                      _selectPlace =
                                                          place_list[0];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                    padding: EdgeInsets.zero,
                                                    minimumSize: Size(50, 30),
                                                    tapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    alignment:
                                                        Alignment.centerLeft))
                                          ],
                                        ))
                                      ],
                                    )),
                              );
                            },
                          );
                        else
                          setState(() {
                            _selectPlaceIcon = true;
                            _selectPlace = '장소';
                            _selectPlaceColor = Color(0XFFF3F4F5);
                            _selectPlaceTextColor = Color(0xFF9FA5B2);
                          });
                      },
                      child: Container(
                          width: 67.2,
                          height: 24,
                          decoration: BoxDecoration(
                              color: _selectPlaceColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _selectPlace,
                                style: TextStyle(
                                  color: _selectPlaceTextColor,
                                ),
                              ),
                              Icon(
                                  _selectPlaceIcon
                                      ? Icons.keyboard_arrow_down_outlined
                                      : Icons.clear_outlined,
                                  color: _selectPlaceTextColor),
                            ],
                          )),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      child: Container(
                          width: 102.2,
                          height: 24,
                          decoration: BoxDecoration(
                              color: Color(0xFFF3F4F5),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('미디어 형식',
                                  style: TextStyle(color: Color(0xFF9FA5B2))),
                              Icon(Icons.keyboard_arrow_down_outlined,
                                  color: Color(0xFF9FA5B2))
                            ],
                          )),
                    ),
                  ],
                ),
              )),
              // TextButton(
              //   onPressed: () {
              //     print(_checks);
              //     setState(() {
              //       if(_selectCheckIcon){
              //         pressed = true;
              //         _selectCheck = '취소';
              //         _selectCheckColor = Color(0XFFF3F4F5);
              //         _selectCheckTextColor = Colors.white;
              //         _selectCheckIcon = false;
              //       }
              //       else{
              //         pressed = false;
              //         _selectCheckColor = Color(0XFFF3F4F5);
              //         _selectCheck = '선택';
              //         _selectCheckTextColor = Color(0xFF9FA5B2);
              //         _selectCheckIcon = true;
              //         _checks = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
              //         _checks_url = ['', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,'', '', '', '', '', '', '', '', '', '' ,''];
              //       }
              //     });
              //   },
              //   child: Container(
              //     width: 47,
              //     height: 24,
              //     decoration: BoxDecoration(
              //         color: _selectCheckColor,
              //         borderRadius: BorderRadius.circular(10.0)
              //     ),
              //     //padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              //     child: Center(child: Text(_selectCheck, style: TextStyle(color: _selectCheckTextColor))),
              //   ),
              // )
            ],
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: stream_ordering(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.all(1.0),
                            itemBuilder: (BuildContext context, int index) {
                              QueryDocumentSnapshot x =
                                  snapshot.data!.docs[index];
                              return InkWell(
                                onLongPress: () {
                                  setState(() {
                                    pressed = true;
                                  });
                                },
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height: 119.04,
                                      width: 118.08,
                                      child: Card(
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(15.0),
                                          // ),
                                          margin:
                                              EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          clipBehavior: Clip.antiAlias,
                                          child: Transform.rotate(
                                            angle: (query['category'] ==
                                                        'kickboard' ||
                                                    query['category'] ==
                                                        'traffic light')
                                                ? 0
                                                : 90 * math.pi / 180,
                                            child: Image.network(
                                              x['url'],
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ),
                                    //Image.network(x['url'], fit: BoxFit.cover),
                                    if (pressed == true)
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Checkbox(
                                          value: _checks[index],
                                          onChanged: (newValue) {
                                            setState(() {
                                              _checks[index] = newValue!;
                                              _checks_url[index] = x['url'];
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          checkColor: Colors.white,
                                          activeColor: Color(0XFF007AFF),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Container(
                              child: Center(
                                  child: Text(
                            'Es wurden noch keine Fotos im Chat gepostet.',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey),
                            textAlign: TextAlign.center,
                          )));
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    })),
          )),
        ],
        //),
      )),
    );
  }
}
