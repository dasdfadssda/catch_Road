
import 'package:catch2_0_1/utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_switch/sliding_switch.dart';
import '../../utils/app_text_styles.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:percent_indicator/percent_indicator.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text('오늘의 캐치',style: titleMediumStyle(color: Colors.black),),
      ),
      body: Column(children: [
        Container(
          // margin: EdgeInsets.fromLTRB(10, 22, 24, 10),
          margin: EdgeInsets.only(top: size.height*0.03, bottom: size.height*0.03),
          child: Center(
                  // padding: EdgeInsets.only(top: size.height * 0.017),
                  child: SlidingSwitch(
                    value: false,
                    width: size.width * 0.9,
                    onChanged: (bool value) {
                      print(value);
                    },
                    height: 40,
                    
                    animationDuration: const Duration(milliseconds: 200),
                    onTap: () {},
                    onDoubleTap: () {},
                    onSwipe: () {},
                    textOff: "모든 프로젝트",
                    textOn: "참여 중인 프로젝트",
                    contentSize: 15,
                    colorOn: Color(0xff6682c0),
                    colorOff: const Color(0xff6682c0),
                    background: const Color(0xffe4e5eb),
                    buttonColor: const Color(0xfff7f5f7),
                    // inactiveColor: Colors.red,
                  ),
                ),
        ),
        Padding(
          padding:  EdgeInsets.only(right: size.width*0.6, bottom: size.height*0.03),
          child: Text("캐치가 추천해요!", style: titleSmallStyle(color: Color(0xff9FA5B2)),),
        ),
       
        Expanded(
          
          child: StreamBuilder<QuerySnapshot>(
            
        stream: FirebaseFirestore.instance.collection('project').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('  업로드 된\n글이 없어요 :(',style: labelLargeStyle(color: Color(0XFF9FA5B2)),));
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(left: size.width * 0.05, right : size.width * 0.05, bottom: size.height * 0.01),
                    child: Card(
                      
                      elevation: 0.2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: InkWell(
                              //카드 누르는 경우
                              onTap: (){},
                              child: Column(children: [
                                Padding(
                                  padding:  EdgeInsets.only(top: size.height * 0.03, right: size.width * 0.7),
                                  child: Text("D-" + snapshot.data!.docs[index]['final_day'].toString(), style: labelLargeStyle(color: Color(0xff9FA5B2)),),
                                ),
                                ListTile(
                                  title: Padding(
                                  padding:  EdgeInsets.only(top: size.height*0.01),
                                  child: Text(snapshot.data!.docs[index]['title'].toString(), style: titleMediumStyle(),),
                                ),
                                  subtitle: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xffF3F4F5),),
                                        
                                        margin: EdgeInsets.only(top: size.height*0.01),
                                        child: Padding(
                                          padding:  EdgeInsets.all(8),
                                          child: Text(snapshot.data!.docs[index]['type'].toString(), style: labelMediumStyle(color: Color(0xff9FA5B2)),),
                                        ),
                                      ),
                                      Padding(
                                        padding:  EdgeInsets.only(top: size.height * 0.01, left: size.width*0.02),
                                        child: Text(snapshot.data!.docs[index]['user'].toString(), style: labelMediumStyle(color: Color(0xff9FA5B2)),),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: size.width*0.05, bottom: size.height*0.03, top: size.height*0.01),
                                      width: size.width*0.60,
                                      height: size.height*0.01,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(16)),
                                        child: LinearProgressIndicator(
                                          value: snapshot.data!.docs[index]['percentage'].toDouble() *0.01,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3A94EE)),
                                          backgroundColor: Color(0xffE7E8EC),
                                        ),
                                      ),
                                    ),
                                   Padding(
                                     padding:  EdgeInsets.only(bottom: size.height*0.02, left: size.width*0.03),
                                     child: Image.asset('assets/coin.png', width: 25,),
                                   ),
                                   Padding(
                                     padding:  EdgeInsets.only(bottom: size.height*0.02, left: size.width*0.01),
                                     child: Text(snapshot.data!.docs[index]['cash'].toString() + "00"),
                                   )

                                  ],
                                ),
                              ]),
                            ),
                          ),
                  );
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border(
                        
                  //     )
                  //   ),
                  //   child: Column(children: [
                  //     Text(snapshot.data!.docs[index]['title'].toString()),
                  //     Text(snapshot.data!.docs[index]['final_day'].toString()),
                  //   ]),
                  // );
                }
                );
        }),
        )
      ]),
    );
  }
}
// class add_personal extends StatefulWidget {
//   const add_personal({super.key});

//   @override
//   State<add_personal> createState() => _add_personalState();
// }

