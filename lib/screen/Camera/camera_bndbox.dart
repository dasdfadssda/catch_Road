import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:image/image.dart' as imglib;
import '../mainHome.dart';
import 'camera_page.dart';
import 'camera_viewer.dart';

String object = '';
double accuracy = 0.0;

class BndBox extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      this.model);

  @override
  State<BndBox> createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  @override
  // Future<void> takepicture() async {
  //   setState(() {});
  //   CameraImage image = cameraImage2;
  //   //String object2=object;
  //   try {
  //     final int width = image.width;
  //     final int height = image.height;
  //     final int uvRowStride = image.planes[1].bytesPerRow;
  //     final int uvPixelStride = image.planes[1].bytesPerPixel!;
  //     print("uvRowStride: " + uvRowStride.toString());
  //     print("uvPixelStride: " + uvPixelStride.toString());
  //     var img = imglib.Image(width, height); // Create Image buffer
  //     for (int x = 0; x < width; x++) {
  //       for (int y = 0; y < height; y++) {
  //         final int uvIndex =
  //             uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
  //         final int index = y * width + x;
  //         final yp = image.planes[0].bytes[index];
  //         final up = image.planes[1].bytes[uvIndex];
  //         final vp = image.planes[2].bytes[uvIndex];
  //         int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
  //         int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
  //             .round()
  //             .clamp(0, 255);
  //         int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
  //         img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
  //       }
  //     }
  //
  //     imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
  //     List<int> png = pngEncoder.encodeImage(img);
  //
  //     final uploadTask = await storage
  //         // .ref('tflitetest/${object2}/${object2}${DateTime.now()}.png')
  //         .ref('tflitetest/hello/test.png')
  //         .putData(Uint8List.fromList(png));
  //     final url = await uploadTask.ref.getDownloadURL();
  //     print(url);
  //   } catch (e) {
  //     print(">>>>>>>>>>>> ERROR:" + e.toString());
  //   }
  // }

  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    print("바운딩박스 ${user_object}");
    List<Widget> _renderBoxes() {

      return widget.results
          .map((re) {
            var _x = re["rect"]["x"];
            var _w = re["rect"]["w"];
            var _y = re["rect"]["y"];
            var _h = re["rect"]["h"];
            var scaleW, scaleH, x, y, w, h;


            if(re["detectedClass"]=='car'){
              re["detectedClass"]='자동차';
            }else if(re["detectedClass"]=='bicycle'){
              re["detectedClass"]='자전거';
            } else if(re["detectedClass"]=='bus'){
              re["detectedClass"]='버스';
            } else if(re["detectedClass"]=='motorcycle'){
              re["detectedClass"]='오토바이';
            } else if(re["detectedClass"]=='traffic sign'){
              re["detectedClass"]='신호등';
            } else if(re["detectedClass"]=='train'){
              re["detectedClass"]='기차';
            } else if(re["detectedClass"]=='truck'){
              re["detectedClass"]='트럭';
            } else if(re["detectedClass"]=='fire hydrant'){
              re["detectedClass"]='소화전';
            } else if(re["detectedClass"]=='stop sign'){
              re["detectedClass"]='정지표시판';
            } else if(re["detectedClass"]=='bench'){
              re["detectedClass"]='벤치';
            } else if(re["detectedClass"]=='cat'){
              re["detectedClass"]='고양이';
            } else if(re["detectedClass"]=='dog'){
              re["detectedClass"]='개';
            }else if(re["detectedClass"]=='keyboard'){
              re["detectedClass"]='키보드';
            }


            object = re["detectedClass"];
            accuracy = re["confidenceInClass"] * 100;

            print("객체 ${re["detectedClass"]})");
            print("키보드 포함 ? ${user_object.contains(re["detectedClass"])}");

            print('**정확도 : $object / $accuracy **');

            if (widget.screenH / widget.screenW >
                widget.previewH / widget.previewW) {
              print("-----1-------");
              print("screenW ${widget.screenW}  ScreenH ${widget.screenH}");

              scaleW = widget.screenH / widget.previewH * widget.previewW;
              scaleH = widget.screenH;

              print("previewH ${widget.previewH} previewW ${widget.previewW}");
              print("scaleW $scaleW scaleH $scaleH");

              var difW = (scaleW - widget.screenW) / scaleW;

              print("difW $difW");
              x = (_x - difW / 2) * scaleW;
              w = _w * scaleW;
              if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
              y = _y * scaleH;
              h = _h * scaleH;
            } else {
              print("-----2-------");
              scaleH = widget.screenW / widget.previewW * widget.previewH;
              scaleW = widget.screenW;
              var difH = (scaleH - widget.screenH) / scaleH;
              x = _x * scaleW;
              w = _w * scaleW;
              y = (_y - difH / 2) * scaleH;
              h = _h * scaleH;
              if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
            }

            if (re["detectedClass"] == "car") {
              print("xywh2:  $x , $y , $w, $h");
              //rotate 90일때 ,
              //xywh2:  119.81381207108498 , 299.96974347432456 , 160.93601502776147, 300.001536432902
            }
            return Positioned(
                left: math.max(0, x),
                top: math.max(0, y),
                width: w,
                height: h,
                // child: c_object_list.contains(re["detectedClass"]) ||
                //         re["detectedClass"] == 'keyboard' ||
                //         re["detectedClass"] == 'stop sign' ||
                //         re["detectedClass"] == 'person' ||
                //         re["detectedClass"] == 'car' ||
                //         re["detectedClass"] == 'bus' ||
                //         re["detectedClass"] == 'motocycle'
                child: user_object.contains(re["detectedClass"]) ?Container(
                        padding: EdgeInsets.fromLTRB(10, 20, 30, 40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 5,
                          ),
                        ),
                        child: Transform.rotate(
                          angle: 0 * math.pi / 180,
                          child: Text(
                            // "${re["detectedClass"]}",
                            "${re["detectedClass"]} ",
                            //${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )):
                Container(
                    )
                   );
          })
          .toList()
          .sublist(0, 1);
    }

    if (widget.results.length == 0) {
      print('---------0');
      return Container();
    } else {
      return Stack(
        children: [
          Stack(
            children: _renderBoxes(), ),
        ],
      );
    }
  }
}
