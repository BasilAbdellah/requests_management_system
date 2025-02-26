import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/api/api_consumer.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/transaction_details_model.dart';

class TransactionDetailsService {
  final ApiConsumer _apiConsumer = Instances.dioConsumerInstance;

  Future<TransactionDetailsModel?> getTransactionDetails(int transactionId) async {
    final String url = "${Endpoints.getTransactionDetails}${transactionId.toString()}";

    try {
      var response = await _apiConsumer.get(url);

      if (response == null || response.isEmpty || response is! Map<String, dynamic>) {
        return null;
      }

      return TransactionDetailsModel.fromJson(response);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw Exception("Failed to fetch transaction details: $e");
    }
  }
}
