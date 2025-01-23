import 'package:requests_management_system/Core/api/base_response.dart';
import 'package:requests_management_system/Features/Login/Data/employee_model.dart';

class LoginResponse extends BaseResponse {
  final EmployeeModel? employeeModel;

  LoginResponse({
    required super.status,
    required super.message,
    this.employeeModel,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      status: json['status'],
      employeeModel: json['employeeModel'] != null
          ? EmployeeModel.fromJson(json['employeeModel'])
          : null,
    );
  }
}
