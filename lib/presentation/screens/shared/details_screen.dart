import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../router/app_router.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import '../../widget/navigation_button.dart';

import '../../../data/models/products_model.dart';
import '../../widget/image_container.dart';
import '../../widget/specific_button.dart';

class DetailsScreen extends StatelessWidget {
  final Products product;
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double screenWidthSize = MediaQuery.of(context).size.width;
      double screenHeightSize = MediaQuery.of(context).size.height;
      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: getBoxDecorationStyle(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidthSize / 35,
              vertical: screenHeightSize / 41,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: screenHeightSize / 27.5),
                  // Build arrow back
                  NavigationButtonWidget(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, AppRouterConstants.homeRoute);
                    },
                    screenHeight: screenHeightSize,
                    screenWidth: screenWidthSize,
                  ),
                  // Build Product Data
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      product.name,
                      style:
                          getSemiBoldStyle(fontSize: 15, color: AppColor.white),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      "Type : ${product.type}",
                      style: getLightStyle(fontSize: 15, color: AppColor.white),
                    ),
                  ),
                  // Build Product Image
                  ImageContainerWidget(
                    imagePath: product.image,
                    isNetworkImage: true,
                    screenHeight: screenHeightSize / 2.7,
                    screenWidth: double.infinity,
                    borderRadius: 20,
                    isPadding: true,
                    color: AppColor.white,
                  ),
                  // Build Row For Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageContainerWidget(
                          imagePath: 'assets/images/acer_1.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 8.5,
                          screenWidth: screenWidthSize / 4,
                          borderRadius: 20,
                          isPadding: true,
                          color: AppColor.white,
                        ),
                        ImageContainerWidget(
                          imagePath: 'assets/images/acer_2.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 8.5,
                          screenWidth: screenWidthSize / 4,
                          borderRadius: 20,
                          isPadding: true,
                          color: AppColor.white,
                        ),
                        ImageContainerWidget(
                          imagePath: 'assets/images/apple_1.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 8.5,
                          screenWidth: screenWidthSize / 4,
                          borderRadius: 20,
                          isPadding: true,
                          color: AppColor.white,
                        ),
                        ImageContainerWidget(
                          imagePath: 'assets/images/apple_2.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 8.5,
                          screenWidth: screenWidthSize / 4,
                          borderRadius: 20,
                          isPadding: true,
                          color: AppColor.white,
                        ),
                        ImageContainerWidget(
                          imagePath: 'assets/images/razer_1.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 8.5,
                          screenWidth: screenWidthSize / 4,
                          borderRadius: 20,
                          isPadding: true,
                          color: AppColor.white,
                        ),
                        ImageContainerWidget(
                          imagePath: 'assets/images/razer_2.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 8.5,
                          screenWidth: screenWidthSize / 4,
                          borderRadius: 20,
                          isPadding: true,
                          color: AppColor.white,
                        ),
                      ],
                    ),
                  ),
                  // Build LitsTile
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: screenHeightSize / 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.white,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 5,
                              color: AppColor.grey,
                              offset: Offset(0, 4)),
                        ],
                      ),
                      child: ListTile(
                        leading: ImageContainerWidget(
                          imagePath: 'assets/images/acer_logo.png',
                          isNetworkImage: false,
                          screenHeight: screenHeightSize / 15,
                          screenWidth: screenWidthSize / 6.5,
                          borderRadius: 5,
                          isPadding: false,
                          color: AppColor.white.withOpacity(0.8),
                        ),
                        title: Text(
                          "Acer Official Store",
                          style:
                              getLightStyle(fontSize: 13, color: AppColor.grey),
                        ),
                        subtitle: Text(
                          "view store",
                          style: getLightStyle(
                              fontSize: 11, color: AppColor.privateGrey),
                        ),
                        trailing: Container(
                          alignment: Alignment.center,
                          height: screenHeightSize / 23, //23
                          width: screenWidthSize / 10, // 11.2
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.privateGrey3,
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: AppColor.privateBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Build Price and cart button
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeightSize / 50),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "price",
                              style: getLightStyle(
                                  fontSize: 16, color: AppColor.privateGrey),
                            ),
                            Text(
                              "${product.price} EGP",
                              style: getLightStyle(
                                  fontSize: 12, color: AppColor.privateGrey2),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SpecificButtonWidget(
                          txt: "Add To Cart",
                          width: screenWidthSize / 1.8,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: AppColor.privateBlack,
                    endIndent: screenWidthSize / 15.68,
                    indent: screenWidthSize / 15.68,
                  ),
                  // Build Description for product
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeightSize / 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Overview",
                              style: getLightStyle(
                                  fontSize: 12, color: AppColor.privateBlack),
                            ),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.privateBlue.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Specification",
                          style: getLightStyle(
                              fontSize: 12, color: AppColor.privateGrey),
                        ),
                        Text(
                          "Review",
                          style: getLightStyle(
                              fontSize: 12, color: AppColor.privateGrey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product.description,
                    style: getMediumStyle(
                        fontSize: 16, color: AppColor.privateGrey),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
