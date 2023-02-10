import 'package:flutter/material.dart';

import '../../utils/app_text_styles.dart';

class Agree1 extends StatefulWidget {
  const Agree1({Key? key}) : super(key: key);

  @override
  State<Agree1> createState() => _Agree1State();
}

class _Agree1State extends State<Agree1> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Container(
          height: size.height*0.085,
          child: Center(
              child: Text(
                '이용약관 동의',
                style: titleMediumStyle(color: Colors.black),
              )),
        )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left:size.width*0.06,top: size.height*0.015,right:size.width*0.06 ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('제 10조 서비스 중단',
                  style: titleMediumStyle(color: Color(0xff3174CD)),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height:size.height*0.015 ,
                ),
                Text(s1,
                  style: bodyMediumStyle(color: Colors.black),

                ),
                SizedBox(
                  height:size.height*0.015 ,
                ),
                Text(s2,
                  style: bodyMediumStyle(color: Colors.black),

                ),
                SizedBox(
                  height:size.height*0.015 ,
                ),

                Text('제 11조 이용자의 의무',
                  style: titleMediumStyle(color: Color(0xff3174CD)),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height:size.height*0.015 ,
                ),
                Text(s3,
                  style: bodyMediumStyle(color: Colors.black),

                ),


              ],

            ),



          ),

        ),

      )

    );
  }
}

String s1="1.터닝포인트는 서비스의 제공과 관련한 터닝포인트의 정책 변경, 서비스의 기술적 사양의 변경 필요성이 있는 경우 또는 다음 각호의 사유를 포함한 기타 상당한 사유가 있는 경우에는 서비스의 전부 또는 일부의 내용을 중단할 수 있습니다.";
String s2="2.이 경우 중단되는 서비스의 내용은 제7조의 방법으로 사전에 공지하며, 서비스의 변경이 이용자에게 중대한 영향을 미치는 경우 이용자의 이메일 주소로 메일을 발송하거나 휴대전화번호로 문자메시지를 전송하는 방법으로 개별적으로 공지합니다. 다만, 터닝포인트가 예측할 수 없거나 통제할 수 없는 사유(터닝포인트의 과실이 없는 디스크 내지 서버 장애, 시스템 다운 등)로 인해 사전 통지 내지 공지가 불가능한 경우에는 사후에 공지할 수 있습니다.";
String s3="이용자는 서비스를 이용하며 다음 각 호의 행위를 하여서는 아니되며, 회사는 해당 이용자에 대하여 제12조에 따른 제재를 하거나 민형사상 책임을 물을 수 있습니다. \n 1. 신청 또는 변경 시 허위내용의 등록 \n 2.타인의 정보도용 \n 3. 회사가 게시한 정보의 변경 \n 4. 회사가 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시\n 5. 회사와 기타 제3자의 저작권 등 지적재산권에 대한 침해\n 6. 회사 및 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위\n 7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 서비스에 공개 또는 게시하는 행위\n 8. 회사의 동의 없이 영리를 목적으로 서비스를 사용하는 행위\n 9. 기타 법령, 선량한 풍속 기타 사회통념에 반하거나 본 약관 및 회사의 정책을 위반하는 행위";