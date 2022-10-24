import 'package:dio/dio.dart';
import '../../models/products_model.dart';
import '../requests/products_request.dart';

class ProductsResponse {
  late ProductModel productModel;
  Future<List<Products>> getAllProducts() async {
    Response response = await ProductsRequest.getAllProducts();
    //print(response.data.toString());
    productModel = ProductModel.fromJson(response.data);
    List<dynamic> products = productModel.products;
    //print(products.toString());
    return products.map((product) => Products.fromJson(product)).toList();
  }
}
