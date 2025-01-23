import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Login/Data/employee_model.dart';
import 'package:requests_management_system/Features/Profile/Controller/profile_service.dart';

class ProfileProvider extends ChangeNotifier {

  Future<EmployeeModel> fetchProfile() => ProfileService().getProfile();
}
