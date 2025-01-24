class Endpoints {
  static const String baseUrl = 'http://192.168.1.104:8080/api/';

  static const String login = "Employee/Login";
}

class ApiKey {
  static const tokenKey = 'auth_token';
  static const refreshTokenKey = 'refresh_token';

  static const employeeId = 'employeeId';
  static const employeeName = 'employeeName';
  static const employeeRole = 'employeeRole';
}
