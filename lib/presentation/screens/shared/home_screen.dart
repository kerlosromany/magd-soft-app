import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../business_logic/login_cubit/login_cubit.dart';
import '../../../data/models/products_model.dart';
import 'logout_screen.dart';
import 'notifications_screen.dart';
import 'products_screen.dart';
import '../user/wishlist_screen.dart';
import '../../styles/colors.dart';

import '../../../data/models/verify_model.dart';
import '../user/user_profile.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Products> allProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allProducts = BlocProvider.of<GlobalCubit>(context).getAllProducts();
    BlocProvider.of<GlobalCubit>(context).getCachedWishList();
    //BlocProvider.of<GlobalCubit>(context).getAllHelps();
    //BlocProvider.of<GlobalCubit>(context).getAllHelps();
    //print(BlocProvider.of<GlobalCubit>(context).getAllHelps().length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<GlobalCubit>(context);

        return Builder(builder: (context) {
          double screenHeightSize = MediaQuery.of(context).size.height;
          return Scaffold(
            body: PageStorage(
              bucket: cubit.bucket,
              child: cubit.currentScreen,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                cubit.changeNavBar(4, const ProductsScreen());
              },
              child: const Icon(Icons.home),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: SizedBox(
                height: screenHeightSize / 13.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        cubit.changeNavBar(0, const ProfileScreen());
                      },
                      minWidth: 40,
                      child: Icon(
                        Icons.settings,
                        color: cubit.currentIndex == 0
                            ? AppColor.privateBlue
                            : AppColor.privateGrey,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        cubit.changeNavBar(1, const NotificationsScreen());
                      },
                      minWidth: 40,
                      child: Icon(
                        Icons.notifications,
                        color: cubit.currentIndex == 1
                            ? AppColor.privateBlue
                            : AppColor.privateGrey,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        cubit.changeNavBar(2, WishListScreen());
                      },
                      minWidth: 40,
                      child: Icon(
                        Icons.favorite,
                        color: cubit.currentIndex == 2
                            ? AppColor.privateBlue
                            : AppColor.privateGrey,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        cubit.changeNavBar(3, const LogoutScreen());
                      },
                      minWidth: 40,
                      child: Icon(
                        Icons.subdirectory_arrow_right,
                        color: cubit.currentIndex == 3
                            ? AppColor.privateBlue
                            : AppColor.privateGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
