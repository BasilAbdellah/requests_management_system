import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Login/Data/EmployeeModel.dart';

class AuthService {
  final Dio dio = Dio();

  AuthService() {
    dio.options.baseUrl = "http://197.53.144.62:8080/api/";
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  Future<LoginResponse> login(
      {required int employeeId, required String password}) async {
    try {
      final response = await dio.post(
        "Employee/Login",
        data: {
          "employeeId": employeeId,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception("Unexpected error occurred: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
          "Login failed: ${e.response?.data['message'] ?? e.message}");
    }
  }
}
