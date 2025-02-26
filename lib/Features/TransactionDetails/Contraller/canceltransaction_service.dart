import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/error_model.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/cancel_transaction_model.dart';

class CancelTransactionService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;

  Future<CancelTransactionModel> cancelTransaction(int transactionId) async {
    final String url = "${Endpoints.cancelTransaction}$transactionId";

    try {
      var response = await _apiConsumer.post(url);

      if (response == null || response.isEmpty || response is! Map<String, dynamic>) {
        throw ServerException(errModel: ErrorModel(errorMessage: "Invalid response from server",status: 500));
      }

      return CancelTransactionModel.fromJson(response);
      
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception("Failed to cancel transaction: $e");
    }
  }
}