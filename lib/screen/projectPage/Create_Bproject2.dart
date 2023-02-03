import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../utils/widget.dart';

class CreateBproject2 extends StatefulWidget {
  const CreateBproject2({Key? key}) : super(key: key);

  @override
  State<CreateBproject2> createState() => _CreateBproject2State();
}

class _CreateBproject2State extends State<CreateBproject2> {
  bool _road = true;
  bool _catch = false;

  // multiple choice value
  List<String> tags = [];

  // list of string options
  List<String> options = ['자전거','자동차','오토바이','버스','기차','신호등','트럭','소화전','정지표지판','벤치','고양이','개'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title:Text("기업 프로젝트 의뢰하기"),
      ),
      body: Column(
        children: [
          TitleText(),
          MyWidget().DivderLine(),
          ShowObject(),
          MyWidget().DivderLine(),
          CeoNameText(),
        ],
      ),
    );
  }

  final companyNameController = TextEditingController();

  Widget TitleText() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 24),
      child: TextFormField(
        //autofocus: true,
        maxLines: 1,
        minLines: 1,
        controller: companyNameController,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '업체명',
            hintStyle: TextStyle(color: Color(0XFFCFD2D9), fontSize: 14)),
      ),
    );
  }

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
              child:



              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                height: 10,
                child:
                    Text(
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
                                    style:
                                    buttonLargeStyle().copyWith(color: primary[50]),
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

  void _showobjectpicker(context) {
    // 카테고리 설정 스냅바

  }
}

//업체명

// bool _objectSet = true;
// Widget ShowCategory() {
//   // 카테고리 스냅바 띄우기
//   return ListTile(
//     contentPadding: EdgeInsets.only(top: 0, left: 24, right: 22),
//     onTap: (){
//       showModalBottomSheet(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(30),
//                 topLeft: Radius.circular(30),
//               )
//           ),
//           isScrollControlled: true,
//           context: context,
//           builder: (BuildContext context) {
//             return StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//                   return SizedBox(
//                       height: MediaQuery.of(context).size.height * 0.45,
//                       child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.fromLTRB(16,36,16,0 ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: <Widget>[
//                                   Flexible(
//                                     fit: FlexFit.loose,
//                                     child: ChipsChoice<String>.multiple(
//                                       choiceStyle: C2ChipStyle.filled(
//                                         color:Color(0xffF2F8FE),
//                                         foregroundColor: Colors.grey,
//                                         // clipBehavior: Clip.antiAlias,
//                                         //   borderRadius: const BorderRadius.all(
//                                         //     Radius.circular(50),
//                                         //   ),
//                                         selectedStyle: const C2ChipStyle(
//                                           foregroundColor: Colors.white,
//                                           backgroundColor: Color(0xff3A94EE),
//                                           borderRadius: const BorderRadius.all(
//                                             Radius.circular(100),
//                                           ),
//                                         ),
//                                       ),
//                                       value: tags,
//                                       onChanged: (val) => setState(() => tags = val),
//                                       choiceItems: C2Choice.listFrom<String, String>(
//                                         source: options,
//                                         value: (i, v) => v,
//                                         label: (i, v) => v,
//                                         tooltip: (i, v) => v,
//                                       ),
//                                       choiceCheckmark: true,
//                                       wrapped: true,
//
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             Container(
//                               padding: EdgeInsets.fromLTRB(
//                                   30,0,30,0 ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   TextButton(child:Text("취소", style: buttonLargeStyle().copyWith(color:Color(0XFF9FA5B2)),),onPressed: (){
//                                     print(tags);
//                                   },),
//                                   TextButton(child:Text("확인", style: buttonLargeStyle().copyWith(color:primary[50]),),
//                                     onPressed: (){
//
//
//                                       setState(() {
//                                         _objectSet=true;
//                                         Navigator.pop(context);
//
//
//                                       });
//
//
//                                     },),
//                                   //background: #9FA5B2;
//                                 ],
//                               ),
//                             ),
//                           ]));
//                 }
//             );
//
//           });
//
//     },
//     title: _objectSet ? _objectSetWidget() : Text(''),
//     leading: Container(
//       padding: EdgeInsets.only(top: 0),
//       margin:EdgeInsets.only(top: 0),
//       child: Text('카테고리 설정하기', style: bodyMediumStyle()),
//     ),
//     //title: _catagorySet ? _catagorySetWidget() : Text(''),
//     trailing: Icon(
//       Icons.arrow_forward_ios,
//       color: Color(0XFFCFD2D9),
//     ),
//   );
// }
