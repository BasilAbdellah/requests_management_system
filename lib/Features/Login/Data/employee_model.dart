import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';

class EmployeeModel {
  final int employeeId;
  final String employeeName;
  final String departmentName;
  final int casualLeaveCount;
  final String dateOfEmployment;
  final String managerName;
  final int regularLeaveCount;

  EmployeeModel({
    required this.employeeId,
    required this.employeeName,
    required this.departmentName,
    required this.managerName,
    required this.casualLeaveCount,
    required this.regularLeaveCount,
    required this.dateOfEmployment,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeId : _parseInt(json[ApiKey.employeeId]),
      employeeName: json[ApiKey.employeeName],
      departmentName: json['departmentName'],
      managerName: json['managerName'],
      casualLeaveCount: _parseInt(json['casualLeaveCount']),
      regularLeaveCount: _parseInt(json['regularLeaveCount']),
      dateOfEmployment: json['dateOfEmployment'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'departmentName': departmentName,
      'casualLeaveCount': casualLeaveCount,
      'dateOfEmployment': dateOfEmployment,
      'managerName': managerName,
      'regularLeaveCount': regularLeaveCount,
    };
  }

  // Helper function to handle both String and int data types
  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return value is int ? value : 0;
  }
}
