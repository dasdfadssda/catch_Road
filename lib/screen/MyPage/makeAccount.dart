import 'package:catch2_0_1/screen/mainHome.dart';
import 'package:flutter/material.dart';


import '../../utils/app_text_styles.dart';
import 'MyCash.dart';
import 'MyPage.dart';

String _bankName = '';
String _bankNum = '';
String _nameForBank = '';

class bankInformationUpdateCode extends ChangeNotifier {
  String bankName = _bankName;
  String bankNum = _bankNum;
  String nameForBank = _nameForBank;
  notifyListeners();
}

final Bankcontroller = TextEditingController();
final BankNumcontroller = TextEditingController();
final BankNamecontroller = TextEditingController();
final _formBankKeyK = GlobalKey<FormState>();
final _formBankNumcKeyk = GlobalKey<FormState>();
final _formBankNamehKeyk = GlobalKey<FormState>();

class makeAccount extends StatefulWidget {
  const makeAccount({super.key});

  @override
  State<makeAccount> createState() => _makeAccountState();
}

class _makeAccountState extends State<makeAccount> {
  @override
  Widget build(BuildContext context) {
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
            _formBank(),
            _textfieldLabel('계좌번호'),
            SizedBox(
              height: 6,
            ),
            _formBankNum(),
            _textfieldLabel('예금주명'),
            SizedBox(
              height: 6,
            ),
            _formNameForBank(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF3A94EE),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30)))),
                    onPressed: () async {
                      // if (_formBankKeyK.currentState!.validate()) {
                      //   if (_formBankNumcKeyk.currentState!.validate()) {
                      //     if (_formBankNamehKeyk.currentState!.validate()) {
                      _bankName = Bankcontroller.text;
                      _bankNum = BankNumcontroller.text;
                      _nameForBank = BankNumcontroller.text;
                      //UpdateUserBankFunction();
                      //     }
                      //   }
                      // }
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
                                height: 380,
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
                                    margin: EdgeInsets.fromLTRB(24, 0, 24, 24),
                                    child: Text(
                                      "계좌 정보가 등록 되었습니다.",
                                      style: bodyLargeStyle(),
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
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MainHomePage(),
                                                ));
                                            // Navigator.pop(context);
                                            // Navigator.pop(context);
                                            Bankcontroller.clear();
                                            BankNumcontroller.clear();
                                            BankNamecontroller.clear();
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
                      "등록하기",
                      style: titleMediumStyle(color: Color(0xffFAFBFB)),
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

  Widget _formBank() {
    return Form(
      child: TextFormField(
        key: _formBankKeyK,
        validator: (val) {
          if (val?.length == 0) {
            return '수취인명은 필수사항입니다.';
          }
          return null;
        },
        onTap: () {},
        controller: Bankcontroller,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(left: 20),
            hintText: 'EX) 포항은행',
            errorText: '',
            errorStyle: labelSmallStyle(color: Colors.red),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
            ),
            filled: true,
            fillColor: Colors.white),
        showCursor: false,
      ),
    );
  }

  Widget _formBankNum() {
    return Form(
      child: TextFormField(
        key: _formBankNumcKeyk,
        validator: (val) {
          if (val?.length == 0) {
            return '계좌번호는 필수사항입니다.';
          }
          return null;
        },
        style: TextStyle(fontSize: 13),
        controller: BankNumcontroller,
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(left: 20),
            hintText: '',
            errorText: '',
            errorStyle: labelSmallStyle(color: Colors.red),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
            ),
            filled: true,
            fillColor: Colors.white),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget _formNameForBank() {
    return Form(
      child: TextFormField(
        key: _formBankNamehKeyk,
        validator: (val) {
          if (val?.length == 0) {
            return '예금주명은 필수사항입니다.';
          }
          return null;
        },
        controller: BankNamecontroller,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
            focusColor: Color.fromARGB(6, 61, 50, 50),
            contentPadding: EdgeInsets.only(left: 20),
            hintText: 'ex) 홍길동',
            errorText: '',
            errorStyle: labelSmallStyle(color: Colors.red),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            hintStyle: bodyMediumStyle(color: Color(0xff9FA5B2)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
              borderSide:
                  BorderSide(width: 0.5, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36.0)),
            ),
            filled: true,
            fillColor: Colors.white),
        keyboardType: TextInputType.text,
      ),
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

  void _showEnroll(context) {
    // 업로드 관련 스냅바
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter bottomState) {
            return Container(
              height: 380,
              child: Column(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(100, 40, 100, 20),
                  child: Image.asset(
                    'assets/checkToFinish.gif',
                    height: 160,
                    width: 160,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(24, 0, 24, 28),
                  child: Text(
                    "계좌 정보가 등록 되었습니다.",
                    style: labelSmallStyle(),
                  ),
                ),
                Container(
                    height: 40,
                    width: 312,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0XFF3A94EE)),
                    margin: EdgeInsets.fromLTRB(46, 0, 46, 50),
                    child: TextButton(
                        onPressed: () {
                   
                        },
                        child: Text('확인',
                            style: labelSmallStyle(color: Colors.white))))
              ]),
            );
          });
        });
  }
}
