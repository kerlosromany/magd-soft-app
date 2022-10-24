import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../styles/colors.dart';
import '../styles/styles.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(
          width: 1,
          color: AppColor.grey,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            color: AppColor.grey,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.search, color: AppColor.privateGrey),
            hintText: "Search",
            hintStyle: getLightStyle(fontSize: 16, color: AppColor.privateGrey),
          ),
        ),
      ),
    );
  }
}
