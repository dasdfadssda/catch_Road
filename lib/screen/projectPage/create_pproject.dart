import 'dart:io';
import 'package:camera/camera.dart';
import 'package:catch2_0_1/screen/projectPage/progect_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import '../../utils/app_text_styles.dart';

class CreatePproject extends StatefulWidget {
  //const CreatePproject({Key? key}) : super(key: key);
  // final CameraDescription camera;

  // const CreatePproject({
  //   required this.camera,
  // });
  @override
  _CreatePprojectState createState() => _CreatePprojectState();
}

class _CreatePprojectState extends State<CreatePproject> {
  final _titleController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _contextController = TextEditingController();
  String total_cash = "";

  String image_url = "";

  // File? _image;
  String dateTime = "";
  String _selectedObject = "";
  String naming = "";

  //_quantityController.text=null;
  // String _resultText = '';
  // double unitPrice = double.parse(_unitPriceController.value.text);
  // double quantity = double.parse(_quantityController.value.text);
  // double result;
  // result = (unitPrice * quantity);
  // _resultText = result.toString();
  //User? user = FirebaseAuth.instance.currentUser;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  var _selectDateIcon = true;

  String _dateCount = '';
  String _selectedDate = '';
  String _rangeCount = '';

  String _range1 = '';
  String _range2 = '';
  DateRangePickerController _dataPickerController = DateRangePickerController();
  String _selectDate = '날짜';
  Color _selectDateColor = Color(0XFFF3F4F5);
  Color _selectDateTextColor = Color(0xFF9FA5B2);
  double _selectDateSize = 67.2;

  //var _selectDateIcon = true;

  // List<String> _objects = ["사람","오토바이","자동차","스쿠터","자전거","버스","기차","트럭","신호등","벤치","우산","비행기","보트","정지 표시판","어린이 보호 구역"];
  // List<bool> _selected = List.generate(15, (_) => false);

  List<String> _objects = ["사람", "오토바이", "신호등"];
  List<bool> _selected = List.generate(4, (_) => true);

