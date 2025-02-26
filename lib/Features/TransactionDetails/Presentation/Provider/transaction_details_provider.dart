import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Contraller/transaction_details_service.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/transaction_details_model.dart';

class TransactionDetailsProvider with ChangeNotifier {
  final TransactionDetailsService _transactionDetailsService =
      TransactionDetailsService();

  TransactionDetailsModel? transactionDetails;
  bool dataLoaded = false;
  String? error;

  Future<void> fetchTransactionDetails(var transactionId) async {
    dataLoaded = true;

    try {
      transactionDetails =
          await _transactionDetailsService.getTransactionDetails(transactionId);
      error = null;
      if (transactionDetails == null) {
        error = "لا يوجد تفاصيل لهذه المعاملة";
      }
    } catch (e) {
      error = e.toString();
      if (e is ServerException) {
        error = e.errModel.errorMessage;
      }
    }

    // dataLoaded = false;  // (not needed since data is loaded)
    notifyListeners();
  }
}
