import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/Utils/customs/dialogs.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/Login/Data/employee_model.dart';
import 'package:requests_management_system/Features/Login/Presentation/Pages/login_page.dart';
import 'package:requests_management_system/Features/Profile/Controller/profile_service.dart';

class ProfileProvider extends ChangeNotifier {
  static EmployeeModel employeeModel = EmployeeModel(
    employeeId: 0,
    employeeName: "احمد محمد احمد",
    departmentName: "السويدي",
    managerName: "محمود محمد",
    casualLeaveCount: 0,
    regularLeaveCount: 0,
    dateOfEmployment: "1-1-2000",
  );
  EmployeeModel? employeeData;
  Future<void> fetchProfile(BuildContext context) async {
    try {
      employeeData = await ProfileService().getProfile();
      employeeModel = employeeData!;
      notifyListeners();
    } on ServerException catch (e) {
      if (e.errModel.status == 401) {
        sshowDialog(context, "خطا", e.errModel.errorMessage, Colors.red,
            function: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginPage.routeName, (route) => false);
        });
      } else {
        sshowDialog(context, "خطا", e.errModel.errorMessage, Colors.red,
            function: () => fetchProfile(context));
      }
    }
  }
}