  //var selected_tags=["사람","자전거","트럭"];
  String result = '0';
  String username = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('user')
        .doc('1234@handong.ac.kr')
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        username = 'eunjin';//ds['name'].toString();
        print(username);
        //cash = ds['cash'];
      });
    });
  }

  //_checks = [false, false, false, false, false, false, false, false, false, false, false, false,
  // 갤러리에서 사진 가져오기
  //image picker
  void _getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    File selected_image = File(image!.path);

    setState(() {
      dateTime = DateTime.now().toString();
      if (image != null) {
        _image = selected_image;
      }
    });
  }

  create() async {
    dateTime = DateTime.now().toString();
    String newTime = dateTime;
    naming = _titleController.text + dateTime;
    newTime = newTime.replaceAll("-", "");
    newTime = newTime.replaceAll(":", "");
    newTime = newTime.replaceAll(" ", "");
    double dateTimeForOrder = double.parse(newTime);
    print(dateTimeForOrder);
    // _resultLabel.add(_whatController.text);
    //
    // category_changer();
    // valuelist_changer();

    try {
      await FirebaseFirestore.instance.collection('project').doc(naming).set({
        "title": _titleController.text,
        //"quantity": _quantityController.text,
        //"unitPrice": _unitPriceController.text,
        "content": _contextController.text,
        "cash": int.parse(result),
        "category": _objects,
        "final_day": 100,
        "id": 'userid',//user!.uid,
        "participate": 0,
        "percentage": 0,
        "creation_time": dateTime,
        "place": "포항시 북구 흥해읍",
        "url": image_url,
        "user": 'eunjin',//username,
        // "userprofile": user!.photoURL,
      });
    } catch (e) {
      print(e);
    }
  }

  Image_upload() async {
    if (_image != null) {
      var snapshot = await FirebaseStorage.instance
          .ref()
          .child('$dateTime.png')
          .putFile(_image!); // 파일 업로드

      String url = await snapshot.ref.getDownloadURL();
      //print(url);
      image_url = url;
      await update(url);
    } else {
      String url =
          await FirebaseStorage.instance.ref('default.png').getDownloadURL();
      await update(url);
    }
  }

  //update url
  update(String url) async {
    try {
      FirebaseFirestore.instance
          .collection("personalProject")
          .doc(naming)
          .update({"url": url});
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _contextController.dispose();
    super.dispose();
  }

  int? _result;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final _formKey = GlobalKey<FormState>();
    // var t1 = int.parse(_quantityController.text);
    // var t2 = int.parse(_unitPriceController.text);

    // ID: x['user'],
    // title: x['title'],
    // cash: x['cash'].toString(),
    // percent: x['percentage'].toString(),
    // daysdue: x['final_day'].toString(),
    // category: x['category'],
    // participate: x['participate'],

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

      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(78),
      //   child:
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        title: Center(
          child: Text('개인프로젝트 올리기',style: titleMediumStyle(color: Colors.black),),

        ),
        leading: TextButton(
          child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Container(
                width: 60,
                height: 22,
                child: Text(
                  '취소',
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.black?.withOpacity(0.4),
                  ),
                ),
              )),
          onPressed: () {
            //Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => projectPage(),
                ));
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: TextButton(
              child: Text(
                '올리기',
                style: textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("upload ok");
                  // Get.to(() => todaycatch());
                  //Get.to(() => account());
                  Image_upload().then(create());
                }
              },
            ),
          ),
          //menuButton,
        ],
      ),
      //),
      body: Padding(
          padding: EdgeInsets.fromLTRB(19, 10, 19, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 12),
                TextFormField(
                  controller: _titleController,
                  autocorrect: true,
                  style: textTheme.labelLarge!,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: '프로젝트 이름',
                    hintStyle: TextStyle(color: Colors.black!.withOpacity(0.2)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    fillColor: Color.fromRGBO(255, 255, 255, 255),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '프로젝트 이름을 입력하세요';
                    }
                  },
                ),
                SizedBox(height: 12),
                Container(
                  height: 1,
                  width: 340,
                  color: Colors.black!.withOpacity(0.05),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      '수집 객체',
                      style: textTheme.titleSmall!
                          .copyWith(color: Colors.black!.withOpacity(0.5)),
                    ),
                    SizedBox(
                      width: 228,
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(30.0))),
                                    insetPadding: EdgeInsets.only(top: 80),
                                    content: Container(
                                        height: 280,
                                        width: 360,
                                        child: Column(children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                        color: _selectDateColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child:
                                                        // Column(
                                                        //   mainAxisAlignment: MainAxisAlignment.center,
                                                        //   children: [
                                                        Column(
                                                      children: [
                                                        // _buildChips(),
                                                        Container(
                                                            child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 208),
                                                            TextButton(
                                                                child:
                                                                    Text('취소'),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    print(
                                                                        'dsds');
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: TextButton.styleFrom(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    minimumSize:
                                                                        Size(50,
                                                                            30),
                                                                    tapTargetSize:
                                                                        MaterialTapTargetSize
                                                                            .shrinkWrap,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft)),
                                                            SizedBox(width: 25),
                                                            TextButton(
                                                                child:
                                                                    Text('확인'),
                                                                onPressed: () {
                                                                  setState(
                                                                      () {});
                                                                  //Navigator.pop(context);
                                                                  // Get.back();
                                                                },
                                                                style: TextButton.styleFrom(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    minimumSize:
                                                                        Size(50,
                                                                            30),
                                                                    tapTargetSize:
                                                                        MaterialTapTargetSize
                                                                            .shrinkWrap,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft))
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          )
                                        ])));
                              });
                        },
                        icon: Icon(Icons.keyboard_arrow_right)),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  height: 1,
                  width: 340,
                  color: Colors.black!.withOpacity(0.05),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      width: 70,
                      child: TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        style: textTheme.labelLarge!,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: '최대 50장',
                          hintStyle:
                              TextStyle(color: Colors.black!.withOpacity(0.2)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          fillColor: Color.fromRGBO(255, 255, 255, 255),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 255)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 255)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '장수를 입력해주세요';
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 2),
                    SizedBox(
                        width: 1,
                        child: Icon(Icons.close,
                            color: Colors.black!.withOpacity(0.2))),
                    SizedBox(width: 22),
                    Container(
                      width: 70,
                      child: TextFormField(
                        controller: _unitPriceController,
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        style: textTheme.labelLarge!,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: '장 당 캐시',
                          hintStyle:
                              TextStyle(color: Colors.black!.withOpacity(0.2)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          fillColor: Color.fromRGBO(255, 255, 255, 255),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 255)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(255, 255, 255, 255)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '장당 희망하는 캐시를 입력해주세요';
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 25),
                    Container(
                      width: 43,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.black,
                            textStyle: TextStyle(
                              //color: primary[0]!.withOpacity(0.02)
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            result = calculateIncome();
                          },
                          child: Text(
                            '계산',
                            style: textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '총',
                      style:
                          textTheme.titleSmall!.copyWith(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Text(
                      result,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '캐시',
                      style:
                          textTheme.titleSmall!.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  height: 1,
                  width: 340,
                  color: Colors.black!.withOpacity(0.05),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '프로젝트 기간',
                      style: textTheme.titleSmall!
                          .copyWith(color: Colors.black!.withOpacity(0.5)),
                    ),
                    SizedBox(
                      width: 203,
                    ),
                    //수집 기간 선택
                    IconButton(
                        onPressed: () {
                          //InkWell(
                          //onTap: (){
                          //if(_selectDateIcon)
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0))),
                                    insetPadding: EdgeInsets.only(top: 229),
                                    content: Container(
                                        height: 400,
                                        width: 360,
                                        child: Column(children: [
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                               20,0,0, 0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Flexible(
                                                  //   fit: FlexFit.tight,
                                                  //   child: Column(
                                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                                  //     children: [
                                                  //       Text('시작', style: textTheme.titleSmall),
                                                  //       if(_range1 != '')
                                                  //         Row(
                                                  //           children: [
                                                  //             Text(_range1.substring(0,2), style: textTheme.headlineLarge),
                                                  //             SizedBox(width: 10),
                                                  //             Column(
                                                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                 children: [
                                                  //                   Text(_range1.substring(6,10)+'년 '+_range1.substring(3,5)),
                                                  //                   Text('수요일')
                                                  //                 ]
                                                  //             )
                                                  //           ],
                                                  //         )
                                                  //       else
                                                  //         Row(
                                                  //           children: [
                                                  //             Text(_range1),
                                                  //             SizedBox(width: 10),
                                                  //             Column(
                                                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                 children: [
                                                  //                   Text(_range1),
                                                  //                   Text('')
                                                  //                 ]
                                                  //             )
                                                  //           ],
                                                  //         )
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  // SizedBox(width: 76),
                                                  //       Flexible(
                                                  //         fit: FlexFit.tight,
                                                  //         child: Column(
                                                  //           crossAxisAlignment: CrossAxisAlignment.start,
                                                  //           children: [
                                                  //             Text('종료', style: textTheme.titleSmall),
                                                  //             if(_range2 != '')
                                                  //               Row(
                                                  //                 children: [
                                                  //                   Text(_range2.substring(0,2), style: textTheme.headlineLarge),
                                                  //                   SizedBox(width: 10),
                                                  //                   Column(
                                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                       children: [
                                                  //                         Text(_range2.substring(6,10)+'년 '+_range2.substring(3,5)),
                                                  //                         Text('')
                                                  //                       ]
                                                  //                   )
                                                  //                 ],
                                                  //               )else
                                                  //               Row(
                                                  //                 children: [
                                                  //                   Text(_range2),
                                                  //                   SizedBox(width: 10),
                                                  //                   Column(
                                                  //                       crossAxisAlignment: CrossAxisAlignment.start,
                                                  //                       children: [
                                                  //                         Text(_range2),
                                                  //                         Text('')
                                                  //                       ]
                                                  //                   )
                                                  //                 ],
                                                  //               )
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  // SizedBox(height: 60),
                                                  SizedBox(
                                                    width:300,
                                                    height: 300,
                                                    child: SfDateRangePicker(
                                                      controller:
                                                      _dataPickerController,
                                                      onSelectionChanged:
                                                      _onSelectionChanged,
                                                      selectionMode:
                                                      DateRangePickerSelectionMode
                                                          .range,
                                                    ),

                                                  ),
                                                  //SizedBox(height: 30),

                                                ],
                                              )),
                                          Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 208),
                                                  TextButton(
                                                      child: Text('취소'),
                                                      onPressed: () {
                                                        setState(() {
                                                          _range1 = '';
                                                          _range2 = '';
                                                          _dataPickerController
                                                              .selectedRanges =
                                                          null;
                                                        });
                                                        //Navigator.pop(context);
                                                      },
                                                      style: TextButton.styleFrom(
                                                          padding:
                                                          EdgeInsets
                                                              .zero,
                                                          minimumSize:
                                                          Size(50, 30),
                                                          tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                          alignment: Alignment
                                                              .centerLeft)),
                                                  SizedBox(width: 25),
                                                  TextButton(
                                                      child: Text('확인'),
                                                      onPressed: () {
                                                        setState(() {
                                                          _selectDateColor =
                                                          Colors.black!;
                                                          _selectDateTextColor =
                                                              Colors.white;
                                                          _selectDate = _range1
                                                              .substring(
                                                              8,
                                                              10) +
                                                              '.' +
                                                              _range1
                                                                  .substring(
                                                                  3,
                                                                  5) +
                                                              '.' +
                                                              _range1
                                                                  .substring(
                                                                  0, 2);
                                                          _selectDateSize =
                                                          80;
                                                          _selectDateIcon =
                                                          false;
                                                        });
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      style: TextButton.styleFrom(
                                                          padding:
                                                          EdgeInsets
                                                              .zero,
                                                          minimumSize:
                                                          Size(50, 30),
                                                          tapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                          alignment: Alignment
                                                              .centerLeft))
                                                ],
                                              ))
                                        ])));
                              });
                          //);
                          // else
                          //   setState((){
                          //     _selectDateIcon = true;
                          //     _selectDate = '날짜';
                          //     _selectDateColor = Color(0XFFF3F4F5);
                          //     _selectDateTextColor = Color(0xFF9FA5B2);
                          //     _selectDateSize = 67.2.w;
                          //     _range1 = '';
                          //     _range2 = '';
                          //   });
                          //},
                          //1-1
                          // child: Container(
                          //     width: _selectDateSize,
                          //     height: 24,
                          //     decoration: BoxDecoration(
                          //         color: _selectDateColor,
                          //         borderRadius: BorderRadius.circular(10.0)
                          //     ),
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           _selectDate,
                          //           style: TextStyle(
                          //             color: _selectDateTextColor,
                          //           ),
                          //         ),
                          //         Icon(_selectDateIcon? Icons.keyboard_arrow_down_outlined : Icons.clear_outlined, color: _selectDateTextColor),
                          //       ],
                          //     )
                          // ),
                          //);
                        },
                        icon: Icon(Icons.keyboard_arrow_right)),

                  ],
                ),
                SizedBox(height: 12),
                Container(
                  height: 1,
                  width: 340,
                  color: Colors.black!.withOpacity(0.05),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '예시 사진 추가',
                      style: textTheme.titleSmall!
                          .copyWith(color: Colors.black!.withOpacity(0.5)),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    IconButton(
                        onPressed: () {
                          _getImage();
                          //Get.to(() => Catchbox());
                        },
                        icon: Icon(Icons.keyboard_arrow_right))
                  ],
                ),
                SizedBox(height: 12),
                Container(
                  height: 1,
                  width: 340,
                  color: Colors.black!.withOpacity(0.05),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _contextController,
                  autocorrect: true,
                  style: textTheme.labelLarge!,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: '원하시는 사진에 대한 자세한 설명을 적어주세요.',
                    hintStyle: TextStyle(color: Colors.black!.withOpacity(0.2)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(5, 20, 0, 20),
                    fillColor: Color.fromRGBO(255, 255, 255, 255),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '원하시는 사진에 대한 설명을 입력해주세요';
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }

  // Widget _buildChips() {
  //   List<Widget> chips = [];
  //   for (int i = 0; i < _objects.length; i++) {
  //     FilterChip filterChip = FilterChip(
  //       selected: _selected[i],
  //       label: Text(_objects[i], style: TextStyle(color: Colors.black)),
  //       elevation: 0,
  //       pressElevation: 0,
  //       //shadowColor: Colors.teal,
  //       backgroundColor: primary[0]!.withOpacity(0.05),
  //       selectedColor: primary[50],
  //       onSelected: (bool selected) {
  //         setState(() {
  //           _selected[i] = selected;
  //         });
  //       },
  //     );
  //
  //     chips.add(Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 3), child: filterChip));
  //   }
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(5, 5,, 5, 0),
  //     child: Wrap(
  //       direction: Axis.horizontal,
  //       spacing: 2.0,
  //       runSpacing: 1.0,
  //       children: chips,
  //     ),
  //   );
  // }

  // generate_tags() {
  //   return tags.map((tag) => get_chip(tag)).toList();
  // }
  //
  // get_chip(name) {
  //   return FilterChip(
  //       selected: selected_tags.contains(name),
  //       selectedColor: Colors.blue.shade800,
  //       disabledColor: Colors.blue.shade400,
  //       labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  //       label: Text("#${name}"),
  //     onSelected: (bool value) {  },);
  // }

  String calculateIncome() {
    int quantity;
    int unitPrice;
    if (_quantityController.text.isEmpty || _unitPriceController.text.isEmpty) {
      //print("Here");
      //return "0";
      quantity = 0;
      unitPrice = 0;
    } else {
      quantity = int.parse(_quantityController.text);
      unitPrice = int.parse(_unitPriceController.text);
    }

    int result = quantity * unitPrice;
    _result = result;
    setState(() {
      _result = result;
    });

    String StringResult = "";
    StringResult = _result.toString();
    return StringResult;
  }
}
