import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Features/Login/Presentation/Widgets/CustomButton.dart';
import 'package:requests_management_system/Features/Login/Presentation/Widgets/customTextFormField.dart';
import 'package:requests_management_system/Features/Update_Password/Presentation/Provider/password_update_provider.dart';

class UpdatePasswordPage extends StatelessWidget {
  static const String routeName = "/UpdatePasswordPage";

  final GlobalKey<FormState> myKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordProvider =
        Provider.of<PasswordUpdateProvider>(context, listen: false);
  // Extract arguments passed to the UpdatePasswordPage from profile
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    final token = arguments?['token'];
    final employeeId = arguments?['employeeId'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/backgroundImage.png",
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: myKey,
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "تحديث كلمة المرور",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      color: const Color(0xFFEA5455),
                      width: 150,
                      height: 4,
                    ),
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      ctr: oldPasswordController,
                      txt: "كلمة المرور القديمة",
                      validator: (value) {
                        return value!.trim().isEmpty
                            ? "كلمة المرور القديمة مطلوبة"
                            : null;
                      },
                    ),
                    CustomTextFormField(
                      ctr: newPasswordController,
                      txt: "كلمة المرور الجديدة",
                      secureText: true,
                      validator: (value) => passwordProvider.validatePassword(
                        value,
                        "كلمة المرور الجديدة",
                      ),
                    ),
                    CustomTextFormField(
                      ctr: confirmPasswordController,
                      txt: "تأكيد كلمة المرور الجديدة",
                      secureText: true,
                      validator: (value) {
                        if (value != newPasswordController.text) {
                          return "كلمات المرور غير متطابقة";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    passwordProvider.isLoading
                        ? const CircularProgressIndicator()
                        : Custombutton(
                            txt: "تحديث",
                            onLogin: () async {
                              if (myKey.currentState!.validate()) {
                                final success =
                                    await passwordProvider.updatePassword(
                                      employeeId: employeeId as int,
                                      token: token as String,
                                  oldPassword: oldPasswordController.text,
                                  newPassword: newPasswordController.text,
                                );

                                if (success) {
                                  passwordProvider.showCustomDialog(
                                    context,
                                    "تم بنجاح",
                                    "تم تحديث كلمة المرور بنجاح.",
                                    Colors.green,
                                  );
                                } else {
                                  passwordProvider.showCustomDialog(
                                    context,
                                    "خطأ",
                                    passwordProvider.errorMessage ??
                                        "حدث خطأ غير معروف",
                                    Colors.red,
                                  );
                                }
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
