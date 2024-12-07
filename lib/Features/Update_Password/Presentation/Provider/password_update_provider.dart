import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Update_Password/Contraller/updatepassword_service.dart';

class PasswordUpdateProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  late UpdatePasswordService _passwordService;

  String? validatePassword(String? password, String fieldName) {
    if (password == null || password.trim().isEmpty) {
      return "$fieldName مطلوبة";
    }
    if (password.length < 8) {
      return "$fieldName يجب أن تكون 8 أحرف على الأقل";
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "$fieldName يجب أن تحتوي على حرف كبير واحد على الأقل";
    }
    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "$fieldName يجب أن تحتوي على حرف صغير واحد على الأقل";
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return "$fieldName يجب أن تحتوي على رقم واحد على الأقل";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "$fieldName يجب أن تحتوي على رمز خاص واحد على الأقل";
    }
    return null;
  }

  Future<bool> updatePassword({
    required int employeeId,
    required String token,
    required String oldPassword,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    _passwordService = UpdatePasswordService(token: token);

    try {
      var result = await _passwordService.updatePassword(
          employeeId: employeeId,
          oldPass: oldPassword,
          password: newPassword,
          confirmPassword: newPassword);
      if (!result.status) {
        errorMessage = result.message;
        isLoading = false;
        notifyListeners();
        return false;
      }

      // Mock successful password update
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "حدث خطأ أثناء تحديث كلمة المرور";
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void showCustomDialog(
      BuildContext context, String title, String message, Color color) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          title,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(color: color),
        ),
        content: Text(
          message,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
        ),
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
