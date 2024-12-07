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
      // Perform login
      _loginResponse = await _authService.login(
        employeeId: employeeId,
        password: password,
      );

      if (_loginResponse!.status) {
        // Login was successful
        print("تم تسجيل الدخول بنجاح!");
        print("Token: ${_loginResponse!.token}");

        sshowDialog(
          context,
          "تم تسجيل الدخول بنجاح",
          _loginResponse!.message,
          Colors.green,
        );
        // Navigate to ProfilePage with token and employeeId
        Navigator.pushNamed(
          context,
          ProfilePage.routeName,
          arguments: {
            'token': _loginResponse!.token, // Pass the dynamic token
            'employeeId': employeeId, // Pass the logged-in employee ID
          },
        );
      } else {
        // Show error dialog
        sshowDialog(
          context,
          "خطأ",
          _loginResponse!.message,
          Colors.red,
        );
      }
    } catch (e) {
      // Handle exceptions and show an error dialog
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
