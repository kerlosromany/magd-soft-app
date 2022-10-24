import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class SpecificButtonWidget extends StatelessWidget {
  String txt;
  double width;
  VoidCallback onTap;
  SpecificButtonWidget({Key? key, required this.txt, required this.width ,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              AppColor.privateBlue,
              AppColor.privateBlue.withOpacity(0.5),
              AppColor.privateBlue.withOpacity(0.3),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          txt,
          style: getRegularStyle(fontSize: 20, color: AppColor.white),
        ),
      ),
    );
  }
}
