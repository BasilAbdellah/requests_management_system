import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Login/Data/EmployeeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio = Dio();
  AuthService() {
    dio.options.baseUrl = "http://192.168.1.108:8080/api/";
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  Future<LoginResponse> login(
      {required int employeeId, required String password}) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final response = await dio.post(
        "Employee/Login",
        data: {
          "employeeId": employeeId,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        var result = LoginResponse.fromJson(response.data);
        await prefs.setInt('employeeId', result.employeeDto?.employeeId ?? 0);
        return result;
      } else {
        throw Exception("Unexpected error occurred: ${response.statusCode}");
      }
    } on DioError catch (e) {
      throw Exception(
          "Login failed: ${e.response?.data['message'] ?? e.message}");
    }
  }
}
