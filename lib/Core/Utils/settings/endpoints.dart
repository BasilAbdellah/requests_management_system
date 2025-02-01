class Endpoints {
  static const String baseUrl =
      'http://requests-management-system.runasp.net/api/';

  static const String login = "Employee/Login";

  static const String getEmployeeTransactions =
      "Transaction/GetAllTransactionsByEmployeeId/";

  static const String getStaffTransactions =
      "Transaction/GetStaffTransactions/";

  static const String sendRequestTransaction = "Transaction/PostTransaction";

  static const String getSubstituteEmployee =
      "Employee/GetEmployeesByDepartmentName/";
}

class ApiKey {
  static const tokenKey = 'auth_token';
  static const refreshTokenKey = 'refresh_token';

  static const employeeId = 'employeeId';
  static const employeeName = 'employeeName';
  static const employeeRole = 'employeeRole';
}
