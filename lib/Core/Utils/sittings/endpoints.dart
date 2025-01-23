import 'package:requests_management_system/Core/api/dio_consumer.dart';

class Endpoints {
  static const String baseUrl = 'http://41.239.5.3:8080/api';

  static const String login = "Employee/Login";
}

class ApiKey {
  static const tokenKey = 'auth_token';
  static const refreshTokenKey = 'refresh_token';

  static const employeeId = 'employeeId';
  static const employeeName = 'EmployeeName';
  static const employeeRole = 'EmployeeRole';
}

class Instance {
  static DioConsumer dioConsumerInstance = DioConsumer();
}
