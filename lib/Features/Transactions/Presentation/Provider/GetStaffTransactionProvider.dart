import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Transactions/Contrallers/Services/GetStaffTransactionServices.dart';
import 'package:requests_management_system/Features/Transactions/Data/Models/GetStaffTransactionModel.dart';

class TransactionProviderStaff extends ChangeNotifier {
  final TransactionService _service = TransactionService();
  List<GetStaffTransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<GetStaffTransactionModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchStaffTransactions(int employeeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _transactions = await _service.fetchStaffTransactions(employeeId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
