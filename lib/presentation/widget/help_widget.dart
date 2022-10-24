import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/help');
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.white,
          border: Border.all(
            width: 1,
            color: AppColor.grey,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 20,
              color: AppColor.grey,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Image.asset('assets/images/help.png'),
      ),
    );
  }
}
