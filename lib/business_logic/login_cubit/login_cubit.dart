import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import '../../data/models/verify_model.dart';
import '../../data/network/responses/verify_response.dart';

import '../../data/models/account_model.dart';
import '../../data/network/responses/login_response.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginResponse loginResponse;
  final VerifyResponse verifyResponse;
  LoginCubit(this.loginResponse, this.verifyResponse)
      : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  AccountModel? accountModel;
  getUserData({required String name, required String phone}) {
    emit(LoginLoadingState());
    loginResponse.getUserData(name: name, phone: phone).then((accountModel) {
      this.accountModel = accountModel;
      emit(LoadedUserDataState(accountModel));
    }).catchError((e) {
      emit(ErrorUserDataState(e.toString()));
    });
    return accountModel;
  }

  VerifiedModel? verifiedModel;
  getVerifiedUserData({required String code, required String phone}) {
    emit(VerifyLoadingState());
    verifyResponse
        .getVerifiedUserData(code: code, phone: phone)
        .then((verifiedModel) {
      this.verifiedModel = verifiedModel;
      emit(LoadedVerifyUserDataState(verifiedModel));
    }).catchError((e) {
      emit(ErrorVerifyUserDataState(e.toString()));
    });
    return verifiedModel;
  }

  String codeText = "";
  void changeCodeTextByAdding(value) {
    codeText = "$codeText$value";
    emit(ChangeCodeTextState());
  }

 

}
