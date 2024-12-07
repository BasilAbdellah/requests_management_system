import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Login/Contraller/login_service_jwt.dart';
import 'package:requests_management_system/Features/Login/Data/EmployeeModel.dart'; // Import AuthServiceJWT class

class AuthService {
  final Dio dio = Dio();
  AuthService() {
    dio.options.baseUrl = "http://192.168.1.108:8080/api/";
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  /// Login API: Send employee credentials and return response
  Future<dynamic> login(
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
        // Save JWT using AuthServiceJWT
        final token =
            response.data['token']; // Adjust based on your API response key
        await AuthServiceJWT.saveToken(token); // Save token securely
        return LoginResponse.fromJson(response
            .data); // Return response data (optional, can adjust as needed)
      } else {
        throw Exception("Unexpected error occurred: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception(
          "Login failed: ${e.response?.data['message'] ?? e.message}");
    }
  }
}
