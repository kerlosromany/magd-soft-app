import 'package:dio/dio.dart';
import '../../data_providers/remote/dio_helper.dart';
import '../../models/products_model.dart';

import '../../../constants/end_points.dart';

class ProductsRequest {
  static Future<Response> getAllProducts() async {
    try {
      Response response = await DioHelper.getData(url: getProductsEndPoint);
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
