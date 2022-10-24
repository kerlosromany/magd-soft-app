import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/models/products_model.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<Products> wishList =
            BlocProvider.of<GlobalCubit>(context).wishList;

        return Scaffold(
          body: ConditionalBuilder(
            condition: wishList.isNotEmpty,
            fallback: (context) => Container(
              height: double.infinity,
              decoration: getBoxDecorationStyle(),
              child: Center(
                child: Text(
                  "No Wish List Data",
                  style:
                      getBoldStyle(fontSize: 15, color: AppColor.privateBlack),
                ),
              ),
            ),
            builder: (context) => Container(
              height: double.infinity,
              decoration: getBoxDecorationStyle(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.separated(
                  itemCount: wishList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(wishList[index].image),
                      title: Text(wishList[index].company),
                      subtitle: Text(wishList[index].description,
                          maxLines: 3, overflow: TextOverflow.ellipsis),
                      trailing: Text(wishList[index].company),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: AppColor.privateBlack,
                      thickness: 2,
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
