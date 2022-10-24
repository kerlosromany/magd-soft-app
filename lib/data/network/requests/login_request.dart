import 'package:dio/dio.dart';
import '../../../constants/end_points.dart';
import '../../data_providers/remote/dio_helper.dart';
import '../../models/account_model.dart';
import '../responses/login_response.dart';
import '../../../presentation/widget/toast.dart';

class LoginRequest {
  static Future<Response> sendUserData(
      {required String name, required String phone}) async {
    try {
      Response response = await DioHelper.postData(
        url: verifyPhoneEndPoint,
        body: {
          "name": name,
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
