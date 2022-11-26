import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';


class DetailScreen extends StatefulWidget {

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    int _mylike = 0;
     int _Likes = 0;
     
    final _index = ModalRoute.of(context)!.settings.arguments;
    int _Index = int.parse(_index.toString());
    final data = FirebaseFirestore.instance.collection('Contents').doc().get();
    return Scaffold(
      backgroundColor: Color(0XFFF3F4F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Color(0XFFCFD2D9),),
          onPressed: () {
            Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
          },
        ),
        elevation: 1,
        backgroundColor: Color(0XFFFAFBFB),
        title: Text('커뮤니티',style: titleLargeStyle(),),
      ),
      body:Column(children: [
           StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Contents').snapshots(),
          builder: (context, snapshot) {
            return  Container(
                padding: EdgeInsets.fromLTRB(23, 17, 25, 12.58),
                height: _height(snapshot.data!.docs[_Index]['imageUrl']),
                //  decoration: BoxDecoration(
                //    border: Border.all(color: Colors.blueAccent),
                //    color: Colors.white
                //           ),
                  color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.docs[_Index]['category'] ? '도로 위가 궁금해요' : '캐치가 궁금해요',style: labelSmallStyle(color: Color(0XFF9FA5B2)),
                              textAlign: TextAlign.start,
                          ),
                      SizedBox(height: 10),
                      Row(                                 // 질문 부분
                          children: [
                             ClipOval(
                               child:  Image.asset('assets/logo.png',height: 25,width: 25,),
                             ),
                             SizedBox(width: 5),
                              Column(
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                Text(snapshot.data!.docs[_Index]['displayName'],style: labelSmallStyle(color: Color(0xFF1A1A1A))),
                                Text(snapshot.data!.docs[_Index]['adress'],style: labelSmallStyle(color: Color(0XFF9FA5B2))),
                              ],)
                          ],
                      ),
                      _image(snapshot.data!.docs[_Index]['imageUrl']), // 사진 위젯
                      Text(snapshot.data!.docs[_Index]['contents'],style: bodyMediumStyle(color: Color(0xFF1A1A1A))),
                      SizedBox(height: 20),
                      Center(                                         // 디바이더 위젯
                        child: SizedBox(
                            width: 350,
                            child: Divider(
                                thickness: 1,
                                height: 1,
                            ),
                        ),
                      ),
                      SizedBox(height: 13),
                      SizedBox(
                          height: 12,
                          child: Row(
                              children: [
                                IconButton(
                                  color: Color(0XFF878E9F),
                                  constraints: BoxConstraints(maxHeight: 15),
                                  padding: EdgeInsets.all(0.0),
                                  // alignment: Alignment.topLeft,
                                  iconSize: 14,
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () {

                                  },
                                ),
                                SizedBox(width: 4,),
                                Text(snapshot.data!.docs[_Index]['like'].toString(),style: labelSmallStyle(color: Color(0XFF9FA5B2)),),
                                SizedBox(width: 17,),
                               IconButton(
                                  color: Color(0XFF878E9F),
                                  constraints: BoxConstraints(maxHeight: 15),
                                  //alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(0.0),
                                  iconSize: 14,
                                  icon: Icon(Icons.chat_bubble_outline),
                                  onPressed: () {print(('chat'));},
                                ),
                                 SizedBox(width: 4,),
                                Text(snapshot.data!.docs[_Index]['_comment'].length==0 ? '댓글' : '댓글 ${snapshot.data!.docs[_Index]['_comment'].length.toString()}',style: labelSmallStyle(color: Color(0XFF9FA5B2)))
                              ],
                          ),
                      ),
                      ]),
            );
          }),
             StreamBuilder<QuerySnapshot>(
                 stream: FirebaseFirestore.instance.collection('Contents').snapshots(),
                 builder: (context, snapshot) {
                    if(snapshot.data!.docs[_Index]['_comment'].length == 0) {
                           return  Container(
                             margin: EdgeInsets.only(top: 70),
                             child: Align(
                               child:  Text('   아직 댓글이 없어요 :(\n가장 먼저 댓글을 남겨보세요',style: labelSmallStyle(color: Color(0XFF9FA5B2))),
                               alignment: Alignment.center,
                               ),
                           );
                           } 
                    else return Expanded(
                      child: ListView.builder(
                       itemCount: snapshot.data!.docs[_Index]['_comment'].length,
                       itemBuilder: (context, _index) {
                        return Text('hello');
                              })
                              );
                          }
                        ), 

        ],),
    );
  }
  Widget _image(List imageList) {     // 이미지 위젯
   int _num = imageList.length-2;
     if(imageList.length ==0) {       // 사진 없을 때
       return SizedBox(height: 22); 
     } else if(imageList.length==1){
     return Container(
       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
       height: 190,
       width:double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[0].toString(),fit :BoxFit.fill))
     );
   } else { //사진 있을 때
     return Container(
       width: double.infinity,
       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
       child: Row(children: [
         ClipRRect(
         borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[0].toString(),fit :BoxFit.fill,height: 160,width: 165,)),
         SizedBox(width: 10),
          ClipRRect(
         borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[1].toString(),fit :BoxFit.fill,height: 160,width: 165,)),
       ]));
   }
  }
   _height(List length) {
    if(length.length ==0) {
      return 165.0;
    } else if(length.length==1) {
      return 365.0;
      }
  }
}