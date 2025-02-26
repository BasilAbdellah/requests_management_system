import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_management_system/Core/Utils/customs/dialogs.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/Login/Presentation/Pages/login_page.dart';
import 'package:requests_management_system/Features/Login/Presentation/Widgets/CustomButton.dart';
import 'package:requests_management_system/Features/Profile/Presentation/Provider/profile_provider.dart';
import 'package:requests_management_system/Features/Update_Password/Presentation/Pages/update_password_page.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Pages/GetAllTransactionsByEmployeeIdScreen.dart';
import 'package:requests_management_system/Features/ViewTransactions/Presentation/Pages/GetStaffTransactionPage.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = "/Profile";

  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context);
    var data = profileProvider.employeeData ?? ProfileProvider.employeeModel;
    if (profileProvider.employeeData == null) {
      profileProvider.fetchProfile(context);
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xff313131), // top half (dark grey)
              Colors.grey[200]!, // bottom half (light grey)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 0.5],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 40,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textDirection: TextDirection.rtl,
                          "مرحباً, ${data.employeeName}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          "${data.departmentName}",
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),

                // Stats Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                        "${data.regularLeaveCount}", "الإجازات (الاعتيادية)"),
                    _buildStatCard(
                        "${data.casualLeaveCount}", "الإجازات (العارضة)"),
                  ],
                ),
                const SizedBox(height: 50),

                // Cards Section
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildFeatureCard(
                        context,
                        icon: Icons.lock,
                        title: "تحديث كلمة المرور",
                        subtitle: "تحديث طلبات",
                        onTap: () {
                          Navigator.pushNamed(
                              context, UpdatePasswordPage.routeName);
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        icon: Icons.create,
                        title: "إنشاء طلب",
                        subtitle: "ملئ استمارة الطلب",
                        onTap: () {
                          // Navigate to Create Request Page
                        },
                      ),
                      _buildFeatureCard(
                        context,
                        icon: Icons.history,
                        title: "الطلبات السابقة",
                        subtitle: "الاطلاع على سجل الطلبات",
                        onTap: () {
                          // Navigate to Previous Requests Page
                          Navigator.pushNamed(context,
                              GetAllTransactionsByEmployeeIdScreen.routeName);
                        },
                      ),
                      Visibility(
                        visible: _checkIfManger(),
                        child: _buildFeatureCard(
                          context,
                          icon: Icons.history,
                          title: "طلبات الموظفين",
                          subtitle: "الاطلاع على طلبات طاقم العمل",
                          onTap: () {
                            // Navigate to Previous Requests Page
                            Navigator.pushNamed(
                                context, GetStaffTransactionsScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Footer Section
                SizedBox(
                  width: 175,
                  child: Custombutton(
                    txt: "تسجيل الخروج",
                    onLogin: () async {
                      // remove tokens
                      await AuthServiceJWT.deleteToken(ApiKey.tokenKey);
                      await AuthServiceJWT.deleteToken(ApiKey.refreshTokenKey);
                      // remove employee data
                      CacheHelper.removeData(key: ApiKey.employeeId);
                      CacheHelper.removeData(key: ApiKey.employeeName);
                      CacheHelper.removeData(key: ApiKey.employeeRole);

                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.routeName, (route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _checkIfManger() {
    String role = CacheHelper.getData(key: ApiKey.employeeRole) ?? "Employee";
    if (role == "Manager") {
      return true;
    }
    return false;
  }
}
