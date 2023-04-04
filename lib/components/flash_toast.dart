import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:librarymanagement/constants.dart';

class ShowToast {
  String msg;
  ShowToast(this.msg);

  static error(msg) async => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
  static success(msg) async => Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}
