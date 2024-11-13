import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/Utils/Theme/my_app_theme.dart';
import 'package:requests_management_system/Features/Login/Presentaion/Pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyAppTheme.myLightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.routeName:(_)=>LoginPage(),
      },
      initialRoute: LoginPage.routeName,
    );
  }
}

