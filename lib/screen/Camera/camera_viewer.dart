import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:camera/camera.dart';
// import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'camera_bndbox.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:intl/intl.dart';

XFile? pictureFile;
XFile? imgFile;
CameraImage? cameraImage;
late CameraImage cameraImage2;
late List<int> pngfile;
Uint8List list = Uint8List(1000000);
late String path;
late CameraController controller;

List<Uint8List> imageList = [];
bool issaving = false;
String ob = '';

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

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.veryHigh,
      );
      print(controller);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        controller.startImageStream((CameraImage img) async {
          cameraImage2 = img;
          //*원하는 객체 입력
          if (((object == 'car') ||
                  (object == 'stop sign') ||
                  (object == 'bicycle')) &&
              accuracy > 40) {
            //path = (await NativeScreenshot.takeScreenshot())!;
            print('$object 저장중');
            ob = object;
            setState(() {
              issaving = true;
            });
            takepicture();
            print('$object 저장 완료 ');
            object = '';
          }
          setState(() {});
          // if (!isDetecting) {
          //   isDetecting = true;
          //   int startTime = new DateTime.now().millisecondsSinceEpoch;
          //   Tflite.detectObjectOnFrame(
          //     bytesList: img.planes.map((plane) {
          //       return plane.bytes;
          //     }).toList(),
          //     model: widget.model == "YOLO" ? "YOLO" : "SSDMobileNet",
          //     imageHeight: img.height,
          //     imageWidth: img.width,
          //     imageMean: widget.model == "YOLO" ? 0 : 127.5,
          //     imageStd: widget.model == "YOLO" ? 255.0 : 127.5,
          //     numResultsPerClass: 1,
          //     threshold: widget.model == "YOLO" ? 0.2 : 0.4,
          //     rotation: 90,
          //   ).then((recognitions) {
          //     // print("imgggg2 : ${img.width} / ${img.height}");
          //     int endTime = new DateTime.now().millisecondsSinceEpoch;
          //     print("Detection took ${endTime - startTime}");
          //     widget.setRecognitions(recognitions!, img.height, img.width);
          //     isDetecting = false;
          //   });
          // }
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
    print('is saving1 : $issaving');
    CameraImage image = cameraImage2;

    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel!;
      var img = imglib.Image(image.width, image.height); // Create Image buffer

      // for (int x = 0; x < width; x++) {
      //   for (int y = 0; y < height; y++) {
      //     final int uvIndex =
      //         uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
      //     final int index = y * width + x;
      //     final yp = image.planes[0].bytes[index];
      //     final up = image.planes[1].bytes[uvIndex];
      //     final vp = image.planes[2].bytes[uvIndex];
      //     int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
      //     int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
      //     int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
      //     img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
      //   }
      // } //너무 오래 걸려서 잠시 생략
      if (ob == 'stop sign') {
        ob = 'sign';
      }
      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);

      //firebase에 저장
      final uploadTask = await storage
          .ref('/traffic-Image/$ob/$ob${DateTime.now()}.png')
          .putData(Uint8List.fromList(png)); //
      final url = await uploadTask.ref.getDownloadURL();
      // try {
      //   await FirebaseFirestore.instance
      //       .collection("category")
      //       .doc("1234@handong.ac.kr")//FirebaseAuth.instance.currentUser!.email
      //       .collection(ob)
      //       .doc("date")
      //       .collection("date")
      //       .add({
      //     "url": url,
      //     "time":DateFormat('dd/MM/yyyy').format(DateTime.now())
      //   });
      // } catch (e) {
      //   print(e);
      // }
      setState(() {
        issaving = false;
      });
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                : Container()
          ],
        ));
  }
}

imglib.Image _convertYUV420(CameraImage image) {
  final int width = image.width;
  final int height = image.height;
  final int uvRowStride = image.planes[1].bytesPerRow;
  final int uvPixelStride = image.planes[1].bytesPerPixel!;
  var img = imglib.Image(image.width, image.height); // Create Image buffer

  // for (int x = 0; x < width; x++) {
  //   for (int y = 0; y < height; y++) {
  //     final int uvIndex =
  //         uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
  //     final int index = y * width + x;
  //     final yp = image.planes[0].bytes[index];
  //     final up = image.planes[1].bytes[uvIndex];
  //     final vp = image.planes[2].bytes[uvIndex];
  //     int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
  //     int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
  //     int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
  //     img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
  //   }
  // } //너무 오래 걸려서 잠시 생략
  return img;
}
