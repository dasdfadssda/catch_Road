import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import '../../main.dart';
import '../mainHome.dart';
import 'camera_bndbox.dart';
import 'package:image/image.dart' as imageLib;
import 'camera_page.dart';
import 'image_convert.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

XFile? pictureFile;
XFile? imgFile;
CameraImage? cameraImage;
late CameraImage cameraImage2;
late List<int> pngfile;
late String path;
late CameraController controller;

List<Uint8List> imageList = [];
bool issaving = false;
bool saved = false;
String ob = '';
// dynamic cameraUserInform = [];
// List camera_objectList = [];
//List eng_objectList = [];

typedef void Callback(List<dynamic> list, int h, int w);

class CameraViewer extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;
  CameraImage? cameraImage;

  CameraViewer(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraViewerState createState() {
    issaving = false;
    return _CameraViewerState();
  }
}

class _CameraViewerState extends State<CameraViewer> {
  bool isDetecting = false;
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<Coordinates> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final cor = new Coordinates(position.latitude, position.longitude);

    return cor;
  }

  @override
  void initState() {
    super.initState();


  setState(() {

  });
    // print("eng_objectList2");
    // print(eng_objectList);

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.veryHigh,
        // imageFormatGroup: ImageFormatGroup.jpeg
      );
      print(controller);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        controller.startImageStream((CameraImage img) async {
          cameraImage2 = img;

          if(object=='car'){
            object='자동차';
          }else if(object=='bicycle'){
            object='자전거';
          } else if(object=='bus'){
            object='버스';
          } else if(object=='motorcycle'){
            object='오토바이';
          } else if(object=='traffic sign'){
            object='신호등';
          } else if(object=='train'){
            object='기차';
          } else if(object=='truck'){
            object='트럭';
          } else if(object=='fire hydrant'){
            object='소화전';
          } else if(object=='stop sign'){
            object='정지표시판';
          } else if(object=='bench'){
            object='벤치';
          } else if(object=='cat'){
            object='고양이';
          } else if(object=='dog'){
            object='개';
          }else if(object=='keyboard'){
            object='키보드';
          }


          //*원하는 객체 입력
          // if (mode=="auto"&&((object=='car')||(object=='stop sign')||(object=='keyboard'))&&accuracy>40) {
         // print("감지가능 객체 ${eng_objectList}");


          if (mode == "auto" &&
              (user_object.contains(object)) && accuracy > 65) {
            //path = (await NativeScreenshot.takeScreenshot())!;
            print('**************$object 저장중***********');
            ob = object;
            setState(() {issaving = true;});
            takepicture();
            print('$ob 저장 완료 ');
            object = '';
          }


          setState(() {});
          if (!isDetecting) {
            isDetecting = true;
            int startTime = new DateTime.now().millisecondsSinceEpoch;
            Tflite.detectObjectOnFrame(
              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              model: widget.model == "YOLO" ? "YOLO" : "SSDMobileNet",
              imageHeight: img.height,
              imageWidth: img.width,
              imageMean: widget.model == "YOLO" ? 0 : 127.5,
              imageStd: widget.model == "YOLO" ? 255.0 : 127.5,
              numResultsPerClass: 1,
              threshold: widget.model == "YOLO" ? 0.2 : 0.4,
              rotation: 90,
            ).then((recognitions) {
              // print("imgggg2 : ${img.width} / ${img.height}");
              int endTime = new DateTime.now().millisecondsSinceEpoch;
              print("Detection took ${endTime - startTime}");
              widget.setRecognitions(recognitions!, img.height, img.width);
              isDetecting = false;
            });
          }
        });
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Future<void> takepicture() async {
    print('is sav');
    print('is saving1 : $issaving');

    // Coordinates cordi=await getCurrentLocation();
    // var address=await Geocoder.local.findAddressesFromCoordinates(cordi);
    // var first=address.first;
    // print('주소 ${first.thoroughfare}');//동 받아옴

    CameraImage image = cameraImage2;
    try {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        issaving = false;
      });
      setState(() {
        saved = true;
      });
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        saved = false;
      });

      imageLib.Image img = convertYUV420ToImage(image);
      imageLib.PngEncoder pngEncoder =
          new imageLib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);

      //firebase에 저장
      print("ob $ob");
      final uploadTask = await storage
          .ref('/traffic-Image/$ob/$ob${DateTime.now()}.png')
          .putData(Uint8List.fromList(png)); //
      final url = await uploadTask.ref.getDownloadURL();

      try {
        // await FirebaseFirestore.instance
        //     .collection("category")
        //     .doc("testmail2")//FirebaseAuth.instance.currentUser!.email
        //     .collection("category").doc(ob)
        //     .set({
        //   "category": ob,
        //   "new":url,
        //   "num":1,
        //   "order":1,
        // });
        await FirebaseFirestore.instance
            .collection("category")
            .doc(
                "${FirebaseAuth.instance.currentUser!.email!}") //FirebaseAuth.instance.currentUser!.email
            .collection("category")
            .doc('all')
            .set({
          "category": 'all',
          "new": url,
          "num": 1,
          "order": 1,
        });

        //카테고리 볼더에 사진 저장
        await FirebaseFirestore.instance
            .collection("category")
            .doc(
            "${FirebaseAuth.instance.currentUser!.email!}") //FirebaseAuth.instance.currentUser!.email
            .collection(ob)
            .add({
          "url": url,
          "time": Timestamp.fromDate(DateTime.now()),// DateFormat('dd/MM/yyyy').format(DateTime.now()),
          "location": '흥해읍2' //first.thoroughfare,
          //위치추가
        });

        await FirebaseFirestore.instance
            .collection("category")
            .doc(
                "${FirebaseAuth.instance.currentUser!.email!}") //FirebaseAuth.instance.currentUser!.email
            .collection("category")
            .doc(ob)
            .set({
          "category": ob,
          "new": url,
          "order": 1,
          "num": 0,
        });


        // 전체 폴더에 사진 저장
        await FirebaseFirestore.instance
            .collection("category")
            .doc(
                "${FirebaseAuth.instance.currentUser!.email!}") //FirebaseAuth.instance.currentUser!.email
            .collection("all")
            .add({
          "url": url,
          "time": Timestamp.fromDate(DateTime.now()),
          "location": '흥해읍' ////first.thoroughfare,
          //위치추가
        });
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {


    // FirebaseFirestore.instance
    //     .collection("user")
    //     .doc("${FirebaseAuth.instance.currentUser!.email}")
    //     .get()
    //     .then((DocumentSnapshot ds) async {
    //   cameraUserInform = await ds.data();
    //   camera_objectList = cameraUserInform['object'];
    // });
     //eng_objectList=[];
    //





    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    //tmp = controller.value.previewSize;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;


    if (!controller.value.isInitialized) {
      return Container(
        color: Colors.black.withOpacity(0.5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('카메라가 켜지고 있습니다\n 잠시만 기다려주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      );
    }

    // issaving=false;
    return OverflowBox(
        maxHeight: screenRatio > previewRatio
            ? screenH
            : screenW / previewW * previewH,
        maxWidth: screenRatio > previewRatio
            ? screenH / previewH * previewW
            : screenW,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: !controller.value.isInitialized
                  ? Container()
                  : CameraPreview(controller),
            ),
            issaving
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('인식된 객체가 저장되고 있습니다\n 잠시만 기다려주세요',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  )
                : Container(),
            saved
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/icons/save_check.png'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text('저장되었습니다',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  )
                : Container(),
            // Positioned(
            //     top: 200,
            //     left: 100,
            //     child: Text(
            //       '감지객체 :${user_object} ',
            //       style: TextStyle(color: Colors.black),
            //     ))
          ],
        ));
  }
}
