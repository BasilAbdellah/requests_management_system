import 'package:requests_management_system/Core/api/base_responce.dart';

class EmployeeDto {
  final int employeeId;
  final String employeeName;
  final String departmentName;

  EmployeeDto({
    required this.employeeId,
    required this.employeeName,
    required this.departmentName,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      departmentName: json['departmentName'],
    );
  }
}

class LoginResponse extends BaseResponce {
  final EmployeeDto? employeeDto;

  LoginResponse({
    required super.status,
    required super.message,
    this.employeeDto,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      status: json['status'],
      employeeDto: json['employeeDto'] != null
          ? EmployeeDto.fromJson(json['employeeDto'])
          : null,
    );
  }
}
