import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/Login/Presentation/Provider/auth_provider.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Provider/profile_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/cancel_transaction_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/resent_transaction_provider.dart';
import 'package:requests_management_system/Features/TransactionDetails/Presentation/Provider/transaction_details_provider.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Provider/transaction_provider.dart';
import 'package:requests_management_system/Features/Update_Password/Presentation/Provider/password_update_provider.dart';
import 'package:requests_management_system/my_app.dart';

void main() async {
  await CacheHelper().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PasswordUpdateProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TransactionDetailsProvider(),
    ),
    ChangeNotifierProvider(create: (context) => CancelTransactionProvider(),),
    ChangeNotifierProvider(create: (context) => ResendTransactionProvider(),)
  ], child: const MyApp()));
}
