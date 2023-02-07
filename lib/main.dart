import 'package:currency_app/view/splash/splash_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '/view/resourse/theme_manager.dart';
import 'package:sizer/sizer.dart';

import 'controller/provider/auth_provider.dart';
import 'controller/provider/chat_provider.dart';
import 'controller/provider/currency_provider.dart';
import 'controller/provider/office_provider.dart';
import 'controller/provider/process_provider.dart';
import 'controller/provider/profile_provider.dart';
import 'controller/utils/create_environment_provider.dart';
import 'firebase_options.dart';
import 'translations/codegen_loader.g.dart';
Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  GetStorage.init();

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();

  print(_locationData.latitude);
  print(_locationData.longitude);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [
        Locale("en"),
        Locale("ar"),
      ],
      fallbackLocale: Locale("en"),
      assetLoader: CodegenLoader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(providers: [
      // Provider<HomeProvider>(create: (_)=>HomeProvider()),
      ListenableProvider<AuthProvider>(create: (_) => AuthProvider()),
      ListenableProvider<ProfileProvider>(create: (_)=>ProfileProvider()),
      ListenableProvider<ProcessProvider>(create: (_)=>ProcessProvider()),
      ListenableProvider<ChatProvider>(create: (_)=>ChatProvider()),
      ListenableProvider<CreateEnvironmentProvider>(create: (_)=>CreateEnvironmentProvider()),
      ListenableProvider<OfficeProvider>(create: (_)=>OfficeProvider()),
      ListenableProvider<CurrencyProvider>(create: (_)=>CurrencyProvider()),
    ],
        child: Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
              title: "Currency",
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              // locale: Get.deviceLocale,
              debugShowCheckedModeBanner: false,
               // theme: ThemeData.dark(),
             theme: ThemeManager.myTheme,
              // theme: getApplicationTheme(isDark: appProvider.darkTheme),
              home:SplashView()
          );
        }
    ));
  }
}

//          FocusManager.instance.primaryFocus!.unfocus();
