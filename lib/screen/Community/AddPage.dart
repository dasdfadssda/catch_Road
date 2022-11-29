
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kpostal/kpostal.dart';
// import 'package:geocoding/geocoding.dart';


import '../../Auth/auth_service.dart';
import '../../utils/widget.dart';
import '../mainHome.dart';
import 'HomePage.dart';



class AddPage extends StatelessWidget {
  const AddPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


bool _road = true;
bool _catch = false;

final category = "";

var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
        appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: TextButton (
        child: Text('취소',style: SubTitleStyle(color: Color(0XFF9FA5B2))),
        onPressed: () {
          _showcategoryCancel(context);
        },
      ),
      title: Text('질문하고 싶어요',style: titleMediumStyle()),
      actions: [
        TextButton(
              onPressed: () async{
                await Future.delayed(Duration(seconds: 1));
                _showcategoryUPload(context);
              },
              child: Text('업로드',style: SubTitleStyle(color: Color(0XFF3A94EE))))
      ],
    ),
        body: Column(children: [
          ShowCategory(),
          MyWidget().DivderLine(),
          ShowTakePicture(),
          MyWidget().DivderLine(),
          Addlocation(),
          MyWidget().DivderLine(),
          TitleText(),
        ],)
    );
  }

  final contentsController = TextEditingController();

  Widget TitleText() { // 글 제목
    return Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 24),
            child: TextFormField(
               maxLines: 100,
               minLines: 1,
              controller: contentsController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '물어보고 싶었던 질문을 자유롭게 올려보아요 :) \n \n \n예시) 000동에 주차할 공간 있어?',hintStyle:TextStyle(color:Color(0XFFCFD2D9),fontSize: 14)
              ),
            ),
          );
  }

  bool _catagorySet = false;
  
    Widget ShowCategory() { // 카테고리 스냅바 띄우기
    return ListTile(
      contentPadding: EdgeInsets.only(top: 42,left: 24,right: 22),
      onTap: (() => _showcategoryicker(context)),
      leading: Container(
        padding: EdgeInsets.only(top: 2.5),
        child: Text('카테고리 설정하기',style: bodyMediumStyle()),
      ),
      title:  _catagorySet ? _catagorySetWidget() : Text(''),
      trailing:  Icon(Icons.arrow_forward_ios,color: Color(0XFFCFD2D9),),
    );
  }

    Widget _catagorySetWidget() { //카테고리 설정에 따른 화면 버튼 위젯
    return Container(
      margin: EdgeInsets.fromLTRB(50, 0, 8, 3),
      padding: _road ? EdgeInsets.fromLTRB(14, 8.5, 14, 7) : EdgeInsets.fromLTRB(15, 8.5, 15, 7),
      height: 30,
      child: _road ? Text('도로 위가 궁금해요',style:  labelSmallStyle(color: Colors.white)) : Text('캐치가 궁금해요',style: labelSmallStyle(color: Colors.white), textAlign: TextAlign.center,),
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(100),
          color: Color(0XFF3A94EE),
        ),
    );
  }
  
   void _showcategoryicker(context) { // 카테고리 설정 스냅바
    showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState) {
                    return Container(
                      height: 220,
                      child: Column(
                        children: [
                           Container(
      margin: EdgeInsets.fromLTRB(22, 40, 244, 0),
      child: Text('카테고리 설정하기',style: labelMediumStyle())
      ),
        Container(
          margin: EdgeInsets.fromLTRB(42, 12, 26, 0),
          child: Row(children: [ // 버튼 부분 
 Container(
   width: 151,
   child: ElevatedButton(
           style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8.0),
               ),
             elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 14, ),
            primary: _road ? Color(0XFF3A94EE) : Colors.white,
            onPrimary: _road? Colors.white : Color(0XFF9FA5B2) ,
          ),
           onPressed: (){
             bottomState((){
               setState(() {
                final category = "도로 위가 궁금해요";
             _road = true;
             _catch = false;
             });
             });
           }, 
       child: Text('도로 위가 궁금해요')),
 ),
     SizedBox(width: 6,),
     Container(
       width: 140,
      //  height: 200,
       child: ElevatedButton(
           style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8.0),
               ),
             elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 14, ),
            primary: _catch ? Color(0XFF3A94EE) : Colors.white,
            onPrimary: _catch? Colors.white : Color(0XFF9FA5B2) ,
            
          ),
           onPressed: (){
             bottomState((){
               setState(() {
             final category = "캐치가 궁금해요";
             _road = false;
             _catch = true;
             });
             });
       }, 
       child: Text('캐치가 궁금해요')),
     ),
   ]),
        ), 
        Container( // 카테고리 취소 확인 버튼 부분
          margin: EdgeInsets.fromLTRB(35, 26, 33,0),
          child: Row(
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                  child: Text('취소',style: labelSmallStyle(color: Color(0XFF9FA5B2))),),
                  SizedBox(width: 180),
                  TextButton(
                onPressed: (){
                  setState(() {
                    _catagorySet = true; 
                     Navigator.pop(context);
                  });
                },
                  child: Text('확인',style: labelSmallStyle(color: Color(0XFF3A94EE))),),
            ],
          ),
        )
                        ],
                      ),
                    );
                  });
                },
              );
  }


   final List<XFile>? _selectedFileList = []; // 사진 불러오기 
   final ImagePicker _picker = ImagePicker();  
   List<String> _arrImageUrls=[];


 void selectImages() async {  // 사진 추가 함수
 print('사진 고르기');
   final List<XFile>? img = await _picker.pickMultiImage();
   setState(() {
    if (img!.isNotEmpty) {
      _selectedFileList!.addAll(img);
    }else {
      print("사진 없엉");
    }
     print("사진 수 : ${_selectedFileList!.length}");
    
   });
  }

  void deleteImage(index) async { // 사진 삭제 함수
    setState(() {
          final Removek = _selectedFileList!.removeAt(index);
    });
  }

  void UploadFunction(List<XFile> _image)  async{
    for(int i=0; i< _image.length; i++) {
     await uploadFile(_image[i]);
    }

  }

  Future<List> uploadFile(XFile _image) async{  // 사진 url 업로드 하기 

  final firebaseStorageRef = FirebaseStorage.instance; 

    Reference reference =
    firebaseStorageRef.ref().child("사진").child(_image.name);

     UploadTask uploadTask = reference.putFile(File(_image.path));
           TaskSnapshot taskSnapshot = await uploadTask;

         var downloadUrl = await taskSnapshot.ref.getDownloadURL().whenComplete((){ 
         });  

      _arrImageUrls.add(downloadUrl);
     print("url 리스트 저장 완료 : ${_arrImageUrls}");
     return  _arrImageUrls;
  }



   Widget ShowTakePicture() { // 사진 가져오기 스냅바 + 화면 
    if(_selectedFileList!.length == 0) {
      return  ListTile(
      contentPadding: EdgeInsets.only(top: 11,left: 24,right: 32),
      onTap: () {
         print('사진 고르기');
        selectImages();
      },
      leading: Text('예시 사진 추가',style: bodyMediumStyle()),
      trailing:  Icon(Icons.arrow_forward_ios,color: Color(0XFFCFD2D9),),
    );
    } else return
     Container(
       height: 140,
       child: Column(
         children: [
      Container(
        padding: EdgeInsets.fromLTRB(24, 12, 32, 0),
        child: Row(children: [
          Text('예시 사진 추가',style: bodyMediumStyle()),
          SizedBox(width: 228,),
          Icon(Icons.arrow_forward_ios,color: Color(0XFFCFD2D9)),
        ],),
      ),
    Container(
      height: 85,
      child:GridView.builder(
                    itemCount: _selectedFileList!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                 childAspectRatio : 1/1,
                                  crossAxisCount: 4
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return  Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)
                                      ),
                                    child: Stack(children: [
                                      Container(
                                        // color: Colors.amber,
                                        margin: EdgeInsets.only(left: 20,right: 20,bottom: 20,top: 20),
                                        height: 80, width: 80,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.file(File(_selectedFileList![index].path), fit: BoxFit.fill),)
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                        onPressed: (){
                                          deleteImage(index);
                                        },
                                        icon: Icon(Icons.cancel,color: Colors.grey))),
                                    ]),
                                  );
                                }
                            ),
    ),
         ],
       ),
     );
  }

 
  String postCode = '-';
  String roadAddress = '-';
  String jibunAddress = '-';
  String latitude = '-';
  String longitude = '-';
  String kakaoLatitude = '-';
  String kakaoLongitude = '-';
  double _latitude = 0.0;// 위도
  double _longitude = 0.0; //경도

   Widget Addlocation() { // 위치 가져오기 
    if(postCode == '-') {
      return ListTile(
      contentPadding: EdgeInsets.only(top: 11,left: 24,right: 32),
      onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => KpostalView(
                      useLocalServer: true,
                      localPort: 1024,
                      // kakaoKey: '{3a0cc0c68dbebf5acfb1116770603d72}',
                      callback: (Kpostal result) {
                        setState(() {
                          this.postCode = result.postCode;
                          this.roadAddress = result.address;
                          this.jibunAddress = result.jibunAddress;
                          this.latitude = result.latitude.toString();
                          this.longitude = result.longitude.toString();
                         _longitude = double.parse('${this.latitude}');
                          _latitude = double.parse('${this.longitude}');
                          print(_longitude);
                          print(_latitude);
                        });
                      },
                    ),
                  ),
                );
      },
      leading: Text('도로 위치 추가 ',style: bodyMediumStyle()),
      trailing:  Icon(Icons.arrow_forward_ios,color: Color(0XFFCFD2D9),),
    );
    } else {
      return Container(
        height: 143,
        child: Column(children: [
          Container(
        padding: EdgeInsets.fromLTRB(24, 13, 32, 0),
        child: Row(children: [
          Text('도로 위치 추가',style: bodyMediumStyle()),
          SizedBox(width: 228,),
          Icon(Icons.arrow_forward_ios,color: Color(0XFFCFD2D9)),
        ],),
      ),
      Stack(children: [
        Container(
          child: Row(children: [
            Container(
              child: Image.asset('assets/map.png'),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text('${roadAddress}',style: labelMediumStyle(),),
            )
          ],),
        height: 60, 
        margin: EdgeInsets.fromLTRB(27, 20, 45, 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0XFFE7E8EC), spreadRadius: 1),
            ],
          ),
        ),
        Align(
           alignment: Alignment.topRight,
           child: Container(
             margin: EdgeInsets.only(right: 25),
             child: IconButton(
               onPressed: (){
                 setState(() {
                  print(postCode);
                    postCode = '-';
                    roadAddress = '-';
                    jibunAddress = '-';
                    latitude = '-';
                    longitude = '-';
                    kakaoLatitude = '-';
                    kakaoLongitude = '-';
                    _latitude = 0.0;    // 위도
                    _longitude = 0.0;   //경도
                    print("${postCode} 삭제했다.");
               });},
                 icon: Icon(Icons.cancel,color: Colors.grey)),
           )),
      ],)
        ]),
      );
    }
  }

 void _showcategoryCancel(context) { // 나가기 관련 스냅바
   showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                 builder: (BuildContext context) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState) {
                    return Container(
                      height: 202,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(24, 40, 24, 27),
                          child: Text("작성 중인 질문을 하지 않으시겠습니까?\n       진행상황은 저장되지 않습니다.",style: labelMediumStyle(),),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(39, 0, 39, 50),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: (){
                                   Navigator.pop(context);
                                   },
                                   child: Text('취소',style: labelSmallStyle(color: Color(0XFF9FA5B2))),),
                                   SizedBox(width: 170),
                              TextButton(
                                  onPressed: (){
                                    setState(() {
                                      _catagorySet == null;
                                      postCode = '-';
                                      _arrImageUrls.clear();
                                      contentsController.clear();
                                     Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MainHomePage()),
                                    );
                                    });
                                  },
                                    child: Text('확인',style: labelSmallStyle(color: Color(0XFF3A94EE))),),
                        ],
          ),
                        )
                      ]),
                    );
                    }
                );
             }
          );
      }

