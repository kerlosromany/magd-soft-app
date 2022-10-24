import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/login_cubit/login_cubit.dart';
import '../../../business_logic/login_cubit/login_state.dart';
import '../../../data/data_providers/local/cache_helper.dart';
import '../../router/app_router.dart';
import '../../styles/colors.dart';
import '../../widget/toast.dart';

import '../../../data/network/responses/login_response.dart';
import '../../../data/network/responses/verify_response.dart';
import '../../styles/styles.dart';
import '../../widget/specific_button.dart';
import '../user/user_profile.dart';

class VerifyPhoneScreen extends StatefulWidget {
  String phoneNumber;
  VerifyPhoneScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        
        var cubit = BlocProvider.of<LoginCubit>(context);
        if (state is LoadedVerifyUserDataState) {
          if (state.verifiedModel.message == "Account Verified") {
            CacheHelper.saveDataSharedPreference(
                key: 'id', value: state.verifiedModel.account!.id);
            Navigator.pushReplacementNamed(context, AppRouterConstants.homeRoute);
          } else if (state.verifiedModel.message == "code is wrong") {
            showToast("your code is wrong enter it again", context , 2);
            cubit.codeText = "";
          }
        }
      },
      builder: (context, state) {
        var cubit = BlocProvider.of<LoginCubit>(context);

        return Builder(builder: (context) {
          double screenWidthSize = MediaQuery.of(context).size.width;
          double screenHeightSize = MediaQuery.of(context).size.height;
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: getBoxDecorationStyle(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Verify Phone",
                      style: getLightStyle(fontSize: 25, color: AppColor.white),
                    ),
                    /* Build the code for input the userCode For verifing */
                    verifyCodeRow(context, screenWidthSize, screenHeightSize),
                    ////////////////////////////////////////////////////////////
                    Text(
                      "Resent Code",
                      style: getLightStyle(
                          fontSize: 22, color: AppColor.privateBlue),
                    ),
                    ConditionalBuilder(
                      condition: state is! VerifyLoadingState,
                      builder: (context) => SpecificButtonWidget(
                        txt: "Verify",
                        width: double.infinity,
                        onTap: () {
                          cubit.getVerifiedUserData(
                            code: cubit.codeText,
                            phone: widget.phoneNumber,
                          );
                        },
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

/* Build the code for input the userCode For verifing */
  Row verifyCodeRow(
      BuildContext context, double screenWidthSize, double screenHeightSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _textFieldOTP(
          first: true,
          last: false,
          context: context,
          screenWidth: screenWidthSize,
          screenHeight: screenHeightSize,
        ),
        _textFieldOTP(
          first: true,
          last: false,
          context: context,
          screenWidth: screenWidthSize,
          screenHeight: screenHeightSize,
        ),
        _textFieldOTP(
          first: true,
          last: false,
          context: context,
          screenWidth: screenWidthSize,
          screenHeight: screenHeightSize,
        ),
        _textFieldOTP(
          first: true,
          last: false,
          context: context,
          screenWidth: screenWidthSize,
          screenHeight: screenHeightSize,
        ),
      ],
    );
  }
  /////////////////////////////////////////////////

/*Build OTP */
  Widget _textFieldOTP(
      {required bool first, last, context, screenWidth, screenHeight}) {
    var cubit = BlocProvider.of<LoginCubit>(context);
    return Container(
      height: screenHeight / 15,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: AppColor.privateGrey,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          //controller: _codeController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              cubit.changeCodeTextByAdding(value);
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.white),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.white),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
