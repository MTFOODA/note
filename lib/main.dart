import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app/shared/sp.dart';
import 'package:note_app/utilities/theme_provider.dart';
import 'package:note_app/widgets/root.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  //removeUserData();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar'), Locale('fr'), Locale('de')],
      path: "assets/lang",
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
  ));
}

// void removeUserData() async {
//   await CacheHelper.removeData('email');
//   await CacheHelper.removeData('password');
//   print('Email and password removed successfully');
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const RootPage(),
          );
        },
      ),
    );
  }
}
