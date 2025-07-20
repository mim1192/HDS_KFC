import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class T {
  static void message(String msg) {

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        fontSize: 16.0);
  }
}
