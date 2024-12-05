import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Login/Contraller/AuthService.dart';
import 'package:requests_management_system/Features/Login/Data/EmployeeModel.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Pages/Profile_screen.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LoginResponse? _loginResponse;

  Future<void> login(
      BuildContext context, int employeeId, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      _loginResponse = await _authService.login(
        employeeId: employeeId,
        password: password,
      );

      if (_loginResponse!.status) {
        sshowDialog(
          context,
          "تم تسجيل الدخول بنجاح",
          _loginResponse!.message,
          Colors.green,
        );
        print("تم تسجيل الدخول بنجاح!");
        Navigator.pushReplacementNamed(context, ProfilePage.routeName);
      } else {
        sshowDialog(
          context,
          "خطأ",
          _loginResponse!.message,
          Colors.red,
        );
      }
    } catch (e) {
      sshowDialog(
        context,
        "خطأ",
        e.toString(),
        Colors.red,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  void sshowDialog(
      BuildContext context, String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: color),
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("نعم"),
          ),
        ],
      ),
    );
  }
}
