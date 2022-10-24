import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/global_cubit/global_cubit.dart';

import '../widget/button_for_showing_products.dart';

class CategoriesView extends StatelessWidget {
  double screenHeight;
  double screenWidth;
  CategoriesView(
      {Key? key, required this.screenHeight, required this.screenWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<GlobalCubit>(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonForShowingProductsWidget(
              imagePath: 'assets/images/all.png',
              txt: "All",
              activeIndex: 0,
              onTap: () {
                cubit.changeCategoriesState(0);
              },
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            ButtonForShowingProductsWidget(
              imagePath: 'assets/images/acer.png',
              txt: "Acer",
              activeIndex: 1,
              onTap: () {
                cubit.changeCategoriesState(1);
              },
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            ButtonForShowingProductsWidget(
              imagePath: 'assets/images/razer.png',
              txt: "Razer",
              activeIndex: 2,
              onTap: () {
                cubit.changeCategoriesState(2);
              },
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            ButtonForShowingProductsWidget(
              imagePath: 'assets/images/ios.png',
              txt: "Apple",
              activeIndex: 3,
              onTap: () {
                cubit.changeCategoriesState(3);
              },
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
          ],
        );
      },
    );
  }
}
