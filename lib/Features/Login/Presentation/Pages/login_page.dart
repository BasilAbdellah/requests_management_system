import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/Utils/customs/dialogs.dart';
import 'package:requests_management_system/Features/Login/Presentation/Provider/auth_provider.dart';
import 'package:requests_management_system/Features/Login/Presentation/Widgets/CustomButton.dart';
import 'package:requests_management_system/Features/Login/Presentation/Widgets/customTextFormField.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  static const String routeName = "/loginPage";
  final myKey = GlobalKey<FormState>(); // Made this final for consistency
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Center(
                      child: Text(
                        "تسجيل الدخول",
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
                      ctr: employeeIdController,
                      txt: "كود الموظف",
                      validator: (txt) {
                        if (txt == null || txt.trim().isEmpty) {
                          return "كود الموظف مطلوب";
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(txt)) {
                          return "كود الموظف يجب أن يحتوي على أرقام فقط";
                        }
                        return null;
                      },
                    ),
                    CustomTextFormField(
                      secureText: true,
                      ctr: passwordController,
                      txt: "كلمة المرور",
                      validator: authProvider.passwordValidation,
                    ),
                    const SizedBox(height: 30),
                    authProvider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Custombutton(
                            txt: "تسجيل الدخول",
                            onLogin: () {
                              if (!myKey.currentState!.validate()) {}
                              final employeeId =
                                  employeeIdController.text ;
                              final password = passwordController.text;

                              if (password.trim().isNotEmpty) {
                                authProvider.login(
                                    context, employeeId, password);
                              } else {
                                sshowDialog(
                                  context,
                                  "خطأ",
                                  "من فضلك أدخل بيانات صحيحة",
                                  Colors.red,
                                );
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
