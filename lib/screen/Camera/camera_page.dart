import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';
import '../../main.dart';
import '../mainHome.dart';
import 'camera_bndbox.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'camera_viewer.dart';
import 'image_convert.dart';
import 'package:image/image.dart' as imageLib;

var globalKey = new GlobalKey();
String mode = "auto";
var c_object_list = [];
List eng_objectList=[];

String bike="자전거";

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraPage(this.cameras);

  @override
  _CameraPageState createState() => new _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<dynamic> _recognitions = [];
  int _imageHeight = 0;
  int _imageWidth = 0;
  bool objectSelect = false;





  String _model = 'SSD MobileNet';
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // print("영어로 바꾸기");
    for (int i = 0; i < user_object.length; i++) {
      print(user_object[i]);
      if (user_object[i] == "자전거") {
        if(!eng_objectList.contains("bicycle")) eng_objectList.add("bicycle");
      }
      if (user_object[i] == "자동차") {
        if(!eng_objectList.contains("car"))eng_objectList.add("car");
      }
      if (user_object[i] == "오토바이") {

        if(!eng_objectList.contains("motorcycle")) eng_objectList.add("motorcycle");
      }
      if (user_object[i] == "버스") {
        if(!eng_objectList.contains("bus"))eng_objectList.add("bus");
      }
      if (user_object[i] == "신호등") {
        if(!eng_objectList.contains("traffic light")) eng_objectList.add("traffic light");
      }
      if (user_object[i] == "기차") {
        if(!eng_objectList.contains("train")) eng_objectList.add("train");
      }
      if (user_object[i] == "트럭") {
        if(!eng_objectList.contains("truck")) eng_objectList.add("truck");
      }
      if (user_object[i] == "소화전") {
        if(!eng_objectList.contains("fire hydrant"))eng_objectList.add("fire hydrant");
      }
      if (user_object[i] == "정지표지판") {
        if(!eng_objectList.contains("stop sign"))eng_objectList.add("stop sign");
      }
      if (user_object[i] == "벤치") {
        if(!eng_objectList.contains("bench"))eng_objectList.add("bench");
      }
      if (user_object[i] == "고양이") {
        if(!eng_objectList.contains("cat"))eng_objectList.add("cat");
      }
      if (user_object[i] == "개") {
        if(!eng_objectList.contains("dog"))eng_objectList.add("dog");
      }
      if (user_object[i] == "키보드") {
        if(!eng_objectList.contains("keyboard"))eng_objectList.add("keyboard");
      }
    }



    onSelect("SSDMobileNet");
  }

  @override
  Future<void> noauto_takepicture() async {
    print('is saving1 : $issaving');
    CameraImage image = cameraImage2;
    try {
      imageLib.Image img = convertYUV420ToImage(image);
      imageLib.PngEncoder pngEncoder =
          new imageLib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);

      //firebase에 저장
      final uploadTask = await storage
          .ref(
              '/traffic-Image/notclassified/notclassified${DateTime.now()}.png')
          .putData(Uint8List.fromList(png)); //
      final url = await uploadTask.ref.getDownloadURL();
      try {
        await FirebaseFirestore.instance
            .collection("category")
            .doc("1234@handong.ac.kr")//FirebaseAuth.instance.currentUser!.email
            .collection("category")
            .doc("notclassified").set({
          "category":"notclassified",
          "new": url,
          "order":6,
          "num":0,
        });

        await FirebaseFirestore.instance
            .collection("category")
            .doc(
                "1234@handong.ac.kr") //FirebaseAuth.instance.currentUser!.email
            .collection("notclassified")
            .add({
          "url": url,
          "time": DateFormat('dd/MM/yyyy').format(DateTime.now())
        });
        await FirebaseFirestore.instance
            .collection("category")
            .doc(
                "1234@handong.ac.kr") //FirebaseAuth.instance.currentUser!.email
            .collection("all")
            .add({
          "url": url,
          "time": DateFormat('dd/MM/yyyy').format(DateTime.now())
        });
      } catch (e) {
        print(e);
      }
      setState(() {
        issaving = false;
      });
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/ssd_mobilenet.tflite",
        labels: "assets/model/ssd_mobilenet.txt");
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic userInform2;



    return Scaffold(
      body: Stack(
        children: [
          CameraViewer(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          issaving
              ? Container()
              : BndBox(
                  _recognitions == null ? [] : _recognitions,
                  math.max(_imageHeight, _imageWidth),
                  math.min(_imageHeight, _imageWidth),
                  MediaQuery.of(context).size.height,
                  MediaQuery.of(context).size.width,
                  _model),
          objectSelect
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.vertical(bottom:Radius.circular(30))),
                  //color: Colors.black.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width,
                  height: 360,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: Icon(
                                  Icons.clear_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 310),
                            GestureDetector(
                              onTap: () {
                                setState(() {

                                  objectSelect = false;



                                });
                              },
                              child: SizedBox(
                                height: 24,
                                width: 24,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.directions_bike_outlined,
                                    color: user_object.contains("자전거")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('자전거',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("자전거")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.car_crash_outlined,
                                    color: user_object.contains("자동차")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('자동차',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("자동차")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.directions_bus,
                                    color: user_object.contains("버스")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('버스',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("버스")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),



                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.motorcycle_sharp,
                                    color: user_object.contains("오토바이")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('오토바이',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("오토바이")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.traffic_rounded,
                                    color: user_object.contains("신호등")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('신호등',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("신호등")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.train,
                                    color: user_object.contains("기차")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('기차',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("기차")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.fire_truck,
                                    color: user_object.contains("트럭")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('트럭',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("트럭")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.fire_hydrant,
                                    color: user_object.contains("소화전")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('소화전',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("소화전")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.stop_circle_rounded,
                                    color: user_object.contains("정지표시판")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('표지판',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("정지표시판")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),



                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.chair_alt,
                                    color: user_object.contains("벤치")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('벤치',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("벤치")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.adb_outlined,
                                    color: user_object.contains("고양이")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text('고양이',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                        user_object.contains("고양이")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),
                            SizedBox(width: 16,),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 100,
                              height: 50,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    size: 30,
                                    Icons.adb_outlined,
                                    color: user_object.contains("개")
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text('개',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: user_object.contains("개")
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),

                                ],
                              ),
                            ),



                          ],
                        ),


                      ],
                    ),
                  )
          )
              : Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.vertical(bottom:Radius.circular(0))),
              //color: Colors.black.withOpacity(0.6),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*(80/800),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(

                      children: [
                        SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 310),
                        GestureDetector(
                          onTap: () {
                            setState(() {

                              objectSelect = true;



                            });
                          },
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: Icon(
                              Icons.check_box_outline_blank,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),



                  ],
                ),
              )
          ),
          // Container(
          //         color: Colors.black.withOpacity(0.6),
          //         width: MediaQuery.of(context).size.width,
          //         height: 96,
          //         child: Column(
          //           children: [
          //             SizedBox(
          //               height: 45,
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(width: 24),
          //                 GestureDetector(
          //                   onTap: () {
          //                     Navigator.of(context).pop();
          //                   },
          //                   child: SizedBox(
          //                     height: 24,
          //                     width: 24,
          //                     child: Icon(
          //                       Icons.clear_rounded,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(width: 320),
          //                 GestureDetector(
          //                   onTap: () {
          //                     setState(() {
          //                       objectSelect = true;
          //
          //                     });
          //                   },
          //                   child: SizedBox(
          //                     height: 24,
          //                     width: 24,
          //                     child: Icon(
          //                       Icons.check_box_outline_blank,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             )
          //           ],
          //         )),
          mode == "noauto"
              ? Positioned(
                  bottom: 80,
                  left: 160,
                  child: GestureDetector(
                    onTap: () async {
                      ob=object;
                      setState(() {
                        issaving = true;
                      });
                      print('clicked!!');
                      noauto_takepicture();
                     // takepicture();
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {
                        issaving = false;
                      });
                      setState(() {saved = true;});
                      await Future.delayed(Duration(seconds: 1));
                      setState(() {saved = false;});
                    },
                    child: SizedBox(
                      width: 45,
                      child: Image.asset('assets/camera_button.png'),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     size: 60,
                  //     color: Colors.white,
                  //     Icons.circle_rounded,
                  //   ),
                  //   onPressed: () async {
                  //     setState(() {
                  //       issaving = true;
                  //     });
                  //     print('clicked!!');
                  //     takepicture();
                  //     await Future.delayed(Duration(seconds: 1));
                  //     setState(() {
                  //       issaving = false;
                  //     });
                  //   },
                  // ),
                )
              : Container(),
          Positioned(
            bottom: 0,
            child: Container(
                color: Colors.black.withOpacity(0.6),
                width: MediaQuery.of(context).size.width,
                height: 58,
                child: mode == "auto"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 60),
                          TextButton(
                            child: Text(
                              '수동촬영',
                              style: TextStyle(
                                color: mode == "noauto"
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            onPressed: () {
                              setState(() {
                                mode = "noauto";
                              });
                            },
                          ),
                          SizedBox(width: 40),
                          TextButton(
                            child: Text(
                              '자동인식',
                              style: TextStyle(
                                color: mode == "auto"
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            onPressed: () {
                              setState(() {
                                mode = "auto";
                              });
                            },
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 60),
                          TextButton(
                            child: Text(
                              '자동인식',
                              style: TextStyle(
                                color: mode == "auto"
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            onPressed: () {
                              setState(() {
                                mode = "auto";
                              });
                            },
                          ),
                          SizedBox(width: 40),
                          TextButton(
                            child: Text(
                              '수동촬영',
                              style: TextStyle(
                                color: mode == "noauto"
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                              textAlign: TextAlign.start,
                            ),
                            onPressed: () {
                              setState(() {
                                mode = "noauto";
                              });
                            },
                          ),
                        ],
                      )),
          ),
        ],
      ),
    );
  }
}
