import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future removeToast(String msg) {
  return Fluttertoast.showToast(
      msg: '${msg.toUpperCase()} removed from cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future addToast(String msg) {
  return Fluttertoast.showToast(
      msg: '${msg.toUpperCase()} added to cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0);
}

showToast(String msg) {
  return Fluttertoast.showToast(
    backgroundColor: Colors.blue,
    msg: msg ?? '',
    toastLength: Toast.LENGTH_LONG,
    textColor: Colors.white,
    timeInSecForIosWeb: 8,
  );
}
