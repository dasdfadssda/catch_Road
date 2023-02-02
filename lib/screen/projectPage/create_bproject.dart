import 'dart:io';
import 'package:camera/camera.dart';
import 'package:catch2_0_1/screen/projectPage/progect_main.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
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
  @override
  _CreateBprojectState createState() => _CreateBprojectState();
}

class _CreateBprojectState extends State<CreateBproject> {

  int tag = 3;

  // multiple choice value
  List<String> tags = ['Education'];

  // list of string options
  List<String> options = [
    '사람',
    '오토바이',
    '자동차',
    '스쿠터',
    '자전거',
    '버스',
    '기차',
    '트럭',
    '신호등',
    '벤치',
    '우산',
    '비행기',
    '보트',
    '정지 표지판',
    '어린이 보호구역'
  ];

  String? user;
  final usersMemoizer = C2ChoiceMemoizer<String>();


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

  String dateTime = "";
  String naming = "";

  String start="";
  String end ="";

  File? _image;
  final ImagePicker _picker = ImagePicker();

  List<String> _objects = ["사람", "오토바이", "신호등"];

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

  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {
    });

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
    String _SYearMonth ="";
    String _SDate="";
    String _SDay="";

    String _EYearMonth="";
    String _EDate="";
    String _EDay="";

    void selectionChanged(DateRangePickerSelectionChangedArgs args) {
      SchedulerBinding.instance!.addPostFrameCallback((duration) {
        setState(() {
          if (args.value is PickerDateRange) {
            _SYearMonth = DateFormat('yyyy년 MMMM', 'ko')
                .format(args.value.startDate)
                .toString();
            _SDate =
                DateFormat('dd', 'ko').format(args.value.startDate).toString();
            _SDay = DateFormat('EEEE', 'ko')
                .format(args.value.startDate)
                .toString();

            _EYearMonth = args.value.endDate != null
                ? DateFormat('yyyy년 MMMM', 'ko').format(args.value.endDate).toString()
                : _SYearMonth;
            _EDate = args.value.endDate != null
                ? DateFormat('dd', 'ko').format(args.value.endDate).toString()
                : _SDate;
            _EDay = args.value.endDate != null
                ? DateFormat('EEEE', 'ko').format(args.value.endDate).toString()
                : _SDay;
          }
        });

      });
    }

    TextTheme textTheme = Theme.of(context).textTheme;
    final _formKey = GlobalKey<FormState>();

    final DateRangePickerController _controller = DateRangePickerController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
              )),
          onPressed: () {
            Navigator.pop(context);
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
                      builder: (BuildContext context) =>projectPage(),
                    ));
                Image_upload().then(create());
              }
            },
          ),
          //menuButton,
        ],
      ),
      //),
      body: Padding(
          padding: EdgeInsets.fromLTRB(24, 10, 19, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //업체명
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _compNameController,
                    autocorrect: false,
                    autofocus: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '업체명',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //대표자 성명
                  SizedBox(height: 12),
                  TextFormField(
                    autofocus: true,
                    controller: _ceoNameController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '대표자 성명',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //담당자 성명
                  SizedBox(height: 12),
                  TextFormField(
                    autofocus: true,
                    controller: _managerNameController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '담당자 성명',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //주소
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '주소',
                        style: textTheme.titleSmall!
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      IconButton(
                          onPressed: () {
                           // FocusScope.of(context).requestFocus(FocusNode());
                           //  FocusScopeNode currentFocus = FocusScope.of(context);
                           //  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                           //    currentFocus.focusedChild?.unfocus();
                           //  }
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        16,36,16,0 ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        30,0,30,0 ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(child:Text("취소", style: buttonLargeStyle().copyWith(color:Color(0XFF9FA5B2)),),onPressed: (){},),
                                                        TextButton(child:Text("확인", style: buttonLargeStyle().copyWith(color:primary[50]),),onPressed: (){
                                                          Navigator.pop(context);



                                                        },),
                                                        //background: #9FA5B2;
                                                      ],
                                                    ),
                                                  ),
                                                ]));
                                      }
                                  );

                                });

                            // setState(() {

                            // });


                          },
                          icon: Icon(Icons.keyboard_arrow_right)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //연락처
                  SizedBox(height: 12),
                  TextFormField(
                    autofocus: true,
                    controller: _phoneNumberController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '연락처',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //이메일
                  SizedBox(height: 12),
                  TextFormField(
                    autofocus: true,
                    controller: _emailController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'E-mail',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //사업자 등록증으로 인증
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '사업자 등록증으로 인증',
                        style: textTheme.titleSmall!
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        16,36,16,0 ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        30,0,30,0 ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(child:Text("취소", style: buttonLargeStyle().copyWith(color:Color(0XFF9FA5B2)),),onPressed: (){},),
                                                        TextButton(child:Text("확인", style: buttonLargeStyle().copyWith(color:primary[50]),),onPressed: (){},),
                                                        //background: #9FA5B2;
                                                      ],
                                                    ),
                                                  ),
                                                ]));
                                      }
                                  );

                                });
                          },
                          icon: Icon(Icons.keyboard_arrow_right)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //프로젝트 이름
                  SizedBox(height: 12),
                  // TextFormField(
                  //   autofocus: true,
                  //   controller: _emailController,
                  //   autocorrect: true,
                  //   style: textTheme.labelLarge!,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     hintText: 'E-mail',
                  //     hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                  //     border: InputBorder.none,
                  //     contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  //     fillColor: Color.fromRGBO(255, 255, 255, 255),
                  //     enabledBorder: UnderlineInputBorder(
                  //       borderSide:
                  //       BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  //     ),
                  //     focusedBorder: UnderlineInputBorder(
                  //       borderSide:
                  //       BorderSide(color: Color.fromRGBO(255, 255, 255, 255)),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return '프로젝트 이름을 입력하세요';
                  //     }
                  //   },
                  // ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //수집 객체
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '수집 객체',
                        style: textTheme.titleSmall!
                            .copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.4,
                                            child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        16,36,16,0 ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[

                                                        Flexible(
                                                          fit: FlexFit.loose,
                                                          child: ChipsChoice<String>.multiple(
                                                            value: tags,
                                                            onChanged: (val) => setState(() => tags = val),
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
                                                    padding: EdgeInsets.fromLTRB(
                                                        30,0,30,0 ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(child:Text("취소", style: buttonLargeStyle().copyWith(color:Color(0XFF9FA5B2)),),onPressed: (){},),
                                                        TextButton(child:Text("확인", style: buttonLargeStyle().copyWith(color:primary[50]),),onPressed: (){},),
                                                        //background: #9FA5B2;
                                                      ],
                                                    ),
                                                  ),
                                                ]));
                                      }
                                  );

                                });
                          },
                          icon: Icon(Icons.keyboard_arrow_right)),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //캐시
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70,
                            child: TextFormField(
                              autofocus: true,
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              autocorrect: true,
                              style: textTheme.labelLarge!,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: '최대 50장',
                                hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.2)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                  color: Colors.black.withOpacity(0.2))),
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
                                TextStyle(color: Colors.black.withOpacity(0.2)),
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

                        ],
                      ),

                      Row(
                        children: [
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
                        ],),

                      Row(
                        children: [
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
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.05),
                  ),
                  //프로젝트 기간
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '프로젝트 기간',
                        style: textTheme.titleSmall!
                            .copyWith(color: Colors.black!.withOpacity(0.5)),
                      ),
                      //수집 기간 선택
                      IconButton(
                          onPressed: () {
                            //InkWell(
                            //onTap: (){
                            //if(_selectDateIcon)
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                    )
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.7,
                                            child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        36,46,36,0 ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [

                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("시작", style: titleSmallStyle()),
                                                            SizedBox(height: 10,),
                                                            Row(
                                                              children: [
                                                                Text(_SDate, style: headlineLargeStyle().copyWith(color: primary[50])),
                                                                SizedBox(width: 15,),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(_SYearMonth, style: labelMediumStyle().copyWith(color: primary[50])),
                                                                    Text(_SDay, style: labelMediumStyle().copyWith(color: primary[50])),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),


                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(0,0,40,0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text("종료", style: titleSmallStyle()),
                                                              SizedBox(height: 10,),
                                                              Row(
                                                                children: [
                                                                  Text(_EDate, style: headlineLargeStyle().copyWith(color: primary[50])),
                                                                  SizedBox(width: 10,),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(_EYearMonth, style: labelMediumStyle().copyWith(color: primary[50])),
                                                                      Text(_EDay, style: labelMediumStyle().copyWith(color: primary[50])),
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
                                                    padding: EdgeInsets.fromLTRB(
                                                        30,36,30,0 ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                          width: MediaQuery.of(context).size.width * 0.8,
                                                          child: SfDateRangePicker(
                                                            view: DateRangePickerView.month,
                                                            initialSelectedDate: DateTime.now(),
                                                            minDate: DateTime(2000),
                                                            maxDate: DateTime(2100),

                                                            selectionMode: DateRangePickerSelectionMode.range,
                                                            controller: _controller,
                                                            onSelectionChanged: selectionChanged,
                                                            //onSelectionChanged: _onSelectionChanged,

                                                            // onSelectionChanged:
                                                            //     (DateRangePickerSelectionChangedArgs args) {
                                                            //   setState(() {
                                                            //     if (args.value is PickerDateRange) {
                                                            //       start = args.value.startDate
                                                            //           .toString()
                                                            //           .substring(0, 10);
                                                            //
                                                            //       end = args.value.endDate != null
                                                            //           ? args.value.endDate
                                                            //           .toString()
                                                            //           .substring(0, 10)
                                                            //           : start;
                                                            //     }
                                                            //   });
                                                            // },

                                                            // controller:
                                                            // _dataPickerController,

                                                          ),

                                                        ),
                                                        //SizedBox(height: 30),

                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.fromLTRB(
                                                        30,0,30,0 ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        TextButton(child:Text("취소", style: buttonLargeStyle().copyWith(color:Color(0XFF9FA5B2)),),onPressed: (){},),
                                                        TextButton(child:Text("확인", style: buttonLargeStyle().copyWith(color:primary[50]),),onPressed: (){
                                                          print('pop');
                                                          setState(() {
                                                            Navigator.pop(context);
                                                          });

                                                        },),
                                                        //background: #9FA5B2;
                                                      ],
                                                    ),
                                                  ),
                                                  /*
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
                                                    */
                                                ]));
                                      }
                                  );



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
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black!.withOpacity(0.05),
                  ),
                  //예시 사진 추가
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '예시 사진 추가',
                        style: textTheme.titleSmall!
                            .copyWith(color: Colors.black!.withOpacity(0.5)),
                      ),
                      IconButton(
                          onPressed: () {
                            // _getImage();
                            //Get.to(() => Catchbox());
                            selectImages();
                          },
                          icon: Icon(Icons.keyboard_arrow_right))
                    ],
                  ),
                  SizedBox(height: 6),
                  (imageFileList?.isEmpty == true)?
                  SizedBox(height: 0)
                      :SizedBox(
                    height: 70,
                    child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                          child: GridView.builder(
                              itemCount: imageFileList!.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: Stack(
                                    children: [
                                      Image.file(File(imageFileList![index].path), fit: BoxFit.fill),
                                      Positioned(
                                        right: 1,
                                        top: 1,
                                        child: InkWell(
                                          child: Icon(
                                            Icons.cancel_rounded,
                                            size: 20,
                                            color: Colors.grey,
                                          ),
                                          onTap: () {
                                            setState(() {
                                              imageFileList?.replaceRange(index, index + 1, []);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black!.withOpacity(0.05),
                  ),
                  //내용 설명
                  SizedBox(height: 5),
                  TextFormField(
                    autofocus: true,
                    controller: _contextController,
                    autocorrect: true,
                    style: textTheme.labelLarge!,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: '원하시는 사진에 대한 자세한 설명을 적어주세요.',
                      hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
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

//
// class Content extends StatefulWidget {
//   final Widget child;
//
//   const Content({
//     Key? key,
//     required this.child,
//   }) : super(key: key);
//
//   @override
//   ContentState createState() => ContentState();
// }
//
// class ContentState extends State<Content> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.all(5),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//
//           Flexible(fit: FlexFit.loose, child: widget.child),
//         ],
//       ),
//     );
//   }
// }