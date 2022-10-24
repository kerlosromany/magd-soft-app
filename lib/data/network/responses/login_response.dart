import 'package:dio/dio.dart';
import '../../models/account_model.dart';
import '../requests/login_request.dart';

import '../requests/products_request.dart';

class LoginResponse {
  late AccountModel accountModel;
  Future<AccountModel> getUserData(
      {required String name, required String phone}) async {
    Response response =
        await LoginRequest.sendUserData(name: name, phone: phone);
    //print(response.data.toString());
    accountModel = AccountModel.fromJson(response.data);
    // List<dynamic> products = productModel.products;
    // //print(products.toString());
    // return products.map((product) => Products.fromJson(product)).toList();
    return accountModel;
  }
}
