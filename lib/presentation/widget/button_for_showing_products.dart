import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/global_cubit/global_cubit.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class ButtonForShowingProductsWidget extends StatelessWidget {
  final String imagePath;
  final String txt;
  int activeIndex;
  VoidCallback? onTap;
  double screenHeight;
  double screenWidth;

  ButtonForShowingProductsWidget({
    Key? key,
    required this.imagePath,
    required this.txt,
    required this.activeIndex,
    required this.screenHeight,
    required this.screenWidth,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<GlobalCubit>(context);

        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 49,
              vertical: screenHeight / 103,
            ),
            child: Container(
              width: screenWidth / 2.2,
              height: screenHeight / 16.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: activeIndex == cubit.activeIndex
                    ? AppColor.privateBlue
                    : AppColor.white,
                boxShadow: [
                  activeIndex == cubit.activeIndex
                      ? const BoxShadow(
                          blurRadius: 10,
                          color: AppColor.grey,
                          offset: Offset(0, 5),
                        )
                      : const BoxShadow(),
                ],
              ),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: Image.asset(imagePath),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        txt,
                        style: getMediumStyle(
                            fontSize: 18,
                            color: activeIndex == cubit.activeIndex
                                ? AppColor.white
                                : AppColor.privateBlack),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
