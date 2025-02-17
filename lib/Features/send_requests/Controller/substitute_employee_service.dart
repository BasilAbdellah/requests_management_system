import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Features/send_requests/Data/get_substitute_employee_model.dart';

class SubstituteEmployeeService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;
  Future<List<GetSubstituteEmployeeModel>> getSubstituteEmployee(
      String DepartmentName) async {
    String url = '${Endpoints.getSubstituteEmployee}$DepartmentName';
    try {
      final response = await _apiConsumer.get(url);
      // Here, response is a List<dynamic> directly.
      List<GetSubstituteEmployeeModel> employees = (response as List)
          .map<GetSubstituteEmployeeModel>(
              (json) => GetSubstituteEmployeeModel.fromJson(json))
          .toList();
      return employees;
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }
}
