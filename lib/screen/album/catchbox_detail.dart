import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../mainHome.dart';
import 'package:extended_image/extended_image.dart';

int check_num=0;
String start_date = "";
String end_date = "";
List<String> weekday = ["", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];
bool objectSet = false;

List<Color>colorList=[Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9)];

class Catchbox_detail extends StatefulWidget {
  final QueryDocumentSnapshot query;

  Catchbox_detail({required this.query});

  @override
  State<Catchbox_detail> createState() => _Catchbox_detailState(query: query);
}

class _Catchbox_detailState extends State<Catchbox_detail> {
  final QueryDocumentSnapshot query;

  _Catchbox_detailState({required this.query});


  bool pressed = false;
  int count = 0;

  //String _range2 = '';
  List<String> num_list = [];
  List<String> place_list = [];
  List<String> placenamelist=['장성동','흥해읍','양덕동'];//,'장량동','환호동','두호동','우현동','창포동','죽도동'];
  List<bool> _checks = List.generate(1000, (_) => false);
  List<String> _checks_url = List.generate(1000, (_) => '');
  List<String> _checks_docs = List.generate(1000, (_) => '');

  // 1
  Color _selectDateTextColor = Color(0xFF9FA5B2);
  var _selectDateIcon = true;

  // 2
  String _selectDate = '날짜';
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
    TextTheme textTheme = Theme.of(context).textTheme;
    int _selectedIndex = 2;
    Color? bgColorBottomNavigationBar;
    Color? iconColor;



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


