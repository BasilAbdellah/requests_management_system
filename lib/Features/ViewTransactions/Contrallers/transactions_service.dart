import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/StaffTransactionModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/TransactionEmployeeModel.dart';

class TransactionService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;

  // Fetch transactions by employee ID
  Future<List<GetAllTransactionsByEmployeeIdModel>>
      getTransactionsByEmployeeId() async {
    var employeeId = CacheHelper.getData(key: ApiKey.employeeId);
    final url = "${Endpoints.getEmployeeTransactions}$employeeId";

    try {
      final response = await _apiConsumer.get(url);
      if (response.isEmpty) {
        return [];
      }
      return response
          .map<GetAllTransactionsByEmployeeIdModel>(
              (json) => GetAllTransactionsByEmployeeIdModel.fromJson(json))
          .toList();
    } on ServerException {
      rethrow;
    }
  }

  // Fetch staff transactions
  Future<List<GetStaffTransactions>> getStaffTransactions() async {
    var managerId = CacheHelper.getData(key: ApiKey.employeeId);
    final url = "${Endpoints.getStaffTransactions}$managerId";

    try {
      final response = await _apiConsumer.get(url);
      if (response.isEmpty) {
        return [];
      }
      return response
          .map<GetStaffTransactions>(
              (json) => GetStaffTransactions.fromJson(json))
          .toList();
    } on ServerException {
      rethrow;
    }
  }
}