// class _add_personalState extends State<add_personal> {
//     final contentsController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Color(0x9FA5B2),
//           leading: TextButton(
//             style: TextButton.styleFrom(
//               minimumSize: Size.zero,
//               padding: EdgeInsets.zero,
//               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text("취소", style: TextStyle(color: Color(0xff9FA5B2))),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {},
//               child: Padding(
//                 padding: EdgeInsets.only(right: size.width * 0.03),
//                 child: Text(
//                   "업로드",
//                   style: TextStyle(color: primary[50]),
//                 ),
//               ),
//               style: TextButton.styleFrom(
//                 minimumSize: Size.zero,
//                 padding: EdgeInsets.zero,
//                 tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//               ),
//             )
//           ],
//           title: Text("개인 프로젝트 올리기")),
//       body: Column(children: [
//         Padding(
//           padding: EdgeInsets.only(
//               top: size.height * 0.05,
//               left: size.width * 0.06,
//               right: size.width * 0.06),
//           child: TextFormField(
//             cursorColor: Color(0xffBCBCBC),
//             decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xffCFD2D9)),
//               ),
//               contentPadding: EdgeInsets.only(left: size.width * 0.02),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: Color(0xffCFD2D9)),
//               ),
//               focusColor: Colors.transparent,
//               hintText: '프로젝트 이름',
//             ),
//             onSaved: (String? value) {
//               // This optional block of code can be used to run
//               // code when the user saves the form.
//             },
//           ),
//         ),
//         // TextButton(onPressed: () {}, child: Text("수집 객체"))
//         Padding(
//           padding: EdgeInsets.only(
//               left: size.width * 0.045, right: size.width * 0.045),
//           child: ListTile(
//             trailing: Padding(
//               padding: EdgeInsets.only(right: size.width * 0.02),
//               child: Icon(
//                 Icons.keyboard_arrow_right,
//                 size: 35,
//                 color: Color(0xffCFD2D9),
//               ),
//             ),
//             onTap: () {
//               _showcategoryicker(context);
//             },
//             title: Text("수집 객체"),
//           ),
//         ),
//         Image.asset('assets/divider.png', width: size.width * 0.88),
//         Padding(
//           padding: EdgeInsets.only(
//               left: size.width * 0.045, right: size.width * 0.045),
//           child: ListTile(
//             trailing: Padding(
//               padding: EdgeInsets.only(right: size.width * 0.02),
//               child: Text("총 100 캐시"),
//             ),
//             onTap: () {},
//             title: Text("최대 50장  X  장 당 캐시",
//                 style: TextStyle(color: Color(0xffCFD2D9))),
//           ),
//         ),
//         Image.asset('assets/divider.png', width: size.width * 0.88),
//         Padding(
//           padding: EdgeInsets.only(
//               left: size.width * 0.045, right: size.width * 0.045),
//           child: ListTile(
//             trailing: Padding(
//               padding: EdgeInsets.only(right: size.width * 0.02),
//               child: Icon(
//                 Icons.keyboard_arrow_right,
//                 size: 35,
//                 color: Color(0xffCFD2D9),
//               ),
//             ),
//             onTap: () {},
//             title: Text("프로젝트 기간"),
//           ),
//         ),
//         Image.asset('assets/divider.png', width: size.width * 0.88),
//         Padding(
//           padding: EdgeInsets.only(
//               left: size.width * 0.045, right: size.width * 0.045),
//           child: ListTile(
//             trailing: Padding(
//               padding: EdgeInsets.only(right: size.width * 0.02),
//               child: Icon(
//                 Icons.keyboard_arrow_right,
//                 size: 35,
//                 color: Color(0xffCFD2D9),
//               ),
//             ),
//             onTap: () {},
//             title: Text("예시 사진 추가"),
//           ),
//         ),
//         Image.asset('assets/divider.png', width: size.width * 0.88),
//         Padding(
//           padding: EdgeInsets.only(
//               left: size.width * 0.045, right: size.width * 0.045),
//           child: ListTile(
//             // onTap: () {},
//             subtitle: Padding(
//               padding: EdgeInsets.only(top: size.height * 0.015),
//               // child: Text("수집하고자 하는 사진에 대한 자세한 설명을 추가해주세요 !",
//               //     style: TextStyle(color: Color(0xffCFD2D9))),
//               child: TextFormField(
//                maxLines: 100,
//                minLines: 1,
//               controller: contentsController,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: '수집하고자 하는 사진에 대한 자세한 설명을 추가해주세요 !',hintStyle:TextStyle(color:Color(0XFFCFD2D9),fontSize: 14)
//               ),
//             ),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
//   final List myProducts =["사람","오토바이","자동차","스쿠터","자전거","버스","기차","신호등","트럭","정지 표시판","어린이 보호 구역"];
//   final List myProductChoose = [false,false,false,false,false,false,false,false,false,false,false,];

//  void _showcategoryicker(context) { // 카테고리 설정 스냅바
//     showModalBottomSheet(
//                 context: context,
//                 shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(30),
//                   ),
//                 ),
//                 builder: (BuildContext context) {
//                   return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState) {
//                     return Column(children: [
//                       Expanded(
//                         child: GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4, 
//                         childAspectRatio: 1 /0.4
//                         ),
//                         itemCount: myProducts.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           height: 10,
//                           // myProductChoose[index] ? Color(0XFF3A94EE) : Colors.white,
//                           //       onPrimary: myProductChoose[index]? Colors.white : Color(0XFF9FA5B2) ,
//                           child: ElevatedButton(
//                             child: Text(myProducts[index].toString()),
//                             onPressed: (){setState(() {
//                               if(myProductChoose[index] == true){
//                                 myProductChoose[index] = false;
//                               } else {
//                                 myProductChoose[index] = true;
//                               }
//                             });},
//                             ),
//                         );
//                       }
//                       ),
//                       )
//                     ],);
//                   });
//                 },
//               );
//   }
// }
