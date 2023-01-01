import 'package:flutter/cupertino.dart';

String _email = '';
String _password = '';
String _displayName = '';
String _id = '';
String _year = '';
String _month = '';
String _day = '';
String _nickname = '';
String _phoneNum = '';
String _bank = '';
String _bankNum = '';
String _bankName = '';

class code extends ChangeNotifier {
  String email = _email;
  String password = _password;
  String id = _id;
  String displayName = _displayName;
  String year = _year;
  String month = _month;
  String day = _day;
  String nickname = _nickname;
  String phoneNum = _phoneNum;
  String bank = _bank;
  String bankNum = _bankNum;
  String bankName = _bankName;

  notifyListeners();
}
