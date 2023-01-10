import 'package:catch2_0_1/Auth/auth_service.dart';
import 'package:catch2_0_1/LoginPage.dart';
import 'package:catch2_0_1/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../Auth/user_information.dart';
import '../utils/app_text_styles.dart';
import 'joinPage.dart';
import 'joinStep2.dart';


class joinPage7 extends StatefulWidget {
  const joinPage7({super.key});

  @override
  State<joinPage7> createState() => _joinPage7State();
}


class _joinPage7State extends State<joinPage7> {
     final Emailcontroller = TextEditingController();
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 24,
              color: Color(0xffCFD2D9),
            )),
        centerTitle: true,
        title: Text(
          "회원가입",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.19,
                    left: size.width * 0.06,
                    right: size.width * 0.06),
                child: SizedBox(
                  // height: size.height * 0.08,
                  child: Center(
                    child:Image.asset('assets/icons/car.png', height: 110,width: 310,)
                  )
                )),
            SizedBox(height: size.height * 0.1),
             Text("${emailCode().email}님,", style: titleLargeStyle(color: Colors.black)),
             Text("Catch에 오신 걸 환영합니다.", style: titleLargeStyle(color: Colors.black)),
             SizedBox(height: size.height * 0.2),
            SizedBox(
                width: size.width * 0.85,
                height: size.height * 0.08,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xff3174CD),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    onPressed: () async {
                      signUpWithEmailAndPassword();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => LoginPage(),
                              transitionDuration: Duration(seconds: 0),
                              transitionsBuilder: (_, a, __, c) =>
                                  FadeTransition(opacity: a, child: c)),
                        );
                    },
                    child: Text(
                      "다음",
                      style: titleMediumStyle(color: Color(0xffFAFBFB)),
                    )))
          ],
        ),
      ),
    );
  }

}
