import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/Utils/Theme/my_app_theme.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/Login/Presentation/Pages/login_page.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Pages/Profile_screen.dart';
import 'package:requests_management_system/Features/Update_Password/Presentation/Pages/update_password_page.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Pages/GetAllTransactionsByEmployeeIdScreen.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Pages/GetStaffTransactionPage.dart';
import 'package:requests_management_system/Features/send_requests/page/screen_send_request.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyAppTheme.myLightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.routeName: (_) => LoginPage(),
        ProfilePage.routeName: (_) => const ProfilePage(),
        UpdatePasswordPage.routeName: (_) => UpdatePasswordPage(),
        GetStaffTransactionsScreen.routeName: (_) =>
            const GetStaffTransactionsScreen(),
        GetAllTransactionsByEmployeeIdScreen.routeName: (_) =>
            const GetAllTransactionsByEmployeeIdScreen(),
      },
      initialRoute: _initialRoute(),
      locale: const Locale('ar', ''),
    );
  }

  String _initialRoute() {
    if (CacheHelper.getData(key: ApiKey.employeeId) != null) {
      return ProfilePage.routeName;
    }
    return LoginPage.routeName;
  }
}