    void _onItemTapped(int index) {
      if (index != 2) {
        setState(() {
          _selectedIndex = index;
          print(_selectedIndex);
          selectedIndex0 = _selectedIndex;
          main_colorList=[Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9),Color(0xffCFD2D9)];
          main_colorList[index]=Color(0xff3A94EE);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainHomePage();
        }));
      }
      print(_selectedIndex);
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
              height: size.width*0.02,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.zero,
                  width: (size.width-35)/3,
                  child:Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          check_num=0;
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
                              check_num=0;
                              _checks.fillRange(0, _checks.length-1,false);
                              print(_checks.length);
                              _checks_url.fillRange(0, _checks_url.length-1,'');
                            }
                          });
                        },
                        child: Text(
                          "취소",//pressed ? "취소" : "선택",
                          style: SubTitleStyle(color: Colors.grey),
                        )
                      // Container(
                      //   child: Center(
                      //       child: Text(
                      //         pressed ? "취소" : "선택",
                      //         style: TextStyle(fontSize: 12, color: Colors.white),
                      //       )),
                      //   width: 60,
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //       color: Color.fromRGBO(58, 148, 238, 1),
                      //       borderRadius: BorderRadius.circular(100.0)),
                      //   //padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      //   //  child: Center(child: Text(_selectCheck, style: TextStyle(color: _selectCheckTextColor))),
                      // ),
                    ),
                  ),
                ),
                Container(
                    width: (size.width-35)/3,
                    child:Center(
                      child: Text(
                        query['category'],
                        style: titleMediumStyle(color: Colors.black),
                      ),
                    )
                ),

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
                                                                objectSet = true;
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

                                    print(_checks);
                                    setState(() {
                                      if (_selectCheckIcon) {
                                        check_num=0;
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
      ),
      bottomNavigationBar:pressed
          ? Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 0, blurRadius: 0.5),
          ],
        ),
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          //// 선택 눌렀을 때
          child:  Column(
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(children: [
                SizedBox(width: size.width * 0.4),
                Text("$check_num 개의 사진이 선택됨",
                    style: labelMediumStyle(
                        color: Color.fromRGBO(26, 26, 26, 1))),
                SizedBox(width: size.width * 0.13),
                //if(pressed == true)
                IconButton(

                  padding: EdgeInsets.all(0),
                  icon: Image.asset("assets/icons/trash_can.png",

                    width:size.width*0.044,
                  ),
                  onPressed: (){
                    showModalBottomSheet<void>(
                      enableDrag: true,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return Container(
                                height: size.height * 0.266,
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),

                                    Text('사진을 삭제하시겠습니까?',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(

                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.025,
                                    ),
                                    Text('삭제한 사진은 복구할 수 없습니다. ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(

                                      ),
                                    ),

                                    SizedBox(
                                      height: size.height * 0.025,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width*0.055,
                                        ),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                        }, child: Text('취소',
                                          style:TextStyle(color: Color(0xff9FA5B2)),
                                        )),
                                        SizedBox(
                                          width: size.width*0.544,
                                        ),
                                        TextButton(
                                            onPressed: (){
                                              print('1/12 ${query['category']}');

                                              check_num=0;
                                              for(int i = 0; i< 1000; i++){
                                                if(_checks_docs[i] != ''){
                                                  FirebaseFirestore.instance.collection('category').doc(FirebaseAuth.instance.currentUser!.email!).collection(query['category']).doc(_checks_docs[i]).delete();
                                                }
                                              }
                                              setState(() {
                                                pressed = false;
                                                _selectCheck = '선택';
                                                _checks.fillRange(0, _checks.length-1,false);
                                                _checks_url.fillRange(0, _checks_url.length-1,'');
                                                _checks_docs.fillRange(0, _checks_docs.length-1,'');
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
                                                  return StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState) {
                                                        return Container(
                                                          height: size.height * 0.5,
                                                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: size.height * 0.06,
                                                              ),

                                                              SizedBox(
                                                                  height:150,
                                                                  child: Image.asset('assets/checkToFinish.gif')),
                                                              SizedBox(
                                                                height: size.height * 0.0475,
                                                              ),
                                                              Text('사진이 삭제되었습니다. '),

                                                              SizedBox(height: size.height * 0.025),

                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              ElevatedButton(
                                                                  style:ButtonStyle(
                                                                    fixedSize:
                                                                    MaterialStateProperty.all(Size(307, 50)),
                                                                    backgroundColor: MaterialStateProperty.all(
                                                                      Color(0xff3A94EE),
                                                                      //_onTap3? primary[40] : onSecondaryColor,
                                                                    ),
                                                                    shape: MaterialStateProperty.all<
                                                                        RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(30.0),
                                                                        )),
                                                                  ),

                                                                  child: Text('확인',
                                                                      style: titleMediumStyle(
                                                                          color: Color(0xffFAFBFB))),
                                                                  onPressed: () {
                                                                    print("here");
                                                                    Navigator.pop(context);
                                                                    Navigator.pop(context);

                                                                  }

                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                              );

                                            }, child: Text('확인',
                                          style: TextStyle(
                                            color: Color(0xff3A94EE),
                                          ),
                                        ))

                                      ],

                                    )


                                    // ElevatedButton(
                                    //     style:ButtonStyle(
                                    //       fixedSize:
                                    //       MaterialStateProperty.all(Size(307, 50)),
                                    //       backgroundColor: MaterialStateProperty.all(
                                    //         Color(0xff3A94EE),
                                    //         //_onTap3? primary[40] : onSecondaryColor,
                                    //       ),
                                    //       shape: MaterialStateProperty.all<
                                    //           RoundedRectangleBorder>(
                                    //           RoundedRectangleBorder(
                                    //             borderRadius: BorderRadius.circular(30.0),
                                    //           )),
                                    //     ),
                                    //
                                    //     child: Text('확인',
                                    //         style: titleMediumStyle(
                                    //             color: Color(0xffFAFBFB))),
                                    //     onPressed: () {
                                    //       for(int i = 0; i< 1000; i++){
                                    //         if(_checks_docs[i] != ''){
                                    //           FirebaseFirestore.instance.collection('category').doc('1234@handong.ac.kr').collection(query['category']).doc(_checks_docs[i]).delete();
                                    //         }
                                    //       }
                                    //       setState(() {
                                    //         pressed = false;
                                    //         _selectCheck = '선택';
                                    //         _checks.fillRange(0, _checks.length-1,false);
                                    //         _checks_url.fillRange(0, _checks_url.length-1,'');
                                    //         _checks_docs.fillRange(0, _checks_docs.length-1,'');
                                    //       });
                                    //       Navigator.pop(context);
                                    //
                                    //     }
                                    //
                                    // )
                                  ],
                                ),
                              );
                            });
                      },
                    );
                  },
                ),

              ]),
            ],
          ),
        ),
      ):
      Container(
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
                  icon: Image.asset(
                    'assets/icons/bottombar/today_catch.png',
                    color:Color(0xffCFD2D9),// colorList[0],
                    width:size.width*0.055,
                  ),
                  label: '\n 오늘의 캐치',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/bottombar/community.png',
                    color: Color(0xffCFD2D9),//colorList[1],
                    width:size.width*0.055,
                  ),
                  label: '\n 커뮤니티',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.add, color: Colors.transparent,),
                //   label: '카메라',
                // ),
                BottomNavigationBarItem(
                  icon:Image.asset(
                    'assets/icons/bottombar/catchbox.png',
                    color: Color(0xff3A94EE),//colorList[2],
                    width:size.width*0.055,
                  ),
                  label: '\n 캐치박스',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/bottombar/mypage.png',
                    color:Color(0xffCFD2D9),//colorList[3],
                    width:size.width*0.055,
                  ),
                  label: '\n 마이페이지',
                ),
              ],
              selectedItemColor: Color(0xff3A94EE),
              unselectedItemColor: Color(0xffCFD2D9),
              currentIndex: selectedIndex0,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              backgroundColor: bgColorBottomNavigationBar,
              selectedLabelStyle: labelSmallStyle(color:Color(0xff3A94EE)),
              unselectedLabelStyle: labelSmallStyle(color:Color(0xffCFD2D9)),
              onTap: _onItemTapped,
            )),
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
          )),
    );
  }
}
