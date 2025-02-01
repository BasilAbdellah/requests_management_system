import 'package:dio/dio.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/send_requests/Data/send_request_model.dart';

class SendRequestService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;

  Future<dynamic> sendRequest(
      {String? title,
      String? type,
      DateTime? startDate,
      DateTime? endDate,
      int? substituteEmployeeId,
      int? employeeId,
      String? itinerar}) async {
    const String url = "${Endpoints.sendRequestTransaction}";

    try {
      var response = await _apiConsumer.post(
        url,
        data: {
          "Title": title,
          "Type": type,
          "StartDate": startDate?.toIso8601String(),
          "EndDate": endDate?.toIso8601String(),
          "SubstituteEmployeeId": substituteEmployeeId,
          "EmployeeId": employeeId,
          "Itinerar": itinerar,
        },
      );
      return SendRequestModel.fromJson(response);
    } on ServerException catch (e) {
      return SendRequestModel(status: false, message: e.errModel.errorMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
