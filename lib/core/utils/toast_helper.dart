import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  static void show(String? message) {
    Fluttertoast.showToast(
      msg: (message == null || message.isEmpty)
          ? "Something went wrong"
          : message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}

