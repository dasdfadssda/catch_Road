import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';
import 'camera_bndbox.dart';
import 'package:flutter/rendering.dart';
import 'camera_viewer.dart';
import 'image_convert.dart';
import 'package:image/image.dart' as imageLib;

var globalKey = new GlobalKey();
String mode = "auto";
var object_list = [];

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
    onSelect("SSDMobileNet");
  }

  @override
  Future<void> takepicture() async {
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
                      borderRadius: BorderRadius.circular(30.0)),
                  //color: Colors.black.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width,
                  height: 390,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 24),
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
                          SizedBox(width: 269),
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
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(top: 17),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: 148,
                              height: 80,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        size: 30,
                                        Icons.person,
                                        color: object_list.contains("person")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('사람',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                object_list.contains("person")
                                                    ? Colors.blue
                                                    : Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 9),
                                      Icon(
                                        size: 24,
                                        Icons.check,
                                        color: object_list.contains("person")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (object_list.contains("person")) {
                                  object_list.remove("person");
                                } else {
                                  object_list.add("person");
                                }
                                print(object_list);
                              });
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(top: 17),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: 148,
                              height: 80,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        size: 30,
                                        Icons.car_crash_outlined,
                                        color: object_list.contains("car")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('자동차',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: object_list.contains("car")
                                                ? Colors.blue
                                                : Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 9),
                                      Icon(
                                        size: 24,
                                        Icons.check,
                                        color: object_list.contains("car")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (object_list.contains("car")) {
                                  object_list.remove("car");
                                } else {
                                  object_list.add("car");
                                }
                                print(object_list);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(top: 17),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              width: 148,
                              height: 80,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        size: 30,
                                        Icons.motorcycle_sharp,
                                        color:
                                            object_list.contains("motorcycle")
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('오토바이',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: object_list
                                                    .contains("motorcycle")
                                                ? Colors.blue
                                                : Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 18),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 9),
                                      Icon(
                                        size: 24,
                                        Icons.check,
                                        color:
                                            object_list.contains("motorcycle")
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (object_list.contains("motorcycle")) {
                                  object_list.remove("motorcycle");
                                } else {
                                  object_list.add("motorcycle");
                                }
                                print(object_list);
                              });
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(top: 17),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: 148,
                              height: 80,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        size: 30,
                                        Icons.directions_bus_filled_sharp,
                                        color: object_list.contains("bus")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('버스',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: object_list.contains("bus")
                                                ? Colors.blue
                                                : Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 9),
                                      Icon(
                                        size: 24,
                                        Icons.check,
                                        color: object_list.contains("bus")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (object_list.contains("bus")) {
                                  object_list.remove("bus");
                                } else {
                                  object_list.add("bus");
                                }
                                print(object_list);
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(top: 17),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: 148,
                              height: 80,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        size: 30,
                                        Icons.pedal_bike_outlined,
                                        color: object_list.contains("bicycle")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('자전거',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                object_list.contains("bicycle")
                                                    ? Colors.blue
                                                    : Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 9),
                                      Icon(
                                        size: 24,
                                        Icons.check,
                                        color: object_list.contains("bicycle")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (object_list.contains("bicycle")) {
                                  object_list.remove("bicycle");
                                } else {
                                  object_list.add("bicycle");
                                }
                                print(object_list);
                              });
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Container(
                              padding: EdgeInsets.only(top: 17),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0)),
                              width: 148,
                              height: 80,
                              //   color:Colors.white,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 38,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        size: 30,
                                        Icons.traffic_rounded,
                                        color: object_list
                                                .contains("traffic light")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text('신호등',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: object_list
                                                    .contains("traffic light")
                                                ? Colors.blue
                                                : Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 9),
                                      Icon(
                                        size: 24,
                                        Icons.check,
                                        color: object_list
                                                .contains("traffic light")
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if (object_list.contains("traffic light")) {
                                  object_list.remove("traffic light");
                                } else {
                                  object_list.add("traffic light");
                                }
                                print(object_list);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ))
              : Container(
                  color: Colors.black.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width,
                  height: 96,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 24),
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
                          SizedBox(width: 269),
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
                      )
                    ],
                  )),
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
                      takepicture();
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
