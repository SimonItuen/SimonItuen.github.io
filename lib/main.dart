import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaksine_web/pages/login/LoginPage.dart';
import 'package:vaksine_web/pages/parent/ParentPage.dart';
import 'package:vaksine_web/pages/start_up/StartUpPage.dart';
import 'package:vaksine_web/providers/app_provider.dart';
import 'package:vaksine_web/util/colors_util.dart';
import 'package:vaksine_web/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(),),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaksine',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: Provider.of<AppProvider>(context).appLocale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Poppins',
        accentColor: Color(0XFF50FFB1),
        primarySwatch: ColorsUtil.primaryColor,
      ),
      routes: {
        '/': (_) => StartUpPage(),
        LoginPage.routeName: (_) => LoginPage(),
        ParentPage.routeName: (_) => ParentPage()
      },
    );
  }
}
