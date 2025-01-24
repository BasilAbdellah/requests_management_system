import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/api/base_response.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';

class UpdatePasswordService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;
  Future<BaseResponse> updatePassword(
      {required int employeeId,
      required String oldPass,
      required String password,
      required String confirmPassword}) async {
    try {
      final response = await _apiConsumer.post(
        "Employee/UpdatePassword",
        data: {
          "employeeId": employeeId,
          "oldPassword": oldPass,
          "password": password,
          "confirmPassword": confirmPassword
        },
      );

      return BaseResponse.fromJson(response);
    } on ServerException catch (e) {
      return BaseResponse(
          status: false,
          message: e.errModel.status == 401
              ? e.errModel.errorMessage
              : "خطأ غير متوقع: ${e.errModel.errorMessage}");
    }
  }
}
