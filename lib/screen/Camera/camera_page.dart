import 'package:camera/camera.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:math' as math;
import 'package:tflite/tflite.dart';
import '../../utils/app_text_styles.dart';
import 'camera_bndbox.dart';

import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'camera_viewer.dart';

var globalKey = new GlobalKey();
late CameraController controller;


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
    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.veryHigh,
      );
    }

    onSelect("SSDMobileNet");
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

      print('_recognitions: $_recognitions');
      print('_imageHeight: $_imageHeight');
      print('_imageWidth: $_imageWidth');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Stack(
        children: [

          CameraViewer(
            widget.cameras,
            _model,
            setRecognitions,
          ),

          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width,
              _model),

        ],

      ),
      // body: Stack(
      //   children: [
      //     CameraViewer(
      //       widget.cameras,
      //       _model,
      //       setRecognitions,
      //     ),
      //
      //     issaving
      //         ? Container()
      //         : BndBox(
      //             _recognitions == null ? [] : _recognitions,
      //             math.max(_imageHeight, _imageWidth),
      //             math.min(_imageHeight, _imageWidth),
      //             MediaQuery.of(context).size.height,
      //             MediaQuery.of(context).size.width,
      //             _model),
      //     objectSelect
      //         ? Container(
      //        decoration: BoxDecoration(
      //             color: Colors.black.withOpacity(0.6),
      //             borderRadius: BorderRadius.circular(30.0)
      //         ),
      //             //color: Colors.black.withOpacity(0.6),
      //             width: MediaQuery.of(context).size.width,
      //             height: 390.h,
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: 45.h,
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     SizedBox(width: 24.w),
      //                     GestureDetector(
      //                       onTap: () {
      //                         Navigator.of(context).pop();
      //                       },
      //                       child: SizedBox(
      //                         height: 24.w,
      //                         width: 24.h,
      //                         child: Icon(
      //                           Icons.clear_rounded,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(width: 269.w),
      //                     GestureDetector(
      //                       onTap: () {
      //                         setState(() {
      //                           objectSelect = false;
      //                         });
      //                       },
      //                       child: SizedBox(
      //                         height: 24.w,
      //                         width: 24.h,
      //                         child: Icon(
      //                           Icons.check,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //                 SizedBox(
      //                   height: 16.h,
      //                 ),
      //                 Row(
      //                   children: [
      //                     SizedBox(
      //                       width: 24.w,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(top:17.h),
      //                       decoration: BoxDecoration(
      //
      //                         color:Colors.white,
      //                           borderRadius: BorderRadius.circular(16.0)
      //                       ),
      //                         width:148.w,
      //                         height: 80.h,
      //                      //   color:Colors.white,
      //                         child:Row(
      //                           children: [
      //                             SizedBox(width: 38.w,),
      //                             Column(
      //                               children: [
      //                                 Icon(
      //                                   size:30,
      //                                   Icons.person,
      //                                   color:Colors.blue,
      //                                 ),
      //                                 SizedBox(height: 4.h,),
      //                                 Text('사람',
      //                                 style:TextStyle(
      //                                   fontWeight: FontWeight.bold,
      //                                     color:Colors.black
      //
      //                                 )),
      //                               ],
      //
      //                             ),
      //                             SizedBox(width:30.w),
      //                            Column(
      //                              crossAxisAlignment: CrossAxisAlignment.center,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                              children: [
      //                                SizedBox(height:9.h),
      //                                Icon(
      //                                size:24.h,
      //                                Icons.check,
      //                                color:Colors.blue,
      //
      //                              ),],
      //                            )
      //
      //
      //
      //
      //                           ],
      //                         ),
      //
      //                       ),
      //                     SizedBox(
      //                       width: 16.w,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(top:17.h),
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(16.0)
      //                       ),
      //                       width:148.w,
      //                       height: 80.h,
      //                       //   color:Colors.white,
      //                       child:Row(
      //                         children: [
      //                           SizedBox(width: 38.w,),
      //                           Column(
      //                             children: [
      //                               Icon(
      //                                 size:30,
      //                                 Icons.car_crash_outlined,
      //                                 color:Colors.grey,
      //                               ),
      //                               SizedBox(height: 4.h,),
      //                               Text('자동차',
      //                                   style:TextStyle(
      //                                       fontWeight: FontWeight.bold,
      //                                       color:Colors.black
      //
      //                                   )),
      //                             ],
      //
      //                           ),
      //                           SizedBox(width:30.w),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               SizedBox(height:9.h),
      //                               Icon(
      //                                 size:24.h,
      //                                 Icons.check,
      //                                 color:Colors.grey,
      //
      //                               ),],
      //                           )
      //
      //
      //
      //
      //                         ],
      //                       ),
      //
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 16.h,),
      //                 Row(
      //                   children: [
      //                     SizedBox(
      //                       width: 24.w,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(top:17.h),
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(10.0)
      //                       ),
      //                       width:148.w,
      //                       height: 80.h,
      //                       //   color:Colors.white,
      //                       child:Row(
      //                         children: [
      //                           SizedBox(width: 38.w,),
      //                           Column(
      //                             children: [
      //                               Icon(
      //                                 size:30,
      //                                 Icons.motorcycle_sharp,
      //                                 color:Colors.grey,
      //                               ),
      //                               SizedBox(height: 4.h,),
      //                               Text('오토바이',
      //                                   style:TextStyle(
      //                                       fontWeight: FontWeight.bold,
      //                                       color:Colors.black
      //
      //                                   )),
      //                             ],
      //
      //                           ),
      //                           SizedBox(width:30.w),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               SizedBox(height:9.h),
      //                               Icon(
      //                                 size:24.h,
      //                                 Icons.check,
      //                                 color:Colors.grey,
      //
      //                               ),],
      //                           )
      //
      //
      //
      //
      //                         ],
      //                       ),
      //
      //                     ),
      //                     SizedBox(
      //                       width: 16.w,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(top:17.h),
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(16.0)
      //                       ),
      //                       width:148.w,
      //                       height: 80.h,
      //                       //   color:Colors.white,
      //                       child:Row(
      //                         children: [
      //                           SizedBox(width: 38.w,),
      //                           Column(
      //                             children: [
      //                               Icon(
      //                                 size:30,
      //                                 Icons.directions_bus_filled_sharp,
      //                                 color:Colors.grey,
      //                               ),
      //                               SizedBox(height: 4.h,),
      //                               Text('버스',
      //                                   style:TextStyle(
      //                                       fontWeight: FontWeight.bold,
      //                                       color:Colors.black
      //
      //                                   )),
      //                             ],
      //
      //                           ),
      //                           SizedBox(width:30.w),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               SizedBox(height:9.h),
      //                               Icon(
      //                                 size:24.h,
      //                                 Icons.check,
      //                                 color:Colors.grey,
      //
      //                               ),],
      //                           )
      //
      //
      //
      //
      //                         ],
      //                       ),
      //
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 16.h,),
      //                 Row(
      //                   children: [
      //                     SizedBox(
      //                       width: 24.w,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(top:17.h),
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(16.0)
      //                       ),
      //                       width:148.w,
      //                       height: 80.h,
      //                       //   color:Colors.white,
      //                       child:Row(
      //                         children: [
      //                           SizedBox(width: 38.w,),
      //                           Column(
      //                             children: [
      //                               Icon(
      //                                 size:30,
      //                                 Icons.pedal_bike_outlined,
      //                                 color:Colors.grey,
      //                               ),
      //                               SizedBox(height: 4.h,),
      //                               Text('자전거',
      //                                   style:TextStyle(
      //                                       fontWeight: FontWeight.bold,
      //                                       color:Colors.black
      //
      //                                   )),
      //                             ],
      //
      //                           ),
      //                           SizedBox(width:30.w),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               SizedBox(height:9.h),
      //                               Icon(
      //                                 size:24.h,
      //                                 Icons.check,
      //                                 color:Colors.grey,
      //
      //                               ),],
      //                           )
      //
      //
      //
      //
      //                         ],
      //                       ),
      //
      //                     ),
      //                     SizedBox(
      //                       width: 16.w,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(top:17.h),
      //                       decoration: BoxDecoration(
      //                           color: Colors.white,
      //                           borderRadius: BorderRadius.circular(16.0)
      //                       ),
      //                       width:148.w,
      //                       height: 80.h,
      //                       //   color:Colors.white,
      //                       child:Row(
      //                         children: [
      //                           SizedBox(width: 38.w,),
      //                           Column(
      //                             children: [
      //                               Icon(
      //                                 size:30,
      //                                 Icons.traffic_rounded,
      //                                 color:Colors.grey,
      //                               ),
      //                               SizedBox(height: 4.h,),
      //                               Text('신호등',
      //                                   style:TextStyle(
      //                                       fontWeight: FontWeight.bold,
      //                                       color:Colors.black
      //
      //                                   )),
      //                             ],
      //
      //                           ),
      //                           SizedBox(width:30.w),
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             // mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               SizedBox(height:9.h),
      //                               Icon(
      //                                 size:24.h,
      //                                 Icons.check,
      //                                 color:Colors.grey,
      //
      //                               ),],
      //                           )
      //
      //
      //
      //
      //                         ],
      //                       ),
      //
      //                     ),
      //                   ],
      //                 ),
      //
      //                // SizedBox(height: 16.h,),
      //               ],
      //             ))
      //         : Container(
      //             color: Colors.black.withOpacity(0.6),
      //             width: MediaQuery.of(context).size.width,
      //             height: 96.h,
      //             child: Column(
      //               children: [
      //                 SizedBox(
      //                   height: 45.h,
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     SizedBox(width: 24.w),
      //                     GestureDetector(
      //                       onTap: () {
      //                         Navigator.of(context).pop();
      //                       },
      //                       child: SizedBox(
      //                         height: 24.w,
      //                         width: 24.h,
      //                         child: Icon(
      //                           Icons.clear_rounded,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ),
      //                     SizedBox(width: 269.w),
      //                     GestureDetector(
      //                       onTap: () {
      //                         setState(() {
      //                           objectSelect = true;
      //                         });
      //                       },
      //                       child: SizedBox(
      //                         height: 24.w,
      //                         width: 24.h,
      //                         child: Icon(
      //                           Icons.check_box_outline_blank,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 )
      //               ],
      //             )),
      //     Positioned(
      //       bottom: 0,
      //       child: Container(
      //           color: Colors.black.withOpacity(0.6),
      //           width: MediaQuery.of(context).size.width,
      //           height: 58.h,
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text(
      //                 '자동인식',
      //                 style: titleMedium.copyWith(
      //                   color: Colors.white,
      //                 ),
      //                 textAlign: TextAlign.start,
      //               )
      //             ],
      //           )),
      //     ),
      //   ],
      // ),
    );
  }
}
