import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/Utils/Theme/my_app_theme.dart';
import 'package:requests_management_system/Features/Login/Presentation/Pages/login_page.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Pages/Profile_screen.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Pages/GetStaffTransactionPage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyAppTheme.myLightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.routeName: (_) => LoginPage(),
        ProfilePage.routeName: (_) => ProfilePage(),
      },
      home: GetStaffTransactionsScreen(),
      locale: const Locale('ar', ''),
    );
  }
}
