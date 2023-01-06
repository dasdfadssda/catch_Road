import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../utils/app_text_styles.dart';
import '../mainHome.dart';

class Catchbox_detail extends StatefulWidget {
  final QueryDocumentSnapshot query;

  Catchbox_detail({required this.query});

  @override
  State<Catchbox_detail> createState() => _Catchbox_detailState(query: query);
}

class _Catchbox_detailState extends State<Catchbox_detail> {
  final QueryDocumentSnapshot query;

  _Catchbox_detailState({required this.query});

  DateRangePickerController _dataPickerController = DateRangePickerController();

  final _valueList = ['오토바이', '퀵보드', '자전거'];
  String? _selectedValue;
  bool pressed = false;
  String _dateCount = '';
  String _selectedDate = '';
  String _rangeCount = '';
  String _range1 = '';
  String _range2 = '';
  String _month_0 = '';
  String _day_0 = '';
  int count = 0;

  //String _range2 = '';
  List<String> num_list = [];
  List<String> place_list = [];
  List<String> placenamelist=['장성동','흥해읍','양덕동'];//,'장량동','환호동','두호동','우현동','창포동','죽도동'];
  List<bool> _checks = List.generate(1000, (_) => false);
  List<String> _checks_url = List.generate(1000, (_) => '');
  List<String> _checks_docs = List.generate(1000, (_) => '');

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

