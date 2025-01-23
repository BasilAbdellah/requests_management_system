import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:requests_management_system/Core/Utils/sittings/endpoints.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/Login/Data/EmployeeModel.dart'; // Import AuthServiceJWT class

class AuthService {
  final ApiConsumer apiConsumer = Instance.dioConsumerInstance;

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

      var result = LoginResponse.fromJson(response.data);

      // Save token securely (15 minsts)
      await AuthServiceJWT.saveToken(ApiKey.tokenKey, response.data['token']);
      // Save refresh token securely (15 dayes)
      await AuthServiceJWT.saveToken(
        ApiKey.refreshTokenKey,
        response.data['refreshToken'],
      );

      final decodedToken = JwtDecoder.decode(response.data['token']);

      await CacheHelper.saveData(
          key: ApiKey.employeeId, value: decodedToken[ApiKey.employeeId]);
      await CacheHelper.saveData(
          key: ApiKey.employeeName, value: decodedToken[ApiKey.employeeName]);
      await CacheHelper.saveData(
          key: ApiKey.employeeRole, value: decodedToken[ApiKey.employeeRole]);

      return result;
    } on ServerException catch (e) {
      return LoginResponse(status: false, message: e.errModel.errorMessage);
    }
  }
}
