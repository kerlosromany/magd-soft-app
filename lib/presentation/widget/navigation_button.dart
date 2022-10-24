import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';

class NavigationButtonWidget extends StatelessWidget {
  VoidCallback onTap;
  double screenHeight;
  double screenWidth;
  NavigationButtonWidget(
      {Key? key,
      required this.onTap,
      required this.screenHeight,
      required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: screenWidth / 8,
          height: screenHeight / 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 10, color: AppColor.grey, offset: Offset(0, 8)),
            ],
            color: AppColor.white,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp,
                color: AppColor.grey),
            onPressed: onTap,
          ),
        ),
      ],
    );
  }
}
