import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/TransactionDetails/Contraller/resent_transaction_service.dart';
import 'package:requests_management_system/Features/TransactionDetails/Data/resend_transaction_model.dart';

class ResendTransactionProvider with ChangeNotifier {
  final ResendTransactionService _resendTransactionService = ResendTransactionService();

  bool _isLoading = false;
  String? _error;
  ResendTransactionModel? _resendTransactionResponse;

  bool get isLoading => _isLoading;
  String? get error => _error;
  ResendTransactionModel? get resendTransactionResponse => _resendTransactionResponse;

  Future<void> resendTransaction(int transactionId,String status) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _resendTransactionResponse = await _resendTransactionService.resendTransaction(transactionId,status);
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