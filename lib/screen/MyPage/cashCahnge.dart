import 'package:catch2_0_1/screen/MyPage/MyPage.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class cashChange extends StatefulWidget {
  const cashChange({super.key});

  @override
  State<cashChange> createState() => _cashChangeState();
}

class _cashChangeState extends State<cashChange> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.2,
          centerTitle: true,
          title: Text(
            "캐시 현금화",
            style: titleMediumStyle(color: Colors.black),
          )),
      body: Padding(
        padding: EdgeInsets.only(
          left: size.width * 0.06,
          right: size.width * 0.06,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                "보유 캐시",
                style: titleSmallStyle(color: Color(0xff9FA5B2)),
              ),
              Text(
                "10,035",
                style: bodyLargeStyle(color: Colors.black),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                '현금화 할 캐시',
                style: titleSmallStyle(color: Color(0xff9FA5B2)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.01, right: size.width * 0.06),
                child: TextFormField(
                  style: TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                      suffixIconConstraints:
                          BoxConstraints(minHeight: 6, minWidth: 16),
                      focusColor: Color.fromARGB(6, 61, 50, 50),
                      contentPadding: EdgeInsets.only(
                          top: size.height * 0.01, left: size.width * 0.04),
                      hintText: '',
                      errorText: '',
                      errorStyle: labelSmallStyle(color: Colors.red),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(36.0)),
                        borderSide: BorderSide(
                            width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(36.0)),
                        borderSide: BorderSide(
                            width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                      ),
                      hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(36.0)),
                        borderSide: BorderSide(
                            width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(36.0)),
                        borderSide: BorderSide(
                            width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(36.0)),
                      ),
                      filled: true,
                      fillColor: Colors.white),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Image.asset(
                    'assets/icons/mypage/cash_warn.png',
                    width: 16,
                  ),
                  Text(
                    "  캐시 현금화는 1,000 캐시 단위로 가능합니다.",
                    style: labelMediumStyle(color: Colors.red),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              SizedBox(
                  width: double.infinity,
                  height: size.height * 0.06,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xff3A94EE),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      onPressed: () {
                        // showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return AlertDialog(
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.only(
                        //               topLeft: Radius.circular(30.0),
                        //               topRight: Radius.circular(30.0))),
                        //       insetPadding:
                        //           EdgeInsets.only(top: size.height * 0.4),
                        //       content: Container(
                        //           height: size.height * 0.7,
                        //           width: size.width,
                        //           child: Column(
                        //             children: [
                        //               Center(
                        //                 child: Column(
                        //                   children: [
                        //                     SizedBox(
                        //                       height: size.height * 0.2,
                        //                     ),
                        //                     Text(
                        //                       "캐시가 현금화되었습니다.\n",
                        //                       style: bodyLargeStyle(
                        //                           color: Colors.black),
                        //                     ),
                        //                     Text(
                        //                       "현금화는 영업일 기준으로",
                        //                       style: bodyLargeStyle(
                        //                           color: Colors.black),
                        //                     ),
                        //                     Text(
                        //                       "최대 7일까지 소요될 수 있습니다.",
                        //                       style: bodyLargeStyle(
                        //                           color: Colors.black),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding: EdgeInsets.only(
                        //                     top: size.height * 0.03,
                        //                     bottom: size.height * 0.02),
                        //                 child: SizedBox(
                        //                     width: double.infinity,
                        //                     height: size.height * 0.06,
                        //                     child: OutlinedButton(
                        //                         style: OutlinedButton.styleFrom(
                        //                             backgroundColor:
                        //                                 Color(0xff3A94EE),
                        //                             shape: RoundedRectangleBorder(
                        //                                 borderRadius:
                        //                                     BorderRadius.all(
                        //                                         Radius.circular(
                        //                                             30)))),
                        //                         onPressed: () {
                        //                           Navigator.push(
                        //                             context,
                        //                             PageRouteBuilder(
                        //                                 pageBuilder:
                        //                                     (_, __, ___) =>
                        //                                         MYPage(),
                        //                                 transitionDuration:
                        //                                     Duration(
                        //                                         seconds: 0),
                        //                                 transitionsBuilder: (_,
                        //                                         a, __, c) =>
                        //                                     FadeTransition(
                        //                                         opacity: a,
                        //                                         child: c)),
                        //                           );
                        //                         },
                        //                         child: Text(
                        //                           "확인",
                        //                           style: titleMediumStyle(
                        //                               color: Colors.white),
                        //                         ))),
                        //               )
                        //             ],
                        //           )),
                        //     );
                        //   },
                        // );
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder:
                                  (BuildContext context,
                                      StateSetter bottomState) {
                                return Container(
                                  height: 440,
                                  child: Column(children: [
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(100, 40, 100, 20),
                                      child: Image.asset(
                                        'assets/checkToFinish.gif',
                                        height: 160,
                                        width: 160,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(24, 0, 24, 24),
                                      child: Column(
                                        children: [
                                          Text(
                                            "캐시가 현금화 되었습니다.\n",
                                            style: bodyLargeStyle(),
                                          ),
                                          Text(
                                            "현금화는 영업일 기준으로",
                                            style: bodyLargeStyle(),
                                          ),
                                          Text(
                                            "최대7일까지 소요될 수 있습니다.",
                                            style: bodyLargeStyle(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        height: 40,
                                        width: 312,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0XFF3A94EE)),
                                        margin:
                                            EdgeInsets.fromLTRB(46, 0, 46, 50),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        MYPage(),
                                                    transitionDuration:
                                                        Duration(seconds: 0),
                                                    transitionsBuilder:
                                                        (_, a, __, c) =>
                                                            FadeTransition(
                                                                opacity: a,
                                                                child: c)),
                                              );
                                              // setState(() async{
                                              //  Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) => HomePage()),
                                              // );
                                              //   print('데이터 전송 시작');
                                              // UploadFunction(_selectedFileList!);
                                              // await Future.delayed(Duration(seconds: 25));
                                              // contentsFunction(FirebaseAuth.instance.currentUser!.displayName!,_road,_arrImageUrls,contentsController,roadAddress);
                                              //   _road == null;
                                              //   postCode = '-';
                                              //   _arrImageUrls.clear();
                                              //   contentsController.clear();
                                              // });
                                            },
                                            child: Text('확인',
                                                style: titleMediumStyle(
                                                    color: Colors.white))))
                                  ]),
                                );
                              });
                            });
                      },
                      child: Text(
                        "현금화 하기",
                        style: titleMediumStyle(color: Colors.white),
                      )))
            ]),
      ),
    );
  }
}
