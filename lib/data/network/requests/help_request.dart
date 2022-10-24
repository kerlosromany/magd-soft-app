import 'package:dio/dio.dart';
import '../../../constants/end_points.dart';
import '../../models/help_model.dart';

import '../../data_providers/remote/dio_helper.dart';

class HelpRequest{
  static Future<Response> getRequest()async{
    try {
    Response response = await DioHelper.getData(url: getHelpEndPoint);
    return response;
  } catch (e) {
    print(e.toString());
    rethrow;
  }
  }
}
