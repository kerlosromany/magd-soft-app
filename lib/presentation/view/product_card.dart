import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/global_cubit/global_cubit.dart';
import '../../data/data_providers/local/cache_helper.dart';
import '../../data/models/products_model.dart';
import '../router/app_router.dart';
import '../styles/styles.dart';

import '../styles/colors.dart';

class ProductItemWidget extends StatefulWidget {
  Products product;
  double screenWidth;
  double screenHeight;
  ProductItemWidget({
    Key? key,
    required this.product,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  List<Products> wishList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<GlobalCubit>(context);

        return Container(
          height: widget.screenHeight / 2.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(5, 5),
                color: AppColor.grey,
              ),
            ],
            color: AppColor.white,
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Build Product Image & favorite Icon
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRouterConstants.detailsScreenRoute,
                            arguments: widget.product);
                      },
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            SizedBox(height: widget.screenHeight / 33),
                            Expanded(
                              child: Image.network(
                                widget.product.image,
                              ),
                            ),
                          ],
                        ),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: CacheHelper.getDataFromSharedPreference(
                                    key: '${widget.product.id}') ??
                                false
                            // widget.product.isFavorite
                            ? AppColor.red
                            : AppColor.grey,
                      ),
                      onPressed: () async {
                        setState(() {
                          widget.product.isFavorite =
                              !widget.product.isFavorite;
                        });
                        if (!widget.product.isFavorite) {
                          cubit.removeWishListData(
                            widget.product.id,
                            widget.product.isFavorite,
                          );
                          CacheHelper.removeData(key: '${widget.product.id}');
                        } else {
                          cubit.storeWishListData(
                            id: widget.product.id,
                            image: widget.product.image,
                            company: widget.product.company,
                            type: widget.product.type,
                            description: widget.product.description,
                            name: widget.product.name,
                            price: widget.product.price,
                            favorite: true,
                          );
                          CacheHelper.saveDataSharedPreference(
                            key: '${widget.product.id}',
                            value: true,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              /////////////////////////////
              // show company and name product
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.product.company,
                    style: getMediumStyle(
                        fontSize: 15, color: AppColor.privateBlue),
                  ),
                  Text(widget.product.name,
                      style: getMediumStyle(
                          fontSize: 13, color: AppColor.privateGrey2)),
                ],
              ),
              /////////////////////////////
              // show Price and add to cart product
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.product.price} EGP',
                      style: getLightStyle(
                          fontSize: 12, color: AppColor.privateGrey2),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.privateBlue,
                              AppColor.privateBlue.withOpacity(0.4),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30))),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: AppColor.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              /////////////////////////////////
            ],
          ),
        );
      },
    );
  }
}
