import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';

class LoginWithSocialWidget extends StatelessWidget {
  String imagePath;
  double width;
  double height;
  LoginWithSocialWidget({Key? key ,required this.imagePath , required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey.withOpacity(0.3),
              offset: const Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
