import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class ProductsBackgroundImage extends StatelessWidget {
  double screenHeight;
  ProductsBackgroundImage({Key? key, required this.screenHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Container(
        width: double.infinity,
        height: screenHeight / 3.7,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/productsimage.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Release",
                style: getLightStyle(fontSize: 14, color: AppColor.white),
              ),
              Text(
                "Acer Predator Helios 300",
                style: getLightStyle(fontSize: 14, color: AppColor.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
