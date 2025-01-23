import 'package:dio/dio.dart';
import 'package:requests_management_system/Core/api/base_responce.dart';

class UpdatePasswordService {
  final Dio dio = Dio();
  final String token;

  UpdatePasswordService({required this.token}) {
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
        return BaseResponce(status: false, message:  "يرجى إعادة تسجيل الدخول");
      } else {
        return BaseResponce(status: false, message:  "خطأ غير متوقع: ${e.message}");
      }
    } catch (e) {
      return BaseResponce(status:  false,message:  '$e');
    }
  }
}
