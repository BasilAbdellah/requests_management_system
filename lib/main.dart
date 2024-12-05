import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Login/Presentation/Provider/AuthProvider.dart';
import 'package:requests_management_system/my_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider(),)
    ],
    child: const MyApp()));
}