void _showcategoryUPload(context) { // 업로드 관련 스냅바
   showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                 builder: (BuildContext context) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter bottomState) {
                    return Container(
                      height: 380,
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(100, 40, 100, 20),
                          child: Image.asset('assets/checkToFinish.gif',height: 160,width: 160,),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(24, 0, 24, 28),
                          child: Text("질문이 업로드 되었습니다.",style: labelSmallStyle(),),
                        ),
                        Container(
                          height: 40,
                          width: 312,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: Color(0XFF3A94EE)
                            ),
                          margin: EdgeInsets.fromLTRB(46, 0, 46, 50),
                          child:  TextButton(
                                  onPressed: (){
                                    setState(() async{
                                     Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                      print('데이터 전송 시작');
                                    UploadFunction(_selectedFileList!);
                                    await Future.delayed(Duration(seconds: 25));
                                    contentsFunction(FirebaseAuth.instance.currentUser!.displayName!,_road,_arrImageUrls,contentsController,roadAddress);
                                      _road == null;
                                      postCode = '-';
                                      _arrImageUrls.clear();
                                      contentsController.clear();
                                    });
                                  },
                                    child: Text('확인',style: labelSmallStyle(color: Colors.white)))
                        )
                      ]),
                    );
                    }
                );
             }
          );
      }
}

