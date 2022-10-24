import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

showToast(String? text, context , int sec) {
  final FToast fToast = FToast().init(context);
  Widget toast = Container(
    height: 65,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: AppColor.white,
    ),
    child: Text(text!),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: Duration(seconds: sec),
  );
}
