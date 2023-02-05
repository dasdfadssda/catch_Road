import 'dart:io';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/widget.dart';

String start_date = "";
String end_date = "";

List<String> weekday = ["", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"];

class CreatePProject extends StatefulWidget {
  const CreatePProject({Key? key}) : super(key: key);

  @override
  State<CreatePProject> createState() => _CreatePProjectState();
}

class _CreatePProjectState extends State<CreatePProject> {
  bool _road = true;
  bool _catch = false;
  String result = '0';

  String s_year = "";
  String s_month = "";
  String s_day = "";
  String s_day2 = "";

  String e_year = "";
  String e_month = "";
  String e_day = "";
  String e_day2 = "";

  // multiple choice value
  List<String> tags = [];

  // list of string options
  List<String> options = [
    '자전거',
    '자동차',
    '오토바이',
    '버스',
    '기차',
    '신호등',
    '트럭',
    '소화전',
    '정지표지판',
    '벤치',
    '고양이',
    '개'
  ];
  int? _result;
  File? _image;
  String image_url = "";
  String dateTime = "";
  String naming = "";
  final ImagePicker _picker = ImagePicker();
  List<XFile>? imageFileList = [];

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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final DateRangePickerController _datecontroller = DateRangePickerController();
    void selectImages() async {
      final List<XFile> selectedImages = await _picker.pickMultiImage();
      if (selectedImages!.isNotEmpty) {
        imageFileList!.addAll(selectedImages);
      }
      setState(() {
      });

      // if (_image != null) {
      //   var snapshot = await FirebaseStorage.instance
      //       .ref()
      //       .child('$dateTime.png')
      //       .putFile(_image!!); // 파일 업로드
      //
      //   String url = await snapshot.ref.getDownloadURL();
      //   //print(url);
      //   image_url = url;
      //   await update(url);
      // } else {
      //   String url =
      //   await FirebaseStorage.instance.ref('default.png').getDownloadURL();
      //   await update(url);
      // }
    }

    return Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          leading: TextButton(
            child: Text('취소',
              style: TextStyle(
                color: Colors.grey
              ),
            ),
            onPressed: (){
              Navigator.pop(context);
            },

          ),
          actions: [
            TextButton(
              child: Text('업로드',
              ),
              onPressed: (){
                //데이터베이스 연결

              },

            ),
          ],
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("개인 프로젝트 올리기",
            style: titleMediumStyle(color: Colors.black),
          ),
        ),


        body: SingleChildScrollView(
          child: Column(
            children: [
              TitleText(),
              MyWidget().DivderLine(),
              ShowObject(),
              MyWidget().DivderLine(),
              // CeoNameText(),
              // MyWidget().DivderLine(),
              contentText(),
              MyWidget().DivderLine(),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 24),
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.18,
                      child: TextFormField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        style: Theme.of(context).textTheme.labelLarge!,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: '최대 50장',
                          hintStyle: TextStyle(
                              color: Color(0XFFCFD2D9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
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
                    SizedBox(width: size.width * 0.035),
                    SizedBox(
                        child: Icon(Icons.close,
                            color: Colors.black.withOpacity(0.2))),
                    SizedBox(width: size.width * 0.035),
                    Container(
                      width: size.width * 0.16,
                      child: TextFormField(
                        controller: _unitPriceController,
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        style: Theme.of(context).textTheme.labelLarge!,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '장당캐시',
                          hintStyle: TextStyle(
                              color: Color(0XFFCFD2D9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '장당 희망하는 캐시를 입력해주세요';
                          }
                        },
                      ),
                    ),
                    // SizedBox(width: 25),
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
                            print("hello");
                            result = calculateIncome();
                          },
                          child: Text(
                            '계산',
                            style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: Colors.white,
                            ),
                          )),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '총',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Text(
                      result,
                    ),
                    SizedBox(width: 10),
                    Text(
                      '캐시',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              MyWidget().DivderLine(),
              ListTile(
                onTap: (){
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
                              height:
                              MediaQuery.of(context).size.height * 0.7,
                              child: Column(children: [
                                Container(
                                  padding:
                                  EdgeInsets.fromLTRB(36, 46, 36, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("시작",
                                              style: titleSmallStyle()),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          //2/5
                                          Row(
                                            children: [
                                              Text(s_day,
                                                  style:
                                                  headlineLargeStyle()
                                                      .copyWith(
                                                      color:
                                                      primary[
                                                      50])),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  //Text(start_date),
                                                  Text(
                                                      s_year == ""
                                                          ? ""
                                                          : "$s_year년 $s_month월",
                                                      style: labelMediumStyle()
                                                          .copyWith(
                                                          color:
                                                          primary[
                                                          50])),
                                                  Text(s_day2,
                                                      style: labelMediumStyle()
                                                          .copyWith(
                                                          color:
                                                          primary[
                                                          50])),
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
                                                    style:
                                                    headlineLargeStyle()
                                                        .copyWith(
                                                        color:
                                                        primary[
                                                        50])),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                        e_year == ""
                                                            ? ""
                                                            : "$e_year년 $e_month월",
                                                        style: labelMediumStyle()
                                                            .copyWith(
                                                            color:
                                                            primary[
                                                            50])),
                                                    Text(e_day2,
                                                        style: labelMediumStyle()
                                                            .copyWith(
                                                            color:
                                                            primary[
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
                                  padding:
                                  EdgeInsets.fromLTRB(30, 36, 30, 0),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.8,
                                        child: SfDateRangePicker(
                                          view: DateRangePickerView.month,
                                          initialSelectedDate:
                                          DateTime.now(),
                                          minDate: DateTime(2000),
                                          maxDate: DateTime(2100),
                                          selectionMode:
                                          DateRangePickerSelectionMode
                                              .range,
                                          controller: _datecontroller,
                                          onSelectionChanged:
                                              (DateRangePickerSelectionChangedArgs
                                          args) {
                                            setState2((){

                                              setState(() {
                                                if (args.value
                                                is PickerDateRange) {
                                                  start_date = args
                                                      .value.startDate
                                                      .toString();

                                                  end_date =
                                                  args.value.endDate !=
                                                      null
                                                      ? args.value.endDate
                                                      .toString()
                                                      : start_date;
                                                }

                                                DateTime s_date_datetime = DateTime.parse(start_date.substring(0, 19));
                                                DateTime e_date_datetime = DateTime.parse(end_date.substring(0, 19));

                                                s_year = s_date_datetime.year.toString();
                                                s_month = s_date_datetime.month.toString();
                                                s_day = s_date_datetime.day.toString();
                                                s_day2 = weekday[s_date_datetime.weekday.toInt()];

                                                e_year = e_date_datetime.year.toString();
                                                e_month = e_date_datetime.month.toString();
                                                e_day = e_date_datetime.day
                                                    .toString();
                                                e_day2 = weekday[
                                                e_date_datetime.weekday
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
                                  padding:
                                  EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        child: Text(
                                          "취소",
                                          style: buttonLargeStyle()
                                              .copyWith(
                                              color: Color(0XFF9FA5B2)),
                                        ),
                                        onPressed: () {
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
                                          // s_year = "";
                                          // s_month = "";
                                          // s_day = "";
                                          // s_day2 = "";
                                          //
                                          // e_year = "";
                                          // e_month = "";
                                          // e_day = "";
                                          // e_day2 = "";

                                          //setState2(() {
                                          setState(() {
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
                },
                contentPadding: EdgeInsets.only(top: 0, left: 24, right: 22),
                leading: Container(
                  padding: EdgeInsets.only(top: 2.5),
                  child: Text('프로젝트 기간', style: bodyEmphasisStyle()),
                ),
                title: Text(s_day==""?"":"                 ${s_month}/${s_day} ~ ${e_month}/${e_day} ",
                  style: TextStyle(
                      fontWeight: FontWeight.w600
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0XFFCFD2D9),
                ),


              ),
              MyWidget().DivderLine(),
              ListTile(
                title: Container(
                  padding: EdgeInsets.only(top: 2.5),
                  child: Text('예시사진추가', style: bodyEmphasisStyle()),
                ),
                onTap: (){
                  selectImages();
                },
                contentPadding: EdgeInsets.only(top: 0, left: 24, right: 22),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0XFFCFD2D9),
                ),


              ),
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



            ],
          ),
        )
    );
  }

  final projectNameController = TextEditingController();

  Widget TitleText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 24),
      child: TextFormField(
        //autofocus: true,
        maxLines: 1,
        minLines: 1,
        controller: projectNameController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '프로젝트 이름',
            hintStyle: TextStyle(
                color: Color(0XFFCFD2D9),
                fontSize: 14,
                fontWeight: FontWeight.w400)),
      ),
    );
  }

  final _quantityController = TextEditingController();
  final _contextController = TextEditingController();
  final _unitPriceController = TextEditingController();

  final ceoNameController = TextEditingController();

  Widget CeoNameText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 24),
      child: TextFormField(
        //autofocus: true,
        maxLines: 1,
        minLines: 1,
        controller: ceoNameController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '대표자 성명',
            hintStyle: TextStyle(color: Color(0XFFCFD2D9), fontSize: 14)),
      ),
    );
  }
  Widget contentText() {

    return Padding(
        padding: const EdgeInsets.only(top: 2.0, left: 20 ,right:20),
        child: Container(
          height: 100,
          child: TextFormField(
            autofocus: true,
            maxLines: 10,
            minLines: 1,
            controller: _contextController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '수집하고자 하는 사진에 대한 자세한 설명을 추가해주세요.',
                hintStyle: TextStyle(color: Color(0XFFCFD2D9), fontSize: 14)),
          ),
        )
    );
  }

  bool objectSet = false;

  Widget _objectSetWidget() {
    //카테고리 설정에 따른 화면 버튼 위젯
    return Container(
      // color: Color(0xff3A94EE),
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < tags.length; i++)
            Padding(
              padding: EdgeInsets.only(right: 0),
              //height: 25.h,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                height: 10,
                child: Text(
                  tags[i],
                  style: bodySmallStyle(color: Colors.white),
                ),
                // Text("hi",
                //   style: bodySmallStyle(color: Colors.white),),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff3A94EE),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget ShowObject() {
    // 카테고리 스냅바 띄우기
    return ListTile(
      contentPadding: EdgeInsets.only(top: 0, left: 24, right: 22),
      onTap: () {
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
                            padding: EdgeInsets.fromLTRB(16, 36, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: ChipsChoice<String>.multiple(
                                    choiceStyle: C2ChipStyle.filled(
                                      color: Color(0xffF2F8FE),
                                      foregroundColor: Colors.grey,
                                      // clipBehavior: Clip.antiAlias,
                                      //   borderRadius: const BorderRadius.all(
                                      //     Radius.circular(50),
                                      //   ),
                                      selectedStyle: const C2ChipStyle(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Color(0xff3A94EE),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(100),
                                        ),
                                      ),
                                    ),
                                    value: tags,
                                    onChanged: (val) => setState2(() => tags = val),
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
                                    print(tags);
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
                                        print(tags);
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
      },
      leading: Container(
        padding: EdgeInsets.only(top: 2.5),
        child: Text('수집객체', style: bodyEmphasisStyle()),
      ),
      title: _objectSetWidget(),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Color(0XFFCFD2D9),
      ),
    );
  }

}


