## **Flutter Application Services and Models Documentation**

- [**Flutter Application Services and Models Documentation**](#flutter-application-services-and-models-documentation)
  - [**1. Models**](#1-models)
    - [**Employee Models**](#employee-models)
    - [**Transaction Models**](#transaction-models)
  - [**2. Services**](#2-services)
    - [**Employee Service**](#employee-service)
    - [**Transaction Service**](#transaction-service)
  - [**3. Error Handling**](#3-error-handling)
    - [**Error Handling Code**](#error-handling-code)
  - [**4. Auth and Token Handling**](#4-auth-and-token-handling)
    - [**Token Handling Code**](#token-handling-code)
  - [**Conclusion**](#conclusion)

### **1. Models**

Models represent the data structures used in your application. Each model corresponds to a specific API response or request.

#### **Employee Models**

```dart
class EmployeeDto {
  final int employeeId;
  final String? employeeCode;
  final String? employeeName;
  final String? departmentName;
  final String? casualLeaveCount;
  final String? regularLeaveCount;
  final DateOnly dateOfEmployment;
  final String? managerName;

  EmployeeDto({
    required this.employeeId,
    this.employeeCode,
    this.employeeName,
    this.departmentName,
    this.casualLeaveCount,
    this.regularLeaveCount,
    required this.dateOfEmployment,
    this.managerName,
  });

  factory EmployeeDto.fromJson(Map<String, dynamic> json) {
    return EmployeeDto(
      employeeId: json['employeeId'],
      employeeCode: json['employeeCode'],
      employeeName: json['employeeName'],
      departmentName: json['departmentName'],
      casualLeaveCount: json['casualLeaveCount'],
      regularLeaveCount: json['regularLeaveCount'],
      dateOfEmployment: DateOnly.fromJson(json['dateOfEmployment']),
      managerName: json['managerName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeCode': employeeCode,
      'employeeName': employeeName,
      'departmentName': departmentName,
      'casualLeaveCount': casualLeaveCount,
      'regularLeaveCount': regularLeaveCount,
      'dateOfEmployment': dateOfEmployment.toJson(),
      'managerName': managerName,
    };
  }
}

class LoginEmployeeDto {
  final String employeeCode;
  final String password;

  LoginEmployeeDto({
    required this.employeeCode,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeCode': employeeCode,
      'password': password,
    };
  }
}

class LoginResultDto {
  final bool status;
  final String? message;
  final String? token;
  final String? refreshToken;
  final EmployeeDto employeeDto;

  LoginResultDto({
    required this.status,
    this.message,
    this.token,
    this.refreshToken,
    required this.employeeDto,
  });

  factory LoginResultDto.fromJson(Map<String, dynamic> json) {
    return LoginResultDto(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      employeeDto: EmployeeDto.fromJson(json['employeeDto']),
    );
  }
}
```
```dart
class UpdatePasswordEmployeeDto {
  final int employeeId;
  final String? oldPassword;
  final String? password;
  final String? confirmPassword;

  UpdatePasswordEmployeeDto({
    required this.employeeId,
    this.oldPassword,
    this.password,
    this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'oldPassword': oldPassword,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}

class UpdatePasswordResultDto {
  final String? message;
  final bool status;
  final EmployeeDto employeeDto;

  UpdatePasswordResultDto({
    this.message,
    required this.status,
    required this.employeeDto,
  });

  factory UpdatePasswordResultDto.fromJson(Map<String, dynamic> json) {
    return UpdatePasswordResultDto(
      message: json['message'],
      status: json['status'],
      employeeDto: EmployeeDto.fromJson(json['employeeDto']),
    );
  }
}
```
#### **Transaction Models**

```dart
class CreateTransactionDto {
  final String title;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final int substituteEmployeeId;
  final List<String>? itinerary;
  final int? employeeId;

  CreateTransactionDto({
    required this.title,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.substituteEmployeeId,
    this.itinerary,
    this.employeeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'substituteEmployeeId': substituteEmployeeId,
      'itinerary': itinerary,
      'employeeId': employeeId,
    };
  }
}

class TransactionDto {
  final int transactionId;
  final String? title;
  final String? type;
  final String? startDate;
  final String? endDate;
  final List<String>? itinerary;
  final String? respondDate;
  final String? respondMessage;
  final String? status;
  final String? creationDate;
  final EmployeeIdAndNameDto employee;
  final EmployeeIdAndNameDto substituteEmployee;
  final String? takenDays;
  final String? seenStatus;

  TransactionDto({
    required this.transactionId,
    this.title,
    this.type,
    this.startDate,
    this.endDate,
    this.itinerary,
    this.respondDate,
    this.respondMessage,
    this.status,
    this.creationDate,
    required this.employee,
    required this.substituteEmployee,
    this.takenDays,
    this.seenStatus,
  });

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      transactionId: json['transactionId'],
      title: json['title'],
      type: json['type'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      itinerary: json['itinerary'] != null ? List<String>.from(json['itinerary']) : null,
      respondDate: json['respondDate'],
      respondMessage: json['respondMessage'],
      status: json['status'],
      creationDate: json['creationDate'],
      employee: EmployeeIdAndNameDto.fromJson(json['employee']),
      substituteEmployee: EmployeeIdAndNameDto.fromJson(json['substituteEmployee']),
      takenDays: json['takenDays'],
      seenStatus: json['seenStatus'],
    );
  }
}
```

```dart
class StaffTransactionDto {
  final int transactionId;
  final String? title;
  final String? type;
  final String? status;
  final String? dueDate;
  final String? takenDays;
  final String? sendDate;
  final String? employeeName;
  final bool seen;

  StaffTransactionDto({
    required this.transactionId,
    this.title,
    this.type,
    this.status,
    this.dueDate,
    this.takenDays,
    this.sendDate,
    this.employeeName,
    required this.seen,
  });

  factory StaffTransactionDto.fromJson(Map<String, dynamic> json) {
    return StaffTransactionDto(
      transactionId: json['transactionId'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
      dueDate: json['dueDate'],
      takenDays: json['takenDays'],
      sendDate: json['sendDate'],
      employeeName: json['employeeName'],
      seen: json['seen'],
    );
  }
}

class GetTransactionByEmployeeDto {
  final int transactionId;
  final String? title;
  final String? type;
  final String? status;
  final String? dueDate;
  final String? takenDays;
  final String? sendDate;

  GetTransactionByEmployeeDto({
    required this.transactionId,
    this.title,
    this.type,
    this.status,
    this.dueDate,
    this.takenDays,
    this.sendDate,
  });

  factory GetTransactionByEmployeeDto.fromJson(Map<String, dynamic> json) {
    return GetTransactionByEmployeeDto(
      transactionId: json['transactionId'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
      dueDate: json['dueDate'],
      takenDays: json['takenDays'],
      sendDate: json['sendDate'],
    );
  }
}

class UpdateTransactionDto {
  final String? title;
  final String? type;
  final DateTime startDate;
  final DateTime endDate;
  final int substituteEmployeeId;
  final List<String>? itinerary;

  UpdateTransactionDto({
    this.title,
    this.type,
    required this.startDate,
    required this.endDate,
    required this.substituteEmployeeId,
    this.itinerary,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type': type,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'substituteEmployeeId': substituteEmployeeId,
      'itinerary': itinerary,
    };
  }
}

class UpdateTransactionStatusDto {
  final String? status;
  final String? responseMessage;

  UpdateTransactionStatusDto({
    this.status,
    this.responseMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'responseMessage': responseMessage,
    };
  }
}
```

---

### **2. Services**

Services handle API requests and responses. Each service corresponds to a specific feature (e.g., Employee, Transaction).

#### **Employee Service**

```dart
class EmployeeService {
  final ApiConsumer apiConsumer;

  EmployeeService({required this.apiConsumer});

  Future<EmployeeDto> getEmployeeProfile(int id) async {
    try {
      final response = await apiConsumer.get('/api/Employee/Profile/$id');
      return EmployeeDto.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<LoginResultDto> login(LoginEmployeeDto loginEmployeeDto) async {
    try {
      final response = await apiConsumer.post(
        '/api/Employee/Login',
        data: loginEmployeeDto.toJson(),
      );
      return LoginResultDto.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  EmployeeService({required this.apiConsumer});

  Future<UpdatePasswordResultDto> updatePassword(UpdatePasswordEmployeeDto updatePasswordEmployeeDto) async {
    try {
      final response = await apiConsumer.post(
        '/api/Employee/UpdatePassword',
        data: updatePasswordEmployeeDto.toJson(),
      );
      return UpdatePasswordResultDto.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<String> getNewToken(String refreshToken) async {
    try {
      final response = await apiConsumer.get(
        '/api/Employee/NewToken',
        queryParameters: {'refreshToken': refreshToken},
      );
      return response as String;
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }
}
```

#### **Transaction Service**

```dart
class TransactionService {
  final ApiConsumer apiConsumer;

  TransactionService({required this.apiConsumer});

  Future<List<TransactionDto>> getStaffTransactions(int managerId) async {
    try {
      final response = await apiConsumer.get('/api/Transaction/GetStaffTransactions/$managerId');
      return (response as List).map((e) => TransactionDto.fromJson(e)).toList();
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<TransactionDto> getTransactionDetails(int transactionId) async {
    try {
      final response = await apiConsumer.get('/api/Transaction/GetTransactionDetails/$transactionId');
      return TransactionDto.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<void> markTransactionAsSeen(int id, String whoSeen) async {
    try {
      await apiConsumer.patch(
        '/api/Transaction/$id/seen',
        queryParameters: {'whoSeen': whoSeen},
      );
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<void> editTransaction(int transactionId, UpdateTransactionDto updateTransactionDto) async {
    try {
      await apiConsumer.put(
        '/api/Transaction/EditTransaction',
        queryParameters: {'transactionId': transactionId},
        data: updateTransactionDto.toJson(),
      );
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<void> cancelTransaction(int transactionId) async {
    try {
      await apiConsumer.delete('/api/Transaction/CancelTransaction/$transactionId');
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }

  Future<void> setTransactionStatus(int id, UpdateTransactionStatusDto updateTransactionStatusDto) async {
    try {
      await apiConsumer.put(
        '/api/Transaction/SetStatus/$id',
        data: updateTransactionStatusDto.toJson(),
      );
    } on ServerException catch (e) {
      throw ServerException(errModel: e.errModel);
    }
  }
}
```

---

### **3. Error Handling**

Error handling is done using `ServerException` and `ErrorModel`. The `handleDioExceptions` method processes Dio errors and throws `ServerException`.

#### **Error Handling Code**

```dart
class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errModel: ErrorModel(
              status: 408,
              errorMessage: "Connection timeout. Please check your network."));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
        case 401:
          handleRefreshToken();
          break;
        case 404:
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
      }
    default:
      throw ServerException(
          errModel: ErrorModel(status: 500, errorMessage: "Unknown error."));
  }
}

```

---

### **4. Auth and Token Handling**

Token handling is managed using `ApiInterceptor` and `AuthServiceJWT`. Tokens are refreshed automatically when expired.

#### **Token Handling Code**

```dart
class ApiInterceptor extends Interceptor {
  final Dio dio;

  ApiInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await AuthServiceJWT.getToken(ApiKey.tokenKey);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return handler.reject(err);
  }

  Future<String> _refreshToken() async {
    String? refreshToken = await AuthServiceJWT.getToken(ApiKey.refreshTokenKey);
    if (refreshToken == null) {
      throw Exception('Refresh token not found');
    }

    final response = await dio.post(
      '/api/Employee/NewToken',
      data: {'refreshToken': refreshToken},
    );

    final newAccessToken = response.data['token'];
    if (newAccessToken == null) {
      throw Exception('Failed to refresh token');
    }

    await AuthServiceJWT.saveToken(ApiKey.tokenKey, newAccessToken);
    return newAccessToken;
  }
}
```

---

### **Conclusion**

This guide provides a complete reference for your Flutter application's services, models, error handling, and token management. You can now easily integrate these components into your app. Let me know if you need further assistance! 🚀
