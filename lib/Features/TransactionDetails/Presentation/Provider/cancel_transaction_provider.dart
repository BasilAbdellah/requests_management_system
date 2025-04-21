import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/TransactionDetails/Contraller/canceltransaction_service.dart';

class CancelTransactionProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Response? response;

  Future<void> cancelTransaction(int transactionId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      response = await CancelTransactionService.cancelTransaction(transactionId);
      
      if (response?.statusCode != 200) {
        _error = _getErrorMessage(response?.statusCode);
      }
    } catch (e) {
      _error = "حدث خطأ غير متوقع";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _getErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "طلب غير صالح";
      case 401:
        return "غير مصرح";
      case 403:
        return "ممنوع";
      case 404:
        return "الطلب غير موجود أو تم إلغاؤه مسبقاً";
      case 500:
        return "خطأ في الخادم";
      default:
        return "حدث خطأ ما";
    }
  }
}