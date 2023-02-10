import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'dart:math' as math;
import 'package:extended_image/extended_image.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

int check_num = 0;
String start_date = "";
String end_date = "";
List<String> weekday = ["", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];


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
  List<String> _checks_docs = List.generate(1000, (_) => '');

  // 1
  String _selectDate = '날짜';
  Color _selectDateColor = Color(0XFFF3F4F5);
  Color _selectDateTextColor = Color(0xFF9FA5B2);
  double _selectDateSize = 67.2;
  var _selectDateIcon = true;

  // 2
  String _selectPlace = '장소';

  // 3
  String _selectCheck = '선택';
  Color _selectCheckColor = Color(0XFFF3F4F5);
  Color _selectCheckTextColor = Color(0xFF9FA5B2);
  double _selectCheckSize = 67.2;
  var _selectCheckIcon = true;

  dynamic tag ;
  Stream<QuerySnapshot> stream_ordering() {
    print("range1=");
    print(num_list);
    List<String> place=[];

    if(_selectPlace != '장소'&&_selectDate != '날짜'){
      Timestamp s_timestamp= Timestamp.fromDate(DateTime.parse(start_date.substring(0, 19)));
      Timestamp e_timestamp=Timestamp.fromDate(DateTime.parse(end_date.substring(0, 19)));
      return FirebaseFirestore.instance
          .collection('category')
          .doc("${FirebaseAuth.instance.currentUser!.email!}")
          .collection(query['category'])
          .where("time",isGreaterThan: s_timestamp)
          .where("time",isLessThan: e_timestamp)
          .orderBy('time', descending: true)//desencding ture : 최신순
          .snapshots();
    }

    if (_selectPlace != '장소') {
      place.add(_selectPlace);
      print("장소 핕터링 중 ${place}");
      return FirebaseFirestore.instance
          .collection('category')
          .doc('${FirebaseAuth.instance.currentUser!.email!}')
          .collection(query['category'])
          .where('location',isEqualTo:_selectPlace)
          .snapshots();
    }


    else if (_selectDate != '날짜') {
      print("날짜 필터링 중 $start_date  $end_date");
      Timestamp s_timestamp= Timestamp.fromDate(DateTime.parse(start_date.substring(0, 19)));
      Timestamp e_timestamp=Timestamp.fromDate(DateTime.parse(end_date.substring(0, 19)));
      return FirebaseFirestore.instance
          .collection('category')
          .doc("${FirebaseAuth.instance.currentUser!.email!}")
          .collection(query['category'])
          .where("time",isGreaterThan: s_timestamp)
          .where("time",isLessThan: e_timestamp)
          .orderBy('time', descending: true)//desencding ture : 최신순
          .snapshots();
    }
    else{
      return FirebaseFirestore.instance
          .collection('category')
          .doc("${FirebaseAuth.instance.currentUser!.email!}")
          .collection(query['category'])
          .orderBy('time', descending: true) //desencding ture : 최신순
          .snapshots();
    }

  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    String s_year = "";
    String s_month = "";
    String s_day = "";
    String s_day2 = "";

    String e_year = "";
    String e_month = "";
    String e_day = "";
    String e_day2 = "";

    DateTime s_date_datetime;
    DateTime e_date_datetime;


    List<String> options = ['서울특별시','부산광역시','인천광역시','대구광역시','대전광역시','광주광역시','울산광역시','세종특별자치시','고양시','과천시','광명시','광주시','구리시','군포시','포항시'];

    final DateRangePickerController _datecontroller = DateRangePickerController();


    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 0, blurRadius: 0.5),
          ],
        ),
        height: size.height * 0.14,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          //// 선택 눌렀을 때
          child: !pressed
              ? Text("")
              : Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.0225,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      //SizedBox(width: size.width * 0.4),
                      Text("$check_num 개의 사진이 선택됨",
                          style: labelMediumStyle(
                              color: Color.fromRGBO(26, 26, 26, 1))),
                      // Padding(
                      //   padding: EdgeInsets.only(left: size.width * 0.15),
                      //   child:  pressed==true?TextButton(
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
                      //     child: Text('올리기',  style: labelMediumStyle(
                      //         color: Color.fromRGBO(26, 26, 26, 1))),
                      //   ):Container(),
                      // ),
                      SizedBox(width: 10)
                    ]),
                  ],
                ),
        ),
      ),
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
              height: size.width * 0.02,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  width: (size.width - 35) / 3,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          check_num = 0;
                          Navigator.pop(context);
                        },
                        child: Text(
                          "취소", //pressed ? "취소" : "선택",
                          style: SubTitleStyle(color: Colors.grey),
                        )
                        ),
                  ),
                ),
                Container(
                    width: (size.width - 35) / 3,
                    child: Center(
                      child: Text(
                        query['category'],
                        style: titleMediumStyle(color: Colors.black),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.zero,
                  width: (size.width - 35) / 3,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text('업로드', style: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        print("사진 올리기");

                        //내가 올리는 이미지가 몇장인지 확인
                        int image_length=0;
                        for (int i = 0; i < 1000; i++) {
                          if (_checks[i]) {
                            image_length=image_length+1;
                          }
                        }

                      print("image_length: $image_length");

                        var urllist = query2['url'];
                        for (int i = 0; i < 1000; i++) {
                          if (_checks[i]) {
                            urllist.add(_checks_url[i]);
                          }
                        }

                        await FirebaseFirestore.instance
                            .collection('project')
                            .doc(query2['id'])
                            .update({'participate': 1, 'url': urllist});

                        //캐시 정보저장
                        await FirebaseFirestore.instance
                            .collection("user_cash")
                            .doc("${FirebaseAuth.instance.currentUser!.email!}").
                            collection("${FirebaseAuth.instance.currentUser!.email!}").
                        doc(Timestamp.fromDate(DateTime.now()).toString())
                            .set({
                          "project_title": query2['title'],
                          "image length":image_length,
                          "cash": query2['cash'],
                          "time": Timestamp.fromDate(DateTime.now()),
                        });

                        showModalBottomSheet<void>(
                          enableDrag: true,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                height: size.height * 0.475,
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                    SizedBox(
                                        height: 150,
                                        child: Image.asset(
                                            'assets/checkToFinish.gif')),
                                    SizedBox(
                                      height: size.height * 0.025,
                                    ),
                                    Text('사진이 업로드 되었습니다. '),
                                    SizedBox(height: size.height * 0.025),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              Size(307, 50)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            Color(0xff3A94EE),
                                            //_onTap3? primary[40] : onSecondaryColor,
                                          ),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          )),
                                        ),
                                        child: Text('확인',
                                            style: titleMediumStyle(
                                                color: Color(0xffFAFBFB))),
                                        onPressed: () {
                                          print("사진 올리기");
                                          print("올린 장수 $_checks_url");

                                          check_num = 0;
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        })
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      },

                    ), //:Container(),
                  ),
                ),
              ],
            ),
            // Center(
            //     child: Text(
            //       query['category'],
            //       style: titleMediumStyle(color: Colors.black),
            //     )),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                    child: Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //1. 날짜칩
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if(_selectDate=="날짜")
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context, StateSetter setState2) {
                                    return SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        child: Column(children: [
                                          Container(
                                            padding: EdgeInsets.fromLTRB(36, 46, 36, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text("시작", style: titleSmallStyle()),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    //2/5
                                                    Row(
                                                      children: [
                                                        Text(s_day,
                                                            style: headlineLargeStyle()
                                                                .copyWith(
                                                                color: primary[50])),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            //Text(start_date),
                                                            Text(
                                                                s_year == ""
                                                                    ? ""
                                                                    : "$s_year년 $s_month월",
                                                                style: labelMediumStyle()
                                                                    .copyWith(
                                                                    color:
                                                                    primary[50])),
                                                            Text(s_day2,
                                                                style: labelMediumStyle()
                                                                    .copyWith(
                                                                    color:
                                                                    primary[50])),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(
                                                      0, 0, 40, 0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text("종료",
                                                          style: titleSmallStyle()),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      //2/5
                                                      Row(
                                                        children: [
                                                          Text(e_day,
                                                              style: headlineLargeStyle()
                                                                  .copyWith(
                                                                  color:
                                                                  primary[50])),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                  e_year == ""
                                                                      ? ""
                                                                      : "$e_year년 $e_month월",
                                                                  style: labelMediumStyle()
                                                                      .copyWith(
                                                                      color: primary[
                                                                      50])),
                                                              Text(e_day2,
                                                                  style: labelMediumStyle()
                                                                      .copyWith(
                                                                      color: primary[
                                                                      50])),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(30, 36, 30, 0),
                                            child: Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width:
                                                  MediaQuery.of(context).size.width *
                                                      0.8,
                                                  child: SfDateRangePicker(
                                                    view: DateRangePickerView.month,
                                                    initialSelectedDate: DateTime.now(),
                                                    minDate: DateTime(2000),
                                                    maxDate: DateTime(2100),
                                                    selectionMode:
                                                    DateRangePickerSelectionMode
                                                        .range,
                                                    controller: _datecontroller,
                                                    onSelectionChanged:
                                                        (DateRangePickerSelectionChangedArgs
                                                    args) {
                                                      setState2(() {
                                                        setState(() {
                                                          if (args.value
                                                          is PickerDateRange) {
                                                            start_date = args
                                                                .value.startDate
                                                                .toString();

                                                            end_date =
                                                            args.value.endDate != null
                                                                ? args.value.endDate
                                                                .toString()
                                                                : start_date;
                                                          }

                                                          s_date_datetime = DateTime.parse(start_date.substring(0, 19));
                                                          e_date_datetime = DateTime.parse(end_date.substring(0, 19));

                                                          s_year = s_date_datetime.year
                                                              .toString();
                                                          s_month = s_date_datetime.month
                                                              .toString();
                                                          s_day = s_date_datetime.day
                                                              .toString();
                                                          s_day2 = weekday[s_date_datetime
                                                              .weekday
                                                              .toInt()];

                                                          e_year = e_date_datetime.year
                                                              .toString();
                                                          e_month = e_date_datetime.month
                                                              .toString();
                                                          e_day = e_date_datetime.day
                                                              .toString();
                                                          e_day2 = weekday[e_date_datetime
                                                              .weekday
                                                              .toInt()];

                                                          // print(s_date_datetime.weekday);
                                                          // print(e_date_datetime.weekday);
                                                          print(
                                                              "$s_year년 $s_month월 $s_day일 $s_day2");
                                                          print(
                                                              "$e_year년 $e_month월 $e_day일 $e_day2");
                                                        });
                                                      });
                                                    },
                                                  ),
                                                ),
                                                //SizedBox(height: 30),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextButton(
                                                  child: Text(
                                                    "취소",
                                                    style: buttonLargeStyle().copyWith(
                                                        color: Color(0XFF9FA5B2)),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {

                                                      _selectDate="날짜";
                                                    });

                                                  },
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    "확인",
                                                    style: buttonLargeStyle()
                                                        .copyWith(color: primary[50]),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectDate="${s_month}/${s_day}~${e_month}/${e_day}";
                                                      Navigator.pop(context);
                                                    });
                                                    //  });

                                                    print('pop');
                                                  },
                                                ),
                                                //background: #9FA5B2;
                                              ],
                                            ),
                                          ),
                                        ]));
                                  });
                                });
                          else{
                            print(_selectDate);
                            setState(() {
                              _selectDate="날짜";
                            });
                          }
                        },
                        //1-1 //날짜 칩
                        child: Container(
                            width: _selectDate=="날짜"?67.2:90,
                            height: 30,
                            decoration: BoxDecoration(
                                color:_selectDate=="날짜"?Color(0XFFF3F4F5):Colors.blue,
                                borderRadius: BorderRadius.circular(100.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _selectDate,
                                  style: TextStyle(
                                      color: _selectDate=="날짜"?Colors.grey:Colors.white,
                                      fontSize: 12),
                                ),
                                _selectDate=="날짜"?
                                Icon(
                                    _selectDateIcon
                                        ? Icons.keyboard_arrow_down_outlined
                                        : Icons.clear_outlined,
                                    color: _selectDateTextColor):Icon(
                                    Icons.clear_outlined,
                                    color:Colors.white),
                              ],
                            )),
                      ),

                      SizedBox(width: 10),
                      // 2. 장소칩
                      InkWell(
                        onTap: () async {

                          if(_selectPlace=="장소")
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState2) {
                                        return SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.45,
                                            child: Column(children: [
                                              Container(
                                                padding: EdgeInsets.all(size.width*0.001),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      child: ChipsChoice<String>.single(
                                                        choiceStyle: C2ChipStyle.filled(
                                                          color: Color(0xffF2F8FE),
                                                          foregroundColor: Colors.grey,
                                                          selectedStyle: const C2ChipStyle(
                                                            foregroundColor: Colors.white,
                                                            backgroundColor: Color(0xff3A94EE),
                                                            borderRadius: const BorderRadius.all(
                                                              Radius.circular(100),
                                                            ),
                                                          ),
                                                        ),
                                                        value: tag,
                                                        onChanged: (val) => setState2(() => tag = val),
                                                        choiceItems: C2Choice.listFrom<String, String>(
                                                          source: options,
                                                          value: (i, v) => v,
                                                          label: (i, v) => v,
                                                          tooltip: (i, v) => v,
                                                        ),
                                                        choiceCheckmark: true,
                                                        wrapped: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    TextButton(
                                                      child: Text(
                                                        "취소",
                                                        style: buttonLargeStyle()
                                                            .copyWith(color: Color(0XFF9FA5B2)),
                                                      ),
                                                      onPressed: () {
                                                        print(tag);
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                        "확인",
                                                        style: buttonLargeStyle()
                                                            .copyWith(color: primary[50]),
                                                      ),
                                                      onPressed: () {
                                                        setState2(() {
                                                          setState(() {
                                                            print(tag);
                                                            _selectPlace=tag.toString();
                                                            //objectSet = true;
                                                            Navigator.pop(context);
                                                          });
                                                        });
                                                      },
                                                    ),
                                                    //background: #9FA5B2;
                                                  ],
                                                ),
                                              ),
                                            ]));
                                      });
                                });

                          else {
                            setState(() {
                              _selectPlace="장소";
                            });
                          }
                        },

                        //// 장소 칩
                        child: Container(
                            width:_selectPlace=="장소"? 70:120,
                            height: 30,
                            decoration: BoxDecoration(
                                color: _selectPlace=="장소"?Color(0XFFF3F4F5):Colors.blue,
                                borderRadius: BorderRadius.circular(100.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _selectPlace,//  _selectPlace,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:  _selectPlace=="장소"?Colors.grey:Colors.white,
                                  ),
                                ),
                                _selectPlace=="장소"?
                                Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.grey): Icon(
                                    Icons.clear_outlined,
                                    color:Colors.white),//Icons.clear_outlined,
                              ],
                            )),
                      ),
                      Spacer(),
                      // 임시 delete

                      //선택,취소버튼
                      Container(
                        margin: EdgeInsets.zero,
                        width: (size.width - 170) / 3,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                              onPressed: () {
                                print(pressed);
                                print(_checks);

                                if(pressed==true){
                                  setState(() {
                                    pressed=false;
                                      _checks.fillRange(0, _checks.length-1,false);
                                      _checks_url.fillRange(0, _checks_url.length-1,'');
                                      _checks_docs.fillRange(0, _checks_docs.length-1,'');
                                  });
                                }
                                else if(pressed==false){
                                  setState(() {
                                      check_num=0;
                                      pressed = true;
                                      _selectCheck = '취소';
                                      _selectCheckColor = Colors.blue; // primary[40]!;
                                      _selectCheckTextColor = Color(0XFFF3F4F5);
                                      _selectCheckIcon = false;
                                  });
                                }
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
      ),
      body: Container(
          // child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Center(
                child: StreamBuilder<QuerySnapshot>(
                    stream: stream_ordering(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          List<dynamic> datalist=snapshot.data!.docs;
                          if(_selectDate!="날짜"&&_selectPlace!="장소"){
                            datalist.removeWhere((element) => element['location']!=_selectPlace);
                          }
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                            itemCount: datalist.length,
                            padding: EdgeInsets.all(2.0),
                            itemBuilder: (BuildContext context, int index) {
                              // print( snapshot.data!.docs[index]['location']);
                              QueryDocumentSnapshot x = datalist[index];
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
                                          margin:
                                          EdgeInsets.fromLTRB(5, 5, 5, 5),
                                          clipBehavior: Clip.antiAlias,
                                          child: Transform.rotate(
                                            angle: (query['category'] ==
                                                'kickboard' ||
                                                query['category'] ==
                                                    'traffic light')
                                                ? 0
                                                : 0 * math.pi / 180,
                                            child: ExtendedImage.network(
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
                                          fillColor: MaterialStateColor.resolveWith((states) => Colors.blue.withOpacity(0.8)),
                                          value: _checks[index],
                                          onChanged: (newValue) {
                                            setState(() {
                                              check_num=0;
                                              _checks[index] = newValue!;
                                              _checks_url[index] = x['url'];
                                              _checks_docs[index] = x.id;
                                              for(int i=0;i<_checks.length;i++){
                                                if(_checks[i]==true)
                                                  check_num=check_num+1;
                                              }
                                            });
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          checkColor: Colors.white,
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
        //),
      )),
    );
  }
}
