import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/update_transaction_status_model.dart';

class UpdateTransactionStatusService {
  final ApiConsumer _apiConsumer;
  
  UpdateTransactionStatusService(this._apiConsumer);

  Future<void> updateTransactionStatus({
    required int transactionId ,
    required String status,
    required String responseMessage,
  }) async {
    final String url = "${Endpoints.updateTransactionStatus}/$transactionId";

    try {
      final body = UpdateTransactionStatusModel(
        status: status,
        responseMessage: responseMessage,
        
      ).toJson();

      await _apiConsumer.put(url, data: body);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception("Failed to update transaction status: $e");
    }
  }
}