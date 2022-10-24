import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/global_cubit/global_cubit.dart';
import '../../../data/models/help_model.dart';
import '../../router/app_router.dart';
import '../../styles/styles.dart';
import '../../widget/specific_button.dart';

import '../../styles/colors.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  List<Help> allHelps = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GlobalCubit>(context).getAllHelps();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        List<Help> allHelps = [];

        if (state is LoadedHelpsState) allHelps = state.helps;
        return Builder(builder: (context) {
          double screenHeightSize = MediaQuery.of(context).size.height;
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: getBoxDecorationStyle(),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenHeightSize / 82.5),
                child: Column(
                  children: [
                    SizedBox(height: screenHeightSize / 27.5),
                    Text(
                      "Help",
                      style: getLightStyle(fontSize: 25, color: AppColor.white),
                    ),
                    ConditionalBuilder(
                      condition: allHelps.isNotEmpty,
                      fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                              color: AppColor.privateBlack)),
                      builder: (context) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: allHelps.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shadowColor: AppColor.privateGrey,
                            elevation: 10,
                            color: AppColor.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ExpansionTile(
                              title: Text(
                                allHelps[index].question,
                                style: getMediumStyle(
                                    fontSize: 16, color: AppColor.privateBlue),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    allHelps[index].answer,
                                    textAlign: TextAlign.start,
                                    style: getMediumStyle(
                                        fontSize: 16,
                                        color: AppColor.privateGrey2),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 20);
                        },
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SpecificButtonWidget(
                        txt: "Continue",
                        width: double.infinity,
                        onTap: () {
                          Navigator.pushReplacementNamed(context, AppRouterConstants.homeRoute);
                        },
                      ),
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
}
