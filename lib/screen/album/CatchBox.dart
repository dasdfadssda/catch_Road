import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../utils/app_text_styles.dart';
import 'catchbox_detail.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Catchbox extends StatefulWidget {
  const Catchbox({Key? key}) : super(key: key);

  @override
  _CatchboxState createState() => _CatchboxState();
}

class _CatchboxState extends State<Catchbox> {
  final storageRef = FirebaseStorage.instance.ref();

  Reference ref = FirebaseStorage.instance
      .ref()
      .child('gallery')
      .child('motorcycle')
      .child('motorcycle1.png');

  Future<void> _downloadLink(Reference ref) async {
    final link = await ref.getDownloadURL();

    await Clipboard.setData(
      ClipboardData(
        text: link,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Success!\n Copied download URL to Clipboard!',
        ),
      ),
    );
  }

  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String imageName) async {
    String url = await storage.ref('$imageName').getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset("assets/icons/icon_back.png"),
          onPressed: (){
         //   Get.back();
          },
        ),
        centerTitle: true,
        title: Text('캐치박스'),//,style: titleMedium.copyWith(color: Colors.black),),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Text(''),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('category').doc("1234@handong.ac.kr").collection('category').orderBy('category', descending: true).snapshots(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: Center(
                              child: GridView.count(
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  childAspectRatio: 19 / 20,
                                  children: List.generate(snapshot.data!.docs.length, (index) {
                                    QueryDocumentSnapshot x = snapshot.data!.docs[index];
                                    return InkWell(
                                      onTap: (){
                                        //_selectedDate = '';
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Catchbox_detail(query: x),));
                                        // 밑에꺼로 정보 넘겨줘야함.
                                        //Catchbox_detail(query: x),));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 165.65,
                                            width: 160.65,
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(4.76),
                                              ),

                                              clipBehavior: Clip.antiAlias,
                                              child: Image.network(
                                                x['new'],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Container(
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 5),
                                                  Container(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            x['category'],
                                                            style: Theme.of(context).textTheme.labelMedium,
                                                            maxLines:1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          //const SizedBox(height: 8.0),
                                                          // Text(
                                                          //   "${snapshot.data!.docs[index]['count']}",
                                                          //   //FirebaseFirestore.instance.collection('category').doc('user1').collection(snapshot.data!.docs[index]['category']).doc('date').collection('date').snapshots().length.toString(),
                                                          //   style: Theme.of(context).textTheme.labelSmall,
                                                          // ),
                                                        ],
                                                      )
                                                  )
                                                ],
                                              )
                                          ),
                                          //SizedBox(height: 12)
                                        ],
                                      ),
                                    );
                                  },
                                  )
                              )
                          ),
                        );
                      }
                      else{
                        return Center(child: CircularProgressIndicator());
                      }
                    }
                )
            ),
          ],
        ),
      ),
    );
  }
}