import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/error_model.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/resend_transaction_model.dart';

class ResendTransactionService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;

  Future<ResendTransactionModel> resendTransaction(int transactionId) async {
    final String url = "${Endpoints.resendTransaction}?transactionId=$transactionId";

    try {
      var response = await _apiConsumer.post(
        url,
      );

      if (response == null || response.isEmpty || response is! Map<String, dynamic>) {
        throw ServerException(errModel: ErrorModel(status: 500,errorMessage: "Invalid response from server"));
      }

      return ResendTransactionModel.fromJson(response);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception("Failed to resend transaction: $e");
    }
  }
}