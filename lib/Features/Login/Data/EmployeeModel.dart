class EmployeeDto {
  final int? employeeId;
  final String? employeeName;
  final String? departmentName;

  EmployeeDto({
    this.employeeId,
    this.employeeName,
    this.departmentName,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      departmentName: json['departmentName'],
    );
  }
}

class LoginResponse {
  final String message;
  final String token;
  final bool status;
  final EmployeeDto? employeeDto;

  LoginResponse({
    required this.message,
    required this.token,
    required this.status,
    this.employeeDto,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      status: json['status'],
      employeeDto: json['employeeDto'] != null
          ? EmployeeDto.fromJson(json['employeeDto'])
          : null,
    );
  }
}
