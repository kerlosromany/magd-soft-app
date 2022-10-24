import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_providers/local/cache_helper.dart';
import '../../data/models/account_model.dart';
import '../../data/models/help_model.dart';
import '../../data/models/products_model.dart';
import '../../data/network/responses/login_response.dart';
import '../../presentation/screens/shared/home_screen.dart';
import '../../presentation/screens/shared/notifications_screen.dart';
import '../../presentation/screens/shared/products_screen.dart';
import '../../presentation/screens/user/wishlist_screen.dart';

import '../../data/network/responses/help_response.dart';
import '../../data/network/responses/products_response.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  final ProductsResponse productsResponse;
  final HelpResponse helpResponse;
  List<Products> products = [];
  List<Help> helps = [];

  GlobalCubit(this.productsResponse, this.helpResponse)
      : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of(context);

  List<Products> getAllProducts() {
    productsResponse.getAllProducts().then((products) {
      emit(LoadedProductsState(products));
      this.products = products;
    }).catchError((e) {
      emit(ErrorProductsState(e.toString()));
    });

    return products;
  }

  List<Help> getAllHelps() {
    helpResponse.getHelp().then((helps) {
      emit(LoadedHelpsState(helps));
      this.helps = helps;
    }).catchError((e) {
      emit(ErrorHelpsState(e.toString()));
    });

    return helps;
  }


////////////////////Login////////////////////
  

//////////////////////////////////////////////////////
  int currentIndex = 4;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const ProductsScreen();

  void changeNavBar(int index, Widget screen) {
    currentIndex = index;
    currentScreen = screen;
    emit(BottomNavBarChangeState());
  }

  int activeIndex = 0;
  void changeCategoriesState(int activeCategoryIndex) {
    activeIndex = activeCategoryIndex;
    emit(CategoriesChangeState());
  }

  ///////shared prefrences/////////
  List<Products> wishList = [];

  void storeWishListData({
    required int id,
    required String image,
    required String company,
    required String type,
    required String description,
    required String name,
    required String price,
    required bool favorite,
  }) async {
    Products product =
        Products(id, company, name, type, price, image, description, favorite);
    String productEncoded = jsonEncode(product);
    await CacheHelper.saveDataSharedPreference(
        key: "$id", value: productEncoded);
    //favorite = true;
    wishList.add(product);
    
    cacheWishList(wishList);
    emit(SaveToSharedPrefrencesState());
  }

  removeWishListData(id, fav) async {
    await CacheHelper.removeData(key: "$id");
    wishList.removeWhere((element) => element.id == id);
    cacheWishList(wishList);

    

    emit(RemoveSharedPrefrencesState());
  }

  cacheWishList(List<Products> products) async {
    List productsToJson = products
        .map<Map<String, dynamic>>((productModel) => productModel.toJson())
        .toList();
    await CacheHelper.saveDataSharedPreference(
        key: "CACHED_WISHLIST", value: json.encode(productsToJson));
  }

  getCachedWishList() {
    final jsonString =
        CacheHelper.getDataFromSharedPreference(key: "CACHED_WISHLIST");
    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<Products> jsonToProducts = decodedJsonData
          .map<Products>((jsonProduct) => Products.fromJson(jsonProduct))
          .toList();
      wishList = jsonToProducts;
      emit(GetCachedState());
    }
  }
}
