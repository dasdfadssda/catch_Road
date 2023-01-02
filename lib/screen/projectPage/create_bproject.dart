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

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class CreateBproject extends StatefulWidget {
  //const CreateBproject({Key? key}) : super(key: key);
  // final CameraDescription camera;

  // const CreateBproject({
  //   required this.camera,
  // });

  @override
  _CreateBprojectState createState() => _CreateBprojectState();
}

class _CreateBprojectState extends State<CreateBproject> {
  final _titleController = TextEditingController();
  final  _compNameController = TextEditingController();
  final _ceoNameController = TextEditingController();
  final _managerNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
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
  User? user = FirebaseAuth.instance.currentUser;
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
        "quantity": _quantityController.text,
        "unitPrice": _unitPriceController.text,
        "content": _contextController.text,
        "cash": calculateIncome(),
        "category": "오토바이",
        "final_day": _range2,
        "id": user!.uid,
        "participate": 0,
        "percentage": 0,
        "creation_time": dateTime,
        "place": "포항시 북구 흥해읍",
        "url": image_url,
        "comp_name": _compNameController.text,
        "ceo_name":_ceoNameController.text,
        "manager_name": _managerNameController.text,
        "phone_num": _phoneNumberController.text,
        "email": _emailController.text,
        "certification_photo": image_url,
        // "username": user!.displayName,
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Center(
          child: Text(
            '기업 프로젝트 올리기',
            style: titleMediumStyle(color: Colors.black),
          ),
        ),
        leading: TextButton(
          //icon: new Icon(Icons.accessibility),
          child: Text(
            '취소',
            style: titleSmallStyle(color: Colors.grey),
          ),
          onPressed: () {
            //Navigator.pop(context);

            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      projectPage(),
                ));
          },
        ),
        actions: [
          TextButton(
            //icon: new Icon(Icons.accessibility),
            child: Text(
              '의뢰하기',
              style: titleSmallStyle(color: Colors.blue),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("upload ok");

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          projectPage(),
                    ));
                Image_upload().then(create());
              }
            },
          ),
          //menuButton,
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(19, 10, 19, 0),
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _compNameController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '업체명',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                        return '업체명을 입력하세요';
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _ceoNameController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '대표자 성명',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                        return '대표자 성명을 입력하세요';
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  TextFormField(
                    controller: _managerNameController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '담당자 성명',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                        return '담당자 성명을 입력하세요';
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Expanded(
                        child:Text(
                          '주소',
                          style: textTheme.titleSmall!
                              .copyWith(color: primary[0]!.withOpacity(0.5)),
                        ),
                      ),
                      // Flexible(child:
                      // Conta),
                      SizedBox(
                        width: 232,
                      ),
                      IconButton(
                          onPressed: () {
                            // geolocator
                          },
                          icon: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  TextFormField(
                    controller: _phoneNumberController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '연락처',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                        return '연락처를 입력하세요';
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  TextFormField(
                    controller: _emailController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                        return '이메일을 입력하세요';
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        '사업자 등록증으로 인증',
                        style: textTheme.titleSmall!
                            .copyWith(color: primary[0]!.withOpacity(0.5)),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 232,
                        ),),
                      Expanded(child: IconButton(
                          onPressed: () {
                            // geolocator
                          },
                          icon: Icon(Icons.keyboard_arrow_right))),

                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _titleController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '프로젝트 이름',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Text(
                        '수집 객체',
                        style: textTheme.titleSmall!
                            .copyWith(color: primary[0]!.withOpacity(0.5)),
                      ),
                      SizedBox(
                        width: 232,
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
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
                            TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                              color: primary[0]!.withOpacity(0.2))),
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
                            TextStyle(color: primary[0]!.withOpacity(0.2)),
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
                      SizedBox(width: 70),
                      Text(
                        '총',
                        style: textTheme.titleSmall!.copyWith(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                      Text(
                        calculateIncome(),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '캐시',
                        style: textTheme.titleSmall!.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
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
                            .copyWith(color: primary[0]!.withOpacity(0.5)),
                      ),
                      SizedBox(
                        width: 195,
                      ),
                      IconButton(
                          onPressed: () {
                            InkWell(
                              onTap: () {
                                if (_selectDateIcon)
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
                                            height: 512,
                                            width: 360,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      24, 30, 24, 0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text('시작',
                                                                style: textTheme
                                                                    .titleSmall),
                                                            if (_range1 != '')
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      _range1
                                                                          .substring(
                                                                          0, 2),
                                                                      style: textTheme
                                                                          .headlineLarge),
                                                                  SizedBox(
                                                                      width: 10),
                                                                  Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(_range1.substring(
                                                                            6,
                                                                            10) +
                                                                            '년 ' +
                                                                            _range1.substring(
                                                                                3,
                                                                                5)),
                                                                        Text('수요일')
                                                                      ])
                                                                ],
                                                              )
                                                            else
                                                              Row(
                                                                children: [
                                                                  Text(_range1),
                                                                  SizedBox(
                                                                      width: 10),
                                                                  Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                            _range1),
                                                                        Text('')
                                                                      ])
                                                                ],
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 76),
                                                      Flexible(
                                                        fit: FlexFit.tight,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Text('종료',
                                                                style: textTheme
                                                                    .titleSmall),
                                                            if (_range2 != '')
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      _range2
                                                                          .substring(
                                                                          0, 2),
                                                                      style: textTheme
                                                                          .headlineLarge),
                                                                  SizedBox(
                                                                      width: 10),
                                                                  Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(_range2.substring(
                                                                            6,
                                                                            10) +
                                                                            '년 ' +
                                                                            _range2.substring(
                                                                                3,
                                                                                5)),
                                                                        Text('')
                                                                      ])
                                                                ],
                                                              )
                                                            else
                                                              Row(
                                                                children: [
                                                                  Text(_range2),
                                                                  SizedBox(
                                                                      width: 10),
                                                                  Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                            _range2),
                                                                        Text('')
                                                                      ])
                                                                ],
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 60),
                                                SfDateRangePicker(
                                                  controller: _dataPickerController,
                                                  onSelectionChanged:
                                                  _onSelectionChanged,
                                                  selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .range,
                                                ),
                                                SizedBox(height: 30),
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
                                                                EdgeInsets.zero,
                                                                minimumSize:
                                                                Size(50, 30),
                                                                tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                                alignment: Alignment
                                                                    .centerLeft)),
                                                        SizedBox(width: 32),
                                                        TextButton(
                                                            child: Text('확인'),
                                                            onPressed: () {
                                                              setState(() {
                                                                _selectDateColor =
                                                                primary[40]!;
                                                                _selectDateTextColor =
                                                                    Colors.white;
                                                                _selectDate = _range1
                                                                    .substring(
                                                                    8, 10) +
                                                                    '.' +
                                                                    _range1.substring(
                                                                        3, 5) +
                                                                    '.' +
                                                                    _range1.substring(
                                                                        0, 2);
                                                                _selectDateSize = 80;
                                                                _selectDateIcon = false;
                                                              });
                                                              Navigator.pop(context);
                                                            },
                                                            style: TextButton.styleFrom(
                                                                padding:
                                                                EdgeInsets.zero,
                                                                minimumSize:
                                                                Size(50, 30),
                                                                tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                                alignment: Alignment
                                                                    .centerLeft))
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
                                    _range2 = '';
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
                            );
                          },
                          icon: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: 340,
                    color: primary[0]!.withOpacity(0.05),
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
                            .copyWith(color: primary[0]!.withOpacity(0.5)),
                      ),
                      SizedBox(
                        width: 205,
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
                    color: primary[0]!.withOpacity(0.05),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: _contextController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '원하시는 사진에 대한 자세한 설명을 적어주세요.',
                      hintStyle: TextStyle(color: primary[0]!.withOpacity(0.2)),
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
      ),
    );
  }

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

