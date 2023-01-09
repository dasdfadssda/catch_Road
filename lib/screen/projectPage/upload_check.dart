import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../mainHome.dart';

class uploadCheck extends StatefulWidget {
  // const notFound({Key? key}) : super(key: key);
  //final CameraDescription camera;

  // const notFound({
  //   required this.camera,
  // });

  @override
  _uploadCheckState createState() => _uploadCheckState();
}

class _uploadCheckState extends State<uploadCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            SizedBox(
                height: 200, child: Image.asset('assets/checkToFinish.gif')),
            SizedBox(
              height: 20,
            ),
            Text(
              "업로드 완료 ",
              style: titleLargeStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainHomePage();
                }));
              },
              child: Text(
                "다른 프로젝트 참여하기",
                style: titleSmallStyle(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(180, 40)),
                  backgroundColor: MaterialStateProperty.all(
                    primary[40],
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )),
                  side: MaterialStateProperty.all(
                    BorderSide(width: 0, color: primary[0]!.withOpacity(0.02)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
