import 'package:dio/dio.dart';
import '../../../constants/end_points.dart';

import '../../data_providers/remote/dio_helper.dart';

class VerifyRequest {
  static Future<Response> sendVerifiedUserData(
      {required String code, required String phone}) async {
    try {
      Response response = await DioHelper.postData(
        url: otpEndPoint,
        body: {
          "code": code,
          "phone": phone,
        },
      );
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
