import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

class makeAccount extends StatefulWidget {
  const makeAccount({super.key});

  @override
  State<makeAccount> createState() => _makeAccountState();
}

class _makeAccountState extends State<makeAccount> {
  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.2,
          centerTitle: true,
          title:
              Text("계좌 정보 등록", style: titleMediumStyle(color: Colors.black))),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            _textfieldLabel('은행'),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _dialogGrid();
                          },
                        );
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 35,
                        color: Color(0xffCFD2D9),
                      )),
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 6, minWidth: 16),
                  focusColor: Color.fromARGB(6, 61, 50, 50),
                  contentPadding: EdgeInsets.only(top: 8, left: 24),
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
              keyboardType: TextInputType.emailAddress,
            ),
            _textfieldLabel('계좌번호'),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 6, minWidth: 16),
                  focusColor: Color.fromARGB(6, 61, 50, 50),
                  contentPadding: EdgeInsets.only(top: 8, left: 24),
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
              keyboardType: TextInputType.emailAddress,
            ),
            _textfieldLabel('수취인명'),
            SizedBox(
              height: 6,
            ),
            TextFormField(
              style: TextStyle(fontSize: 13),
              decoration: InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 6, minWidth: 16),
                  focusColor: Color.fromARGB(6, 61, 50, 50),
                  contentPadding: EdgeInsets.only(top: 2, left: 5),
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
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xffCFD2D9),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0))),
                            insetPadding: EdgeInsets.only(top: 500),
                            content: Container(
                                margin: EdgeInsets.zero,
                                height: 350,
                                width: 320,
                                child: Column(
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 90,
                                          ),
                                          Text(
                                            "계좌정보가 등록되었습니다.",
                                            style: bodyLargeStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 5),
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xff3A94EE),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30)))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "확인",
                                                style: titleMediumStyle(
                                                    color: Colors.white),
                                              ))),
                                    )
                                  ],
                                )),
                          );
                        },
                      );
                    },
                    child: Text(
                      "등록하기",
                      style: titleMediumStyle(color: Color(0xff9FA5B2)),
                    )))
          ],
        ),
      )),
    );
  }

  Row _textfieldLabel(String labels) {
    return Row(
      children: [
        Text(
          labels,
          style: titleSmallStyle(color: Color(0xff9FA5B2)),
        ),
        Spacer()
      ],
    );
  }

  AlertDialog _dialogMy() {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      insetPadding: EdgeInsets.only(top: size.height * 0.6),
      content: Container(
          height: size.height * 0.3,
          width: size.width,
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Text(
                      "계좌정보가 등록되었습니다.",
                      style: bodyLargeStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.03, bottom: size.height * 0.01),
                child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xff3A94EE),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)))),
                        onPressed: () {},
                        child: Text(
                          "확인",
                          style: titleMediumStyle(color: Colors.white),
                        ))),
              )
            ],
          )),
    );
  }

  AlertDialog _dialogGrid() {
    // final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      insetPadding: EdgeInsets.only(top: 230),
      content:
          Container(height: 500, width: double.infinity, child: send_grid()),
    );
  }
}

class send_grid extends StatelessWidget {
  List<String> grids = [
    'nh',
    'kb', //
    'kakaobank',
    'shinhan',
    'wori_send',
    'ibk_send',
    'hana_send',
    'new',
    'dgb',
    'bnk',
    'kbank' //
  ];
  List<String> names = [
    'NH농협',
    'KB국민',
    '카카오뱅크',
    '신한',
    '우리',
    'IBK기업',
    '하나',
    '새마을',
    '대구',
    '부산',
    '케이뱅크'
  ];
  send_grid({super.key});

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 375,
            width: 325,
            child: SizedBox(
                child: GridView.count(
                    physics: new NeverScrollableScrollPhysics(),
                    childAspectRatio: 1.24,
                    crossAxisCount: 3,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 8,
                    children: List.generate(11, (index) {
                      return Container(
                        height: 17,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            shape: BoxShape.rectangle,
                            color: Color(0xffFAFAFA)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                    'assets/account/${grids[index]}.png',
                                    height: 36)),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 3.0, top: 2),
                              child: Text(
                                names[index],
                                style: SubTitleStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    }))),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xff3A94EE),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "확인",
                    style: titleMediumStyle(color: Colors.white),
                  ))),
        ],
      ),
    );
  }
}
