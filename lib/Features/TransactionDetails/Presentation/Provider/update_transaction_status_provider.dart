import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Contraller/update_transaction_status_service.dart';

class UpdateTransactionStatusProvider with ChangeNotifier {
  final _service = UpdateTransactionStatusService(); // Initialize directly

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> updateTransactionStatus({
    required int transactionId,
    required String status,
    required String responseMessage,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _service.updateTransactionStatus(
        transactionId: transactionId,
        status: status,
        responseMessage: responseMessage,
      );
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