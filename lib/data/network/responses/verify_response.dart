
import 'package:dio/dio.dart';
import '../requests/verify_request.dart';

import '../../models/verify_model.dart';

class VerifyResponse {
  late VerifiedModel verifiedModel;
  Future<VerifiedModel> getVerifiedUserData(
      {required String code, required String phone}) async {
    Response response =
        await VerifyRequest.sendVerifiedUserData(code: code, phone: phone);
    //print(response.data.toString());
    verifiedModel = VerifiedModel.fromJson(response.data);
    
    // List<dynamic> products = productModel.products;
    // //print(products.toString());
    // return products.map((product) => Products.fromJson(product)).toList();
    return verifiedModel;
  }
}
