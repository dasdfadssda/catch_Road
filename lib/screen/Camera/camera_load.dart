import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'camera_page.dart';


List<CameraDescription> cameras = [];
class CamerLoad extends StatefulWidget {

  @override
  State<CamerLoad> createState() => _CamerLoadState();
}

class _CamerLoadState extends State<CamerLoad> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return TakePictureScreen2();
    // }));
  }

  void initCamera() async{
    cameras = await availableCameras();
    print('cameras $cameras');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ElevatedButton(
        onPressed: () async {
          //Get.back();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CameraPage(cameras);
          }));
        },
        child: Text(
          "카메라 사용하기",
          style: titleSmall.copyWith(
            color: Colors.white,
          ),
        ),

      ),
    );
  }
}
