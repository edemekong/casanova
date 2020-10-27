import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showSnackbarSuccess(context, {String msg}) {
  Flushbar(
    padding: const EdgeInsets.all(16),
    message: msg,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.green[300],
    ),
    animationDuration: Duration(milliseconds: 500),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.green[600],
  )..show(context);
}

showSnackbarFailed(context, {String msg}) {
  Flushbar(
    message: msg,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.red[300],
    ),
    animationDuration: Duration(milliseconds: 500),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: Colors.red[600],
  )..show(context);
}

showSnackbar(context, {String msg, IconData icon}) {
  Flushbar(
    message: msg,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    icon: Icon(
      icon,
      size: 28.0,
      color: Colors.orange[400],
    ),
    animationDuration: Duration(milliseconds: 500),
    duration: Duration(seconds: 5),
    leftBarIndicatorColor: Colors.orange[600],
  )..show(context);
}

showSnackbarTop(context, {String msg, String quantity}) {
  Positioned(
    top: 100,
    child: Flushbar(
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(msg,
              style: TextStyle(
                color: Colors.white,
              )),
          Text(quantity,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold))
        ],
      ),
      icon: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.orange,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      animationDuration: Duration(milliseconds: 300),
      duration: Duration(seconds: 5),
    )..show(context),
  );
}
