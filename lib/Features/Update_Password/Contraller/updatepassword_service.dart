import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Login/Data/base_responce.dart';

class UpdatePasswordService {
  final Dio dio = Dio();

  UpdatePasswordService() {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTW9zdGFmYSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMiIsImV4cCI6MTczMzUwOTQ1OCwiaXNzIjoiU2Nob29sQXBwIiwiYXVkIjoiU2Nob29sQ2xpZW50In0.HTYZXfQQa1w_fdmoY4GmuDV9bvp-pHnF88gcdoxkjSM';
    dio.options.baseUrl = "http://192.168.1.108:8080/api/";
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<BaseResponce> updatePassword(
      {required int employeeId,
      required String oldPass,
      required String password,
      required String confirmPassword}) async {
    try {
      final response = await dio.post(
        "Employee/UpdatePassword",
        data: {
          "employeeId": employeeId,
          "oldPassword": oldPass,
          "password": password,
          "confirmPassword": confirmPassword
        },
      );

      if (response.statusCode == 200) {
        return BaseResponce.fromJson(response.data);
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return BaseResponce(false, "يرجى إعادة تسجيل الدخول");
      } else {
        return BaseResponce(false, "خطأ غير متوقع: ${e.message}");
      }
    } catch (e) {
      return BaseResponce(false, '$e');
    }
  }
}
