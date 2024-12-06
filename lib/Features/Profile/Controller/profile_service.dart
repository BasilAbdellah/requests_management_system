import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Profile/Data/ProfileModel.dart';

class ProfileService {
  static Dio dio = Dio();

  static Future<ProfileModel> getProfile() async {
    try {
      // Make the GET request
      final response = await dio.get(
        "http://197.53.144.62:8080/api/Employee/Profile1",
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiTW9zdGFmYSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMiIsImV4cCI6MTczMzUwOTQ1OCwiaXNzIjoiU2Nob29sQXBwIiwiYXVkIjoiU2Nob29sQ2xpZW50In0.HTYZXfQQa1w_fdmoY4GmuDV9bvp-pHnF88gcdoxkjSM"}', // Send the JWT token in the Authorization header
          },
        ),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        print("API Response: ${response.data}");

        // Ensure the response is a Map
        if (response.data is Map<String, dynamic>) {
          // Parse the JSON into ProfileModel
          return ProfileModel.fromJson(response.data);
        } else {
          throw Exception("Unexpected response format: ${response.data}");
        }
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

// class ProfileService {
//   static Dio dio = Dio();
//
//   static Future<ProfileModel> getProfile() async {
//     try {
//       final response = await dio.get(
//         "http://197.53.144.62:8080/api/Employee/Profile2",
//       );
//       if (response.statusCode == 200) {
//         print(response.data);
//         return ProfileModel.fromJson(response.data);
//       } else {
//         throw Exception("Unexpected error occurred: ${response.statusCode}");
//       }
//     } on DioException catch (e) {
//       throw Exception(
//           "Login failed: ${e.response?.data['message'].toString() ?? e.message}");
//     }
//   }
// }
