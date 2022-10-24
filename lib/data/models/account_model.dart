class AccountModel {
   int? status;
   String? message;
  String? code;

  AccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
  }
}
