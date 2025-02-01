import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/Utils/customs/dialogs.dart';
import 'package:requests_management_system/Features/Login/Contraller/auth_service.dart';
import 'package:requests_management_system/Features/Login/Data/login_resoponce_model.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Pages/Profile_screen.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(
      BuildContext context, int employeeId, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Perform login
      LoginResponse loginResponse = await _authService.login(
        employeeId: employeeId,
        password: password,
      );

      if (loginResponse.status) {
        // Login was successful
        sshowDialog(
          context,
          "تم تسجيل الدخول بنجاح",
          loginResponse.message,
          Colors.green,
        );
        // Navigate to ProfilePage with token and employeeId
        Navigator.pushNamed(
          context,
          ProfilePage.routeName,
        );
      } else {
        // Show error dialog
        sshowDialog(
          context,
          "خطأ",
          loginResponse.message,
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

  String? passwordValidation(txt) {
    if (txt == null || txt.trim().isEmpty) {
      return "كلمة المرور مطلوبة";
    }
    return null;
  }
}