  bool jangrangdong=false;

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
          // .doc('place')
          // .collection('place_url')
          .where('location', whereIn: place_list)
          .snapshots();
    }
    if (_range1 != '') {
      return FirebaseFirestore.instance
          .collection('category')
          .doc('1234@handong.ac.kr')
          .collection(query['category'])
          .where('time', whereIn: num_list)
          .snapshots();
    }

    return FirebaseFirestore.instance
        .collection('category')
        .doc('1234@handong.ac.kr')
        .collection(query['category'])
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    int _selectedIndex = 2;
    Color? bgColorBottomNavigationBar;
    Color? iconColor;

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      setState(() {
        if (args.value is PickerDateRange) {
          List<int> days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
          _range1 = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
          _range2 = '${DateFormat('dd/MM/yyyy').format(args.value.endDate)}';
          //I tried to use whereIn(), but only 10 elements are available.
          print("here!!!!");
          print(_range1);
          print(_range2);
          print(_range1.substring(3,5));
          count = 0;

          for(int i = int.parse(_range1.substring(3,5)); i <= int.parse(_range2.substring(3,5)); i++){
              if(int.parse(_range2.substring(3,5)) == int.parse(_range1.substring(3,5))){
                if(count < 10)
                  for(int j = int.parse(_range1.substring(0,2)); j <= int.parse(_range2.substring(0,2)); j++){
                    //format 맞추기 위해서
                    if(j.toString().length == 1){
                      _month_0 = '0' + j.toString();
                    }
                    else _month_0 = j.toString();

                    if(j.toString().length == 1){
                      _day_0 = '0' + i.toString();
                    }
                    else _day_0 = i.toString();
                    String temp = _month_0 + '/'+  _day_0 + '/' + _range1.substring(6,10);
                    num_list.add(temp);
                    count ++;
                    if(count == 10) break;
                  }
              }

              else{
                if(count < 10){
                  if(i == int.parse(_range1.substring(3,5)))
                    for(int j = int.parse(_range1.substring(0,2)); j <= days[i]; j++){
                      //format 맞추기 위해서
                      if(j.toString().length == 1){
                        _month_0 = '0' + j.toString();
                      }
                      else _month_0 = j.toString();

                      if(j.toString().length == 1){
                        _day_0 = '0' + i.toString();
                      }
                      else _day_0 = i.toString();
                      String temp = _month_0 + '/'+  _day_0 + '/' + _range1.substring(6,10);
                      num_list.add(temp);
                      count ++;
                      if(count == 10) break;
                    }
                  if(i == int.parse(_range2.substring(3,5)))
                    for(int j = 1; j <= int.parse(_range2.substring(0,2)); j++){
                      //format 맞추기 위해서
                      if(j.toString().length == 1){
                        _month_0 = '0' + j.toString();
                      }
                      else _month_0 = j.toString();

                      if(j.toString().length == 1){
                        _day_0 = '0' + i.toString();
                      }
                      else _day_0 = i.toString();
                      String temp = _month_0 + '/'+  _day_0 + '/' + _range1.substring(6,10);
                      num_list.add(temp);
                      count ++;
                      if(count == 10) break;
                    }
                }
              }
              print(i);
            }

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

    void _onItemTapped(int index) {
      if (index != 2) {
        setState(() {
          _selectedIndex = index;
          print(_selectedIndex);
          selectedIndex0 = _selectedIndex;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainHomePage();
        }));
      }
    }

    return Scaffold(
      appBar: AppBar(
        // 하람 appbar round
        toolbarHeight: 130,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            query['category'],
                            style: titleMediumStyle(color: Colors.black),
                          ),
                        ]
                    ),
                  ),
                ),

                // Container(
                //   width: (size.width - 35) / 3,
                //   child: Align(
                //     alignment: Alignment.centerRight,
                //     child: TextButton(
                //       onPressed: () async {
                //         // await Future.delayed(Duration(seconds: 3));
                //         //
                //         // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //         //   return MainHomePage();
                //         // }));
                //       },
                //       child: Text('업로드', style: TextStyle(color: Colors.white)),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                    child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //1. 날짜칩
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if (_selectDateIcon)
                            setState(() {
                              num_list = [];
                              _selectPlace = '장소';
                              _selectPlaceIcon = true;
                              _selectPlaceTextColor = Color(0xFF9FA5B2);
                              _selectPlaceColor = Color(0XFFF3F4F5);
                              _selectDateColor = Colors.blue; // primary[40]!;
                              _selectDateTextColor = Colors.white;
                            });
                          if (_selectDateIcon)
                            // ignore: curly_braces_in_flow_control_structures
                            showModalBottomSheet<void>(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0))),
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 1000,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 40.0, left: 40, right: 40),
                                        child: SfDateRangePicker(
                                          controller: _dataPickerController,
                                          onSelectionChanged:
                                              _onSelectionChanged,
                                          selectionMode: DateRangePickerSelectionMode.range,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 50.0, right: 30),
                                        child: Container(
                                            child: Row(
                                          children: [
                                            TextButton(
                                                child: Text(
                                                  '취소',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          159, 165, 178, 1)),
                                                ),
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
                                            Spacer(),
                                            TextButton(
                                                child: Text('확인'),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectDateColor = Colors.blue; //  primary[40]!;
                                                    _selectDateTextColor = Colors.white;
                                                    _selectDate = _range1.substring(8, 10) + '.' + _range1.substring(3, 5) +
                                                        '.' +
                                                        _range1.substring(0, 2);
                                                    _selectDateSize = 80;
                                                    _selectDateIcon = false;
                                                    print("range $_range1");
                                                    print("date:$_selectDate");
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
                                        )),
                                      )
                                    ],
                                  ),
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
                        //1-1 //날짜 칩
                        child: Container(
                            width: _selectDateSize,
                            height: 30,
                            decoration: BoxDecoration(
                                color: _selectDateColor,
                                borderRadius: BorderRadius.circular(100.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _selectDate,
                                  style: TextStyle(
                                      color: _selectDateTextColor,
                                      fontSize: 12),
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
                      // 2. 장소칩
                      InkWell(
                        onTap: () async {
                          setState(() {
                            //var respectsQuery = FirebaseFirestore.instance.collection('category').doc('user1').collection(query['category']).doc('place').collection('place'),

                           //날짜 필터 초기화
                            _selectDateIcon = true;
                            _selectDate = '날짜';
                            _selectDateColor = Color(0XFFF3F4F5);
                            _selectDateTextColor = Color(0xFF9FA5B2);
                            _selectDateSize = 67.2;
                            _range1 = '';
                            _range2 = '';
                            num_list = [];

                            //장소 필터 on
                            _selectPlaceColor = Colors.blue; // primary[40]!;
                            _selectPlaceTextColor = Colors.white;
                            place_list = [];
                            _selectPlaceIcon=true;
                          });

                          if (_selectPlaceIcon)
                            showDialog(
                              context: context,
                              builder:(BuildContext context) {
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
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  setState(() {
                                                    place_list.add("장량동");
                                                    jangrangdong=!jangrangdong;
                                                  });
                                                },
                                                child:   Container(
                                                    width: size.width*0.236,
                                                    height: size.height*0.0375,
                                                    decoration: BoxDecoration(
                                                        color: !jangrangdong?Color(0xffF3F4F5):_selectPlaceColor,
                                                        borderRadius: BorderRadius.circular(100.0)),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          '장량동',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: !jangrangdong?Color(0xff9FA5B2):_selectPlaceTextColor,
                                                          ),
                                                        ),

                                                      ],
                                                    )),
                                              )
                                            ],
                                          ),



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
                                                          alignment: Alignment
                                                              .centerLeft)),
                                                  SizedBox(width:25),
                                                  TextButton(
                                                      child: Text('확인'),
                                                      onPressed: () {
                                                        print("place_list------->");
                                                        print(place_list);
                                                        setState(() {
                                                          _selectPlaceIcon = false;
                                                          _selectPlaceColor = Colors
                                                              .blue; //  primary[40]!;
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
                              }

                            );
                          else
                            setState(() {
                              _selectPlaceIcon = true;
                              _selectPlace = '장소';
                              _selectPlaceColor = Color(0XFFF3F4F5);
                              _selectPlaceTextColor = Color(0xFF9FA5B2);
                            });
                        },

                        //// 장소 칩
                        child: Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                                color: _selectPlaceColor,
                                borderRadius: BorderRadius.circular(100.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _selectPlace,//  _selectPlace,
                                  style: TextStyle(
                                    fontSize: 12,
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
                      Spacer(),
                      // 임시 delete
                      if(pressed == true)
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.lightBlue,
                          onPressed: (){
                            for(int i = 0; i< 1000; i++){
                              if(_checks_docs[i] != ''){
                                FirebaseFirestore.instance.collection('category').doc('1234@handong.ac.kr').collection(query['category']).doc(_checks_docs[i]).delete();
                              }
                            }
                            setState(() {
                              pressed = false;
                              _selectCheck = '선택';
                              _checks.fillRange(0, _checks.length-1,false);
                              _checks_url.fillRange(0, _checks_url.length-1,'');
                              _checks_docs.fillRange(0, _checks_docs.length-1,'');
                            });
                          },
                        ),
                      //선택,취소버튼
                      Container(
                        margin: EdgeInsets.zero,
                        width: (size.width - 170) / 3,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                print(_checks);
                                setState(() {
                                  if (_selectCheckIcon) {
                                    pressed = true;
                                    _selectCheck = '취소';
                                    _selectCheckColor = Colors.blue; // primary[40]!;
                                    _selectCheckTextColor = Color(0XFFF3F4F5);
                                    // _selectPlaceTextColor = Colors.red;
                                    _selectCheckIcon = false;
                                  } else {
                                    pressed = false;
                                    _selectCheckColor = Color(0XFFF3F4F5);
                                    _selectCheck = '선택';
                                    _selectCheckTextColor = Color(0xFF9FA5B2);
                                    _selectCheckIcon = true;
                                    _checks.fillRange(0, _checks.length-1,false);
                                    _checks_url.fillRange(0, _checks_url.length-1,'');
                                    _checks_docs.fillRange(0, _checks_docs.length-1,'');
                                  }
                                });
                              },
                              child: Text(
                                pressed ? "취소" : "선택",
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ],
        ),
        // actions: <Widget>[
        //   pressed==true?TextButton(
        //     onPressed: () async {
        //       // for(int i = 0; i < 1000; i++){
        //       //   if(_checks[i]){
        //       //     try {
        //       //       await FirebaseFirestore.instance
        //       //           .collection("project_url")
        //       //           .doc(query2['id'])
        //       //           .collection(query2['id'])
        //       //           .doc()
        //       //           .set({
        //       //         "project": query2['id'],
        //       //         "category": query['category'],
        //       //         "url": _checks_url[i],
        //       //         "user":"1234@handong.ac.kr",// FirebaseAuth.instance.currentUser!.email,
        //       //       });
        //       //     } catch (e) {
        //       //       print(e);
        //       //     }
        //       //     //_checks_url[i]
        //       //   }
        //       // }
        //
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return uploadCheck();
        //       }));
        //
        //       // await Future.delayed(Duration(seconds: 3));
        //       //
        //       // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //       //   return MainHomePage();
        //       // }));
        //
        //     },
        //     child: Text('업로드', style: TextStyle(color: Colors.blue)),
        //   ):Container(),
        // ],
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
      body: Container(
          // child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: stream_ordering(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          print(snapshot.data!.docs.length);
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.all(2.0),
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
                                              _checks_docs[index] = x.id;
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
                    })
                ),
          )),
        ],
      )),
    );
  }
}
