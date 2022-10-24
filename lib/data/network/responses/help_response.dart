import 'package:dio/dio.dart';
import '../../models/help_model.dart';
import '../requests/help_request.dart';

import '../requests/products_request.dart';

class HelpResponse {
  late HelpModel helpModel;
  Future<List<Help>> getHelp() async {
    Response response = await HelpRequest.getRequest();
    //print(response.data.toString());
    helpModel = HelpModel.fromJson(response.data);
    List<dynamic> helps = helpModel.help;
    //print(products.toString());
    return helps.map((help) => Help.fromJson(help)).toList();
  }
}