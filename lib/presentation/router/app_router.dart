import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/global_cubit/global_cubit.dart';
import '../../data/models/products_model.dart';
import '../../data/network/responses/help_response.dart';
import '../../data/network/responses/login_response.dart';
import '../../data/network/responses/products_response.dart';
import '../screens/shared/details_screen.dart';
import '../screens/shared/home_screen.dart';
import '../screens/shared/verify_phone_screen.dart';

import '../screens/shared/help_screen.dart';
import '../screens/shared/login_screen.dart';
import '../screens/shared/splash_screen.dart';

class AppRouterConstants {
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String verifyPhoneRoute = '/verifyPhone';
  static const String helpRoute = '/help';
  static const String detailsScreenRoute = '/details_screen';
  static const String homeRoute = '/';
}

class AppRouter {
  //late ProductsResponse productsResponse;
  late GlobalCubit globalCubit;

  AppRouter() {
    globalCubit = GlobalCubit(ProductsResponse(), HelpResponse());
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRouterConstants.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRouterConstants.verifyPhoneRoute:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerifyPhoneScreen(phoneNumber: phoneNumber ));
      case AppRouterConstants.helpRoute:
        return MaterialPageRoute(
          builder: (_) => const HelpScreen(),
        );
      case AppRouterConstants.detailsScreenRoute:
        final product = settings.arguments as Products;
        return MaterialPageRoute(
            builder: (_) => DetailsScreen(product: product));
      case AppRouterConstants.homeRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => globalCubit,
            child: HomeScreen(),
          ),
        );
      default:
        return AppRouter.unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("No Page found")),
        body: const Center(child: Text("No Page found")),
      ),
    );
  }
}
