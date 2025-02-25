import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Contraller/canceltransaction_service.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/cancel_transaction_model.dart';

class CancelTransactionProvider with ChangeNotifier {
  final CancelTransactionService _cancelTransactionService = CancelTransactionService();

  bool _isLoading = false;
  String? _error;
  CancelTransactionModel? _cancelTransactionResponse;

  bool get isLoading => _isLoading;
  String? get error => _error;
  CancelTransactionModel? get cancelTransactionResponse => _cancelTransactionResponse;

  Future<void> cancelTransaction(int transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cancelTransactionResponse = await _cancelTransactionService.cancelTransaction(transactionId);
      if (_cancelTransactionResponse?.success == false) {
        _error = _cancelTransactionResponse?.message ?? "Failed to cancel transaction";
      }
    } catch (e) {
      _error = e.toString();
      if (e is ServerException) {
        _error = e.errModel.errorMessage;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}