

import 'package:catch2_0_1/join/joinPage.dart';
import 'package:catch2_0_1/join/joinStep2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/auth_service .dart';
import '../LoginPage.dart';
import '../utils/app_text_styles.dart';
import 'joinPage7.dart';
import 'joinStep3.dart';


 String emailverify="";
bool alreadyuser=false;
bool sendemailverify=false;
List<String> UserList=[];

class EmailVerity extends StatefulWidget {
  const EmailVerity({Key? key}) : super(key: key);

  @override
  State<EmailVerity> createState() => _EmailVerityState();
}

class _EmailVerityState extends State<EmailVerity> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    sendemailverify=false;

    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('user');

    Future<void> getData() async {
      // Get docs from collection reference
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
     ;
      for(int i=0;i<querySnapshot.docs.length;i++){
        print(querySnapshot.docs[i].id);
        UserList.add(querySnapshot.docs[i].id);
      }



      print(UserList);
    }

    getData();
    setState(() {

    });
    return WillPopScope(
        child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height*0.05,),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: Center(child: Icon(Icons.verified_user_outlined, size:size.width*0.2,color: Colors.blue,)),
              ),
              SizedBox(height: size.height*0.05,),

              Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Text("이메일 인증을 완료해주세요\n 인증을 완료해야, 서비스를 이용하실 수 있습니다.",
                    textAlign: TextAlign.center),
              ),

              Padding(
                padding: EdgeInsets.only(top: size.height * 0.02),
                child: SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.07,
                  child: TextButton(
                    child: Text(
                      "이메일 인증 메일 전송하기",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),

                    onPressed: () async{

                      if(UserList.contains(emailCode().email)){
                        //print( FirebaseAuth.instance.currentUser);
                        showModalBottomSheet<void>(
                          enableDrag: true,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Container(
                                height: size.height * 0.275,
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height * 0.025),
                                    Text('이미 존재하는 이메일 입니다.',
                                        style: titleMediumStyle(
                                            color: Colors.black)
                                    ),
                                    SizedBox(height: size.height * 0.045),
                                    ElevatedButton(

                                        style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              Size(307, 50)),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                            Color(0xff3A94EE),
                                            //_onTap3? primary[40] : onSecondaryColor,
                                          ),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30.0),
                                              )),
                                        ),
                                        child: Text('로그인페이지로 이동하기',
                                            style: titleMediumStyle(
                                                color: Color(0xffFAFBFB))
                                        ),
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) {
                                                return LoginPage();
                                              }));
                                        })
                                  ],
                                ),
                              );
                            });
                          },
                        );

                      }
                      else{
                        // setState(() {
                        //   sendemailverify=true;
                        // });

                        print("${emailCode().email} ${passwordCode().password}" );
                        await signUpWithEmailAndPassword();
                        await loginWithIdandPassword(emailCode().email, passwordCode().password);

                        print(FirebaseAuth.instance.currentUser?.email);
                        print(FirebaseAuth.instance.currentUser?.emailVerified);

                        await FirebaseAuth.instance.currentUser?.sendEmailVerification();

                      }

                      print(alreadyuser);


                      // showModalBottomSheet<void>(
                      //   enableDrag: true,
                      //   isScrollControlled: true,
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.only(
                      //           topLeft: Radius.circular(30.0),
                      //           topRight: Radius.circular(30.0))),
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return StatefulBuilder(builder:
                      //         (BuildContext context, StateSetter setState) {
                      //       return Container(
                      //         height: size.height * 0.475,
                      //         padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      //         child: Column(
                      //           children: [
                      //             SizedBox(
                      //               height: size.height * 0.05,
                      //             ),
                      //             SizedBox(
                      //                 height: 150,
                      //                 child: Image.asset(
                      //                     'assets/checkToFinish.gif')),
                      //             SizedBox(
                      //               height: size.height * 0.025,
                      //             ),
                      //             Text('비밀번호 재설정 메일이 전송 되었습니다.'),
                      //             SizedBox(height: size.height * 0.025),
                      //             ElevatedButton(
                      //
                      //                 style: ButtonStyle(
                      //                   fixedSize: MaterialStateProperty.all(
                      //                       Size(307, 50)),
                      //                   backgroundColor:
                      //                   MaterialStateProperty.all(
                      //                     Color(0xff3A94EE),
                      //                     //_onTap3? primary[40] : onSecondaryColor,
                      //                   ),
                      //                   shape: MaterialStateProperty.all<
                      //                       RoundedRectangleBorder>(
                      //                       RoundedRectangleBorder(
                      //                         borderRadius:
                      //                         BorderRadius.circular(30.0),
                      //                       )),
                      //                 ),
                      //                 child: Text('확인',
                      //                     style: titleMediumStyle(
                      //                         color: Color(0xffFAFBFB))),
                      //                 onPressed: () {
                      //                   Navigator.push(context,
                      //                       MaterialPageRoute(builder: (context) {
                      //                         return LoginPage();
                      //                       }));
                      //                 })
                      //           ],
                      //         ),
                      //       );
                      //     });
                      //   },
                      // );



                    },

                  ),
                ),
              ),
              SizedBox(height: size.height*0.05),
              if(!UserList.contains(emailCode().email))
                OutlinedButton(
                  child: Text(
                    "이메일 인증 완료",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                        Size(200, 50)),
                    backgroundColor:
                    MaterialStateProperty.all(
                      Color(0xff3A94EE),
                      //_onTap3? primary[40] : onSecondaryColor,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30.0),
                        )),
                  ),
                  onPressed: () async{

                   // await loginWithIdandPassword(emailCode().email, passwordCode().password);

                    if(FirebaseAuth.instance.currentUser?.emailVerified==true){

                      showModalBottomSheet<void>(
                        enableDrag: true,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0))),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              height: size.height * 0.475,
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.05,
                                  ),
                                  SizedBox(
                                      height: 150,
                                      child: Image.asset(
                                          'assets/checkToFinish.gif')),
                                  SizedBox(
                                    height: size.height * 0.025,
                                  ),
                                  Text('이메일 인증이 완료 되었습니다.'),
                                  SizedBox(height: size.height * 0.025),
                                  ElevatedButton(

                                      style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                            Size(307, 50)),
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                          Color(0xff3A94EE),
                                          //_onTap3? primary[40] : onSecondaryColor,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30.0),
                                            )),
                                      ),
                                      child: Text('확인',
                                          style: titleMediumStyle(
                                              color: Color(0xffFAFBFB))),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return joinStep3();
                                            }));
                                      })
                                ],
                              ),
                            );
                          });
                        },
                      );
                    }

                    else{
                      print("이메일 인증을 완료해주세요.");

                      setState(() {
                        emailverify="";


                      });
                      Duration(milliseconds: 10);
                      setState(() {

                        emailverify="이메일 인증이 완료되지 않았습니다";
                      });
                    }




                  },

                ),
              SizedBox(height: size.height*0.01,),
              Text(emailverify,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),

            //  Text(alreadyuser.toString())



            ],
          ),

        )
    ),
         onWillPop:() async => false,

    );
  }
}
