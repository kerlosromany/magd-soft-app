import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';

class ImageContainerWidget extends StatelessWidget {
  String imagePath;
  bool isNetworkImage;
  double screenWidth;
  double screenHeight;
  double borderRadius;
  bool isPadding;
  Color color;
  ImageContainerWidget({
    Key? key,
    required this.imagePath,
    required this.isNetworkImage,
    required this.screenHeight,
    required this.screenWidth,
    required this.borderRadius,
    required this.isPadding,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding?const  EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0) : EdgeInsets.zero,
      child: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: const [
            BoxShadow(
                blurRadius: 5, color: AppColor.grey, offset: Offset(0, 4)),
          ],
          image: isNetworkImage
              ? DecorationImage(
                  image: NetworkImage(imagePath),
                )
              : DecorationImage(
                  image: AssetImage(imagePath),
                ),
          color: color,
        ),
      ),
    );
  }
}
