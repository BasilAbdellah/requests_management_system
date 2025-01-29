import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/ViewTransactions/Contrallers/transactions_service.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/StaffTransactionModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/TransactionEmployeeModel.dart';

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();

  // State for employee transactions
  List<GetAllTransactionsByEmployeeIdModel> employeeTransactions = [];
  bool isLoadingEmployee = false;
  String? employeeError;

  // State for staff transactions
  List<GetStaffTransactions> staffTransactions = [];
  bool isLoadingStaff = false;
  String? staffError;

  // Fetch employee transactions
  Future<void> fetchEmployeeTransactions() async {
    isLoadingEmployee = true;
    notifyListeners();

    try {
      employeeTransactions =
          await _transactionService.getTransactionsByEmployeeId();
      employeeError = null;
    } catch (e) {
      employeeError = e.toString();
    }

    isLoadingEmployee = false;
    notifyListeners();
  }

  // Fetch staff transactions
  Future<void> fetchStaffTransactions() async {
    isLoadingStaff = true;
    notifyListeners();

    try {
      staffTransactions = await _transactionService.getStaffTransactions();
      staffError = null;
    } catch (e) {
      staffError = e.toString();
    }

    isLoadingStaff = false;
    notifyListeners();
  }
}
