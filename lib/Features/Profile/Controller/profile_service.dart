import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/Login/Data/employee_model.dart';

class ProfileService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;

  Future<EmployeeModel> getProfile() async {
    try {
      var employeeId = await CacheHelper.getData(key: ApiKey.employeeId);
      // Use the employeeId dynamically in the API endpoint
      final response = await _apiConsumer.get("Employee/Profile/$employeeId");
      // Check if the response is successful
      return EmployeeModel.fromJson(response);
    } on ServerException {
      rethrow;
    }
  }
}
