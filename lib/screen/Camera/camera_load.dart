import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'camera_page.dart';



class CamerLoad extends StatefulWidget {

   final List<CameraDescription> cameras;

  CamerLoad(this.cameras);

  @override
  State<CamerLoad> createState() => _CamerLoadState();
}

class _CamerLoadState extends State<CamerLoad> {
  @override
  void initState() {
    super.initState();
    //initCamera();
  }

  // void initCamera() async{
  //   widget.cameras = await availableCameras();
  //   print('cameras $widget.cameras');
  // }

  @override
  Widget build(BuildContext context) {
    return CameraPage(widget.cameras);

  }
}
