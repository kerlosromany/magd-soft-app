import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String errorMessage;
  String hintTextMessage;
  TextInputType textInputType;
  TextFormFieldWidget(
      {Key? key,
      required this.controller,
      required this.errorMessage,
      required this.hintTextMessage,
      required this.textInputType
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey.withOpacity(0.3),
              offset: const Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }
              return null;
            },
            keyboardType: textInputType,
            decoration: InputDecoration(

              hintText: hintTextMessage,
              hintStyle: getLightStyle(fontSize: 10, color: AppColor.grey),
              hintTextDirection: TextDirection.ltr,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
