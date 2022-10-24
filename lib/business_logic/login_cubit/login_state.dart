import 'package:flutter/material.dart';
import '../../data/models/verify_model.dart';

import '../../data/models/account_model.dart';

@immutable
abstract class LoginState{}

class LoginInitialState extends LoginState{}


class LoginLoadingState extends LoginState{}

class LoadedUserDataState extends LoginState {
  final AccountModel accountModel;

  LoadedUserDataState(this.accountModel);
  
}

class ErrorUserDataState extends LoginState {
  final String errorMessage;

  ErrorUserDataState(this.errorMessage);
}


///////////verify//////////


class VerifyLoadingState extends LoginState{}

class LoadedVerifyUserDataState extends LoginState {
  final VerifiedModel verifiedModel;

  LoadedVerifyUserDataState(this.verifiedModel);
  
}

class ErrorVerifyUserDataState extends LoginState {
  final String errorMessage;

  ErrorVerifyUserDataState(this.errorMessage);
}



class ChangeCodeTextState extends LoginState{}