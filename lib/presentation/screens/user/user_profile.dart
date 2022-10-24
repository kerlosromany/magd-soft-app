import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/login_cubit/login_cubit.dart';
import '../../../business_logic/login_cubit/login_state.dart';
import '../../../data/models/verify_model.dart';
import '../../styles/styles.dart';

import '../../../data/models/account_model.dart';
import '../../styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final verifiedModel =
            BlocProvider.of<LoginCubit>(context).verifiedModel;
        return Container(
          height: double.infinity,
          decoration: getBoxDecorationStyle(),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ListTile(
              title: Text(
                "${verifiedModel?.account?.name}",
                style: getBoldStyle(fontSize: 16, color: AppColor.privateBlack),
              ),
              subtitle: Text(
                "${verifiedModel?.account?.phone}",
                style: getSemiBoldStyle(
                    fontSize: 14, color: AppColor.privateBlack),
              ),
              leading: const Icon(Icons.person),
            ),
          ),
        );
      },
    );
  }
}
