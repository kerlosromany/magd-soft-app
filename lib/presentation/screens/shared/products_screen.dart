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

import '../../view/product_card.dart';
import '../../view/products_categories_view.dart';
import '../../widget/button_for_showing_products.dart';
import '../../widget/help_widget.dart';
import '../../widget/products_background.dart';
import '../../widget/progress_indicator.dart';
import '../../widget/search.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late List<Products> searchedProducts;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlocProvider.of<GlobalCubit>(context);

        List<Products> allProducts =
            BlocProvider.of<GlobalCubit>(context).products;

        List<Products> acerProducts =
            allProducts.where((product) => product.company == "Acer").toList();

        List<Products> razerProducts =
            allProducts.where((product) => product.company == "Razer").toList();
        List<Products> appleProducts =
            allProducts.where((product) => product.company == "Apple").toList();
        List<Products> wishList = cubit.wishList;

        void addSearchedProductForSearchedList(searchedProduct) {
          searchedProducts = allProducts
              .where((product) =>
                  product.name.toLowerCase().startsWith(searchedProduct))
              .toList();
          setState(() {});
        }

        Widget _buildSearchField() {
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
                  border: InputBorder.none,
                  suffixIcon:
                      const Icon(Icons.search, color: AppColor.privateGrey),
                  hintText: "Search",
                  hintStyle:
                      getLightStyle(fontSize: 16, color: AppColor.privateGrey),
                ),
                onChanged: (searchedProduct) {
                  addSearchedProductForSearchedList(searchedProduct);
                },
              ),
            ),
          );
        }

        return Builder(builder: (context) {
          double screenWidthSize = MediaQuery.of(context).size.width;
          double screenHeightSize = MediaQuery.of(context).size.height;
          return Scaffold(
            body: Container(
              height: double.infinity,
              decoration: getBoxDecorationStyle(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: screenHeightSize / 20),
                      Row(
                        children: [
                          /* Build Search Field */
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: _buildSearchField(),
                            ),
                          ),
                          /* Build Help Field */
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: HelpWidget(),
                            ),
                          ),
                        ],
                      ),
                      // Build Background home Image
                      ProductsBackgroundImage(screenHeight: screenHeightSize),
                      // Build Companies Categories
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: CategoriesView(
                          screenWidth: screenWidthSize,
                          screenHeight: screenHeightSize,
                        ),
                      ),
                      // /////////////////////
                      if (cubit.activeIndex == 0)
                        showProducts(allProducts, context, screenHeightSize,
                            screenWidthSize, wishList)
                      else if (cubit.activeIndex == 1)
                        showProducts(acerProducts, context, screenHeightSize,
                            screenWidthSize, wishList)
                      else if (cubit.activeIndex == 2)
                        showProducts(razerProducts, context, screenHeightSize,
                            screenWidthSize, wishList)
                      else if (cubit.activeIndex == 3)
                        showProducts(appleProducts, context, screenHeightSize,
                            screenWidthSize, wishList)
                      else
                        const Center(
                          child: Text("No Data"),
                        )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  // Widget for show products in home screen
  Widget showProducts(List<Products> allProducts, context, screenHeight,
      screenWidth, List<Products> wishList) {
    return ConditionalBuilder(
      condition: allProducts.isNotEmpty,
      fallback: (context) => const Center(
          child: CircularProgressIndicator(
        color: AppColor.privateBlack,
      )),
      builder: (context) => Row(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: searchController.text.isEmpty
                  ? allProducts.length
                  : searchedProducts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return index.isEven
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 49,
                          vertical: screenHeight / 103,
                        ),
                        child: Column(
                          children: [
                            if (index == 0)
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: screenHeight / 29),
                                child: Text(
                                  "Recommended For You",
                                  style: getMediumStyle(
                                      fontSize: 15,
                                      color: AppColor.privateGrey2),
                                ),
                              ),
                            ProductItemWidget(
                              product: searchController.text.isEmpty
                                  ? allProducts[index]
                                  : searchedProducts[index],
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ],
                        ),
                      )
                    : Container();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: screenHeight / 82.5);
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: searchController.text.isEmpty
                  ? allProducts.length
                  : searchedProducts.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return index.isOdd
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth / 49,
                          vertical: screenHeight / 103,
                        ),
                        child: ProductItemWidget(
                          product: searchController.text.isEmpty
                              ? allProducts[index]
                              : searchedProducts[index],
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                      )
                    : Container();
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: screenHeight / 27.5);
              },
            ),
          ),
        ],
      ),
    );
  }
}
