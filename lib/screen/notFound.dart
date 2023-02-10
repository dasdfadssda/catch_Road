import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//2/10
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class notFound extends StatefulWidget {
 // const notFound({Key? key}) : super(key: key);
  //final CameraDescription camera;

  // const notFound({
  //   required this.camera,
  // });


  @override
  _notFoundState createState() => _notFoundState();
}

class _notFoundState extends State<notFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 130,),
            Image.asset('assets/emoticon.png',),
            SizedBox(height: 60,),
            Text("이 기능은 개발 중에 있습니다.\n빠른 시일 내에 공개하도록 하겠습니다.\n너른 이해 감사드립니다.",
              style: titleSmallStyle(color:Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () async {
               Navigator.pop(context);
              },
              child: Text(
                "이전 화면으로 돌아가기",
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
                      )
                  ),
                  side: MaterialStateProperty.all(
                    BorderSide(
                        width: 0,
                        color: primary[0]!.withOpacity(0.02)
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
