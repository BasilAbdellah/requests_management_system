import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Profile/Data/ProfileModel.dart';

class ProfileService {
  final Dio dio;
  final String token;

  ProfileService({required this.token}) : dio = Dio() {
    // Set default base URL and headers for Dio
    dio.options.baseUrl = "http://192.168.1.108:8080/api/";
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<ProfileModel> getProfile(int employeeId) async {
    try {
      // Use the employeeId dynamically in the API endpoint
      final response = await dio.get("Employee/Profile/$employeeId");

      // Check if the response is successful
      if (response.statusCode == 200) {
        print("API Response: ${response.data}");

        // Parse the JSON into ProfileModel
        return ProfileModel.fromJson(response.data);
      } else {
        throw Exception("Unexpected error occurred: ${response.statusCode}");
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      throw Exception(
        "Request failed: ${e.response?.data['message']?.toString() ?? e.message}",
      );
    } catch (e) {
      // Handle other exceptions
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
