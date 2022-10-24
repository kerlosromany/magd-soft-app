import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/login_cubit/login_cubit.dart';
import '../../../business_logic/login_cubit/login_state.dart';
import '../../../data/data_providers/local/cache_helper.dart';
import '../../../data/network/responses/verify_response.dart';
import '../../router/app_router.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';

import '../../../data/network/responses/login_response.dart';
import '../../widget/login_with_social_card.dart';
import '../../widget/specific_button.dart';
import '../../widget/text_form_field.dart';
import '../../widget/toast.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(LoginResponse(), VerifyResponse()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state is LoadedUserDataState) {
            if (state.accountModel.message == "Account Created Successfully") {
              showToast(
                  "Account Created Successfully and Your Code is ${state.accountModel.code}",
                  context , 6);

              Navigator.pushReplacementNamed(
                context,
                AppRouterConstants.verifyPhoneRoute,
                arguments: phoneController.text,
              );
            } else if (state.accountModel.message == "Account Verified") {
              showToast("This Account is Verified", context , 2);

              Navigator.pushReplacementNamed(context, AppRouterConstants.homeRoute);
            }
          }
        },
        builder: (context, state) {
          var cubit = BlocProvider.of<LoginCubit>(context);
          return Builder(builder: (context) {
            double screenWidthSize = MediaQuery.of(context).size.width;
            double screenHeightSize = MediaQuery.of(context).size.height;
            return Scaffold(
              body: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/loginbackground.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeightSize / 2),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(60),
                                    topRight: Radius.circular(60),
                                  ),
                                  color: AppColor.white,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(width: screenWidthSize * 0.05),
                                        const Expanded(
                                          child: Divider(
                                            color: AppColor.privateBlue,
                                            height: 1,
                                          ),
                                        ),
                                        const Text("OR"),
                                        const Expanded(
                                          child: Divider(
                                            color: AppColor.privateBlue,
                                            height: 1,
                                          ),
                                        ),
                                        SizedBox(width: screenWidthSize * 0.05),
                                      ],
                                    ),
                                  ),
                                  /*Biuld row for Login with social media is here */
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        LoginWithSocialWidget(
                                            imagePath: 'assets/images/g.png',
                                            width: screenWidthSize / 8,
                                            height: screenHeightSize / 14),
                                        LoginWithSocialWidget(
                                            imagePath: 'assets/images/ios.png',
                                            width: screenWidthSize / 8,
                                            height: screenHeightSize / 14),
                                        LoginWithSocialWidget(
                                            imagePath: 'assets/images/f.png',
                                            width: screenWidthSize / 8,
                                            height: screenHeightSize / 14),
                                      ],
                                    ),
                                  ),
                                  /////////////////////////////////////////////////
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*Build Form For login is Here*/
                  buildForm(screenWidthSize, screenHeightSize, formKey,
                      nameController, phoneController, state, cubit),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  SizedBox buildForm(
      double screenWidthSize,
      double screenHeightSize,
      GlobalKey<FormState> formKey,
      TextEditingController nameController,
      TextEditingController phoneController,
      LoginState state,
      LoginCubit cubit) {
    return SizedBox(
      width: screenWidthSize * 0.8,
      height: screenHeightSize * 0.45,
      child: Card(
        elevation: 20,
        color: AppColor.white,
        shadowColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Welcome",
                style: getRegularStyle(fontSize: 30, color: AppColor.grey),
              ),
              Divider(
                color: AppColor.privateBlue,
                thickness: 2.5,
                endIndent: screenWidthSize / 4,
                indent: screenWidthSize / 4,
              ),
              /*Text form field code is called here */
              TextFormFieldWidget(
                controller: nameController,
                errorMessage: "Name must be not empty",
                hintTextMessage: "Enter your full name",
                textInputType: TextInputType.name,
              ),
              TextFormFieldWidget(
                controller: phoneController,
                errorMessage: "Phone must be not empty",
                hintTextMessage: "Enter your Phone Number",
                textInputType: TextInputType.phone,
              ),
              ////////////////////////////////////////
              /*Button Widget for login is called here*/
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ConditionalBuilder(
                  condition: state is! LoginLoadingState,
                  fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                  builder: (context) => SpecificButtonWidget(
                    txt: "Login",
                    width: double.infinity,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        cubit.getUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                  ),
                ),
              ),
              ////////////////////////////////////////
            ],
          ),
        ),
      ),
    );
  }
}
