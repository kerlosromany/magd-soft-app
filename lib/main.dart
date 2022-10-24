import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'business_logic/bloc_observer.dart';
import 'business_logic/global_cubit/global_cubit.dart';
import 'business_logic/login_cubit/login_cubit.dart';
import 'data/data_providers/local/cache_helper.dart';
import 'data/data_providers/remote/dio_helper.dart';
import 'data/network/responses/help_response.dart';
import 'data/network/responses/login_response.dart';
import 'data/network/responses/products_response.dart';
import 'data/network/responses/verify_response.dart';
import 'presentation/router/app_router.dart';
import 'presentation/screens/shared/home_screen.dart';
import 'presentation/widget/toast.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import 'data/network/requests/products_request.dart';

late LocalizationDelegate delegate;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CacheHelper.init();

      final locale =
          CacheHelper.getDataFromSharedPreference(key: 'language') ?? "en";
      

      int? id = CacheHelper.getDataFromSharedPreference(key: 'id');
      bool? isSplash = CacheHelper.getDataFromSharedPreference(key: 'isSplash');
      late String initialRoute;
      if (isSplash == true) {
        if (id != null) {
          initialRoute = AppRouterConstants.homeRoute;
        } else {
          initialRoute = AppRouterConstants.loginRoute;
        }
      } else {
        initialRoute = AppRouterConstants.splashRoute;
      }

      delegate = await LocalizationDelegate.create(
        fallbackLocale: locale,
        supportedLocales: ['ar', 'en'],
      );
      await delegate.changeLocale(Locale(locale));
      runApp(MyApp(
        appRouter: AppRouter(),
        initialRoute: initialRoute,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter appRouter;
  final String initialRoute;

  const MyApp({
    required this.appRouter,
    required this.initialRoute,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = delegate.currentLocale.languageCode;

    delegate.onLocaleChanged = (Locale value) async {
      try {
        setState(() {
          Intl.defaultLocale = value.languageCode;
        });
      } catch (e) {
        print(e.toString());
        //showToast(e.toString());
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) =>
              GlobalCubit(ProductsResponse(), HelpResponse())),
        ),
        BlocProvider(
          create: ((context) => LoginCubit(LoginResponse(), VerifyResponse())),
        ),
      ],
      child: BlocConsumer<GlobalCubit, GlobalState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Sizer(
            builder: (context, orientation, deviceType) {
              return LocalizedApp(
                delegate,
                LayoutBuilder(builder: (context, constraints) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Werash',
                    localizationsDelegates: [
                      GlobalCupertinoLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      delegate,
                    ],
                    locale: delegate.currentLocale,
                    supportedLocales: delegate.supportedLocales,
                    onGenerateRoute: widget.appRouter.onGenerateRoute,
                    initialRoute: widget.initialRoute,
                    theme: ThemeData(
                      fontFamily: 'cairo',
                      //scaffoldBackgroundColor: AppColors.white,
                      appBarTheme: const AppBarTheme(
                        elevation: 0.0,
                        systemOverlayStyle: SystemUiOverlayStyle(
                          //statusBarColor: AppColors.transparent,
                          statusBarIconBrightness: Brightness.dark,
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          );
        },
      ),
    );
  }
}
