import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/Login/Data/login_resoponce_model.dart'; // Import AuthServiceJWT class

class AuthService {
  final ApiConsumer apiConsumer = Instances.dioConsumerInstance;

  /// Login API: Send employee credentials and return response
  Future<dynamic> login({
    required int employeeId,
    required String password,
  }) async {
    try {
      final response = await apiConsumer.post(
        Endpoints.login,
        data: {
          "employeeId": employeeId,
          "password": password,
        },
      );

      var result = LoginResponse.fromJson(response);

      if (result.status) {
        // Save token securely (15 minsts)
        await AuthServiceJWT.saveToken(ApiKey.tokenKey, response['token']);
        // Save refresh token securely (15 dayes)
        await AuthServiceJWT.saveToken(
          ApiKey.refreshTokenKey,
          response['refreshToken'],
        );

        final decodedToken = JwtDecoder.decode(response['token']);

        await CacheHelper.saveData(
            key: ApiKey.employeeId, value: decodedToken['EmployeeId']);
        await CacheHelper.saveData(
            key: ApiKey.employeeName, value: decodedToken['EmployeeName']);
        await CacheHelper.saveData(
            key: ApiKey.employeeRole, value: decodedToken['EmployeeRole']);
      }

      return result;
    } on ServerException catch (e) {
      return LoginResponse(status: false, message: e.errModel.errorMessage);
    }
  }
}
