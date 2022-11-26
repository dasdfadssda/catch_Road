import 'package:catch2_0_1/Auth/auth_service.dart';
import 'package:catch2_0_1/utils/app_text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  
}
// snapshot.data!.docs[index][''] // 불러올 떄 쓰는 방법
class _HomePageState extends State<HomePage> {
  
final FirebaseAuth _auth = FirebaseAuth.instance;
var _toDay = DateTime.now(); // 시간 비교 하기
int _mylike = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFF3F4F5),
      appBar:  AppBar( // 앱바
        backgroundColor: Colors.white,
        elevation: 0,
         shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0)),
      title:TextButton(
        child:  Center(child: Text('양덕동 외 1곳',style:SubTitleStyle(color: Colors.black),)), 
        onPressed: (){
        },
      ),
      actions: [
        Row(children: [
          IconButton( // 추후 검색 버튼 
          onPressed: () {}, 
          icon: Icon(Icons.search,color: Color(0XFF3A94EE),)),
          SizedBox(width: 23.2)
        ],) 
      ],
      bottom: buildAppBarBottom()
      ),
     body : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Contents').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('  업로드 된\n글이 없어요 :(',style: labelLargeStyle(color: Color(0XFF9FA5B2)),));
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                        Navigator.pushNamed(context, '/detail',
                            arguments: index);
                              print(index);
                      },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 7),
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(19, 17, 19, 12.43),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(snapshot.data!.docs[index]['category'] ? '도로 위가 궁금해요' : '캐치가 궁금해요',style: labelSmallStyle(color: Color(0XFF9FA5B2)),
                        textAlign: TextAlign.start,
                    ),
                SizedBox(height: 10),
                Row(                                 // 질문 부분
                    children: [
                        Text(
                          'Q.',style: bodyMediumStyle(color: Color(0XFF3174CD)),
                        ),
                        Text(
                           snapshot.data!.docs[index]['contents'],style: bodyMediumStyle(color: Color(0xFF1A1A1A)),
                        ),
                    ],
                ),
                _image(snapshot.data!.docs[index]['imageUrl']), // 사진 위젯
                
                Row(
                    children: [
                        Text('${snapshot.data!.docs[index]['displayName']}',style: labelSmallStyle(color: Color(0XFF9FA5B2))),
                        Text(' ·${snapshot.data!.docs[index]['adress']}',style: labelSmallStyle(color: Color(0XFF9FA5B2))),
                        Flexible(child: SizedBox(width: 300)),
                        // Container(
                        //   child: Text('33분 전',style: LabelsmallStyle(color: Color(0XFF9FA5B2)),),
                        // ),
                    ],
                ),
                SizedBox(height: 16),
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
                            // color: _mylike==0 ? Color(0XFF878E9F): Color(0XFF3A94EE),
                            color: Color(0XFF878E9F),
                            constraints: BoxConstraints(maxHeight: 15),
                            padding: EdgeInsets.all(0.0),
                            // alignment: Alignment.topLeft,
                            iconSize: 14,
                            icon: Icon(_mylike==0 ? Icons.favorite_border : Icons.favorite),
                            // icon: Icon(Icons.favorite_border_outlined),
                            onPressed: () {
                              setState(() {
                     if(snapshot.data!.docs[index]['_like'].length != 0){
                             for(int i=0; i<snapshot.data!.docs[index]['_like'].length; i++) {
                             if(snapshot.data!.docs[index]['_like'][i] == FirebaseAuth.instance.currentUser!.displayName!) {
                               print('있어');
                               LikeDeleteFunction(snapshot.data!.docs[index]['_like'],snapshot.data!.docs[index]['id'],FirebaseAuth.instance.currentUser!.displayName!,);
                               _mylike = 0;
                               break;
                             } else {
                               print('없어');
                               _mylike = 1;
                              LikeFunction(snapshot.data!.docs[index]['_like'],snapshot.data!.docs[index]['id'],FirebaseAuth.instance.currentUser!.displayName!,);
                             }
                           }
                     } else {
                       LikeFunction(snapshot.data!.docs[index]['_like'],snapshot.data!.docs[index]['id'],FirebaseAuth.instance.currentUser!.displayName!,);
                     }
                       });},
                          ),
                          SizedBox(width: 4,),
                          Text(snapshot.data!.docs[index]['_like'].length.toString(),style: labelSmallStyle(color: Color(0XFF9FA5B2)),),
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
                          Text(snapshot.data!.docs[index]['_comment'].length==0 ? '댓글' : '댓글 ${snapshot.data!.docs[index]['_comment'].length.toString()}',style: labelSmallStyle(color: Color(0XFF9FA5B2)))
                        ],
                    ),
                )
                ])
                    ),
                  );
                  }
                 );
        }),
    floatingActionButton: FloatingActionButton( // 플로팅 액션 버튼
        onPressed: () {
          //  Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => AddPage()),
          // );
        },
        child: Icon(Icons.edit_outlined),
        backgroundColor: Colors.blueAccent,
      ),
    );
  } 

    bool _all = true;
  bool _catch = false;
  bool _road = false;

  PreferredSizeWidget buildAppBarBottom() { // 바텀바 부분 
    return PreferredSize(
      preferredSize: Size.fromHeight(50),  
      child:Container(
        height: 30,
        margin: EdgeInsets.fromLTRB(25, 0, 15,20),
          child :  Row(
             mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _AllButton(),
              _roadButton(),
              _catchButton()
          ],),
        )
    );
  }

  Widget _AllButton() { // 앱바의 전체 버튼
    return Container(
                width: 55,
                child: ElevatedButton(
           style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(100),
                 ),
             elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
            primary: _all ? Color(0XFF3A94EE) : Color(0XFFF2F8FE),
            onPrimary: _all? Colors.white : Color(0XFF9FA5B2) ,
          ),
           onPressed: (){
            setState(() {
               _all = true;
               _road = false;
                _catch = false;
               print("전체 ${_all}");
            });
           }, 
       child: Text('전체')),
              );
  }

  
    Widget _roadButton() { // 앱바의 로드 버튼
    return Container(
      margin: EdgeInsets.only(left: 17),
      alignment: Alignment.center,
                width: 130,
                child: ElevatedButton(
           style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(100),
                 ),
             elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
            primary: _road ? Color(0XFF3A94EE) : Color(0XFFF2F8FE),
            onPrimary: _road? Colors.white : Color(0XFF9FA5B2) ,
          ),
           onPressed: (){
            setState(() {
               _road = true;
               _all = false;
               _catch = false;
               print("도로가 ${_road}");
            });
           }, 
       child: Text('도로 위가 궁금해요')),
              );
  }
 
 Widget _catchButton() { // 앱바의 캐피 버튼
    return Container(
      margin: EdgeInsets.only(left: 12),
      alignment: Alignment.center,
                width: 122,
                child: ElevatedButton(
           style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(100),
                 ),
             elevation: 0,
            textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),
            primary: _catch ? Color(0XFF3A94EE) : Color(0XFFF2F8FE),
            onPrimary: _catch? Colors.white : Color(0XFF9FA5B2) ,
          ),
           onPressed: (){
            setState(() {
               _road = false;
               _all = false;
               _catch = true;
               print("캐치가 ${_catch}");
            });
           }, 
       child: Text('캐치가 궁금해요')),
              );
  }
   Widget _image(List imageList) { // 이미지 위젯
   int _num = imageList.length-2;
     if(imageList.length ==0) { // 사진 없을 때
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
   } else if(imageList.length==2){ //사진 있을 때
     return Container(
       width: double.infinity,
       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
       child: Row(children: [
         ClipRRect(
         borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[0].toString(),fit :BoxFit.fill,height: 160,width: 161,)),
         SizedBox(width: 10),
          ClipRRect(
         borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[1].toString(),fit :BoxFit.fill,height: 160,width: 161,)),
       ]));
   } else {
     return Container( // 사진 3개 이상
       width: double.infinity,
       margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
       child: Row(children: [
         ClipRRect(
         borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[0].toString(),fit :BoxFit.fill,height: 160,width: 161,)),
         SizedBox(width: 10),
        Stack(children: [
           ClipRRect(
         borderRadius: BorderRadius.circular(7.0),
        child: Image.network(imageList[1].toString(),fit :BoxFit.fill,height: 160,width: 161,)),
        Container(
           alignment: Alignment.center,
         decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(7.0),
          color: Colors.black54,
          ),
          height: 160,
          width: 161,
          child: Text('+${_num}',textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),  
        ),
        ],)
       ],),
     );
   }
  }
}