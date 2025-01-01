import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Transactions/Contrallers/Services/GetAllTransactionsByEmployeeIServices.dart';
import 'package:requests_management_system/Features/Transactions/Data/Models/GetAllTransactionsByEmployeeIdModel.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionService _transactionService = TransactionService();
  List<GetAllTransactionsByEmployeeIdModel> _transactions = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<GetAllTransactionsByEmployeeIdModel> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch transactions for a specific employee
  Future<void> fetchTransactions(int employeeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _transactions =
          await _transactionService.getTransactionsByEmployeeId(employeeId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
