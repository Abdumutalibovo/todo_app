import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/main_page.dart';
import 'package:todo_app/screens/splash_page.dart';
import 'package:todo_app/service/storage_service.dart';
import 'package:todo_app/theme_provider.dart';
import 'package:todo_app/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  StorageService.getInstance();
  await ScreenUtil.ensureScreenSize();
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('uz', 'UZ'),
        Locale('ru', 'RU'),
      ],
      path: 'assets/translations',
      child: MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => ThemeProvider())],
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: context.watch<ThemeProvider>().getIsLight()
              ? ThemeMode.dark
              : ThemeMode.light,
          theme: MyStyles.themeData(
              !context.watch<ThemeProvider>().getIsLight(), context),
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: SplashPage(),
    );
  }
}
