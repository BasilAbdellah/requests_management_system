import 'package:flutter/material.dart';
import 'package:requests_management_system/Features/Transaction/Contraller/TransactionServices.dart';
import 'package:requests_management_system/Features/Transaction/Data/StaffTransactionModel.dart';
import 'package:requests_management_system/Features/Transaction/Data/TransactionEmployeeModel.dart';


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
  Future<void> fetchEmployeeTransactions(int employeeId) async {
    isLoadingEmployee = true;
    notifyListeners();

    try {
      employeeTransactions =
          await _transactionService.getTransactionsByEmployeeId(employeeId);
      employeeError = null;
    } catch (e) {
      employeeError = e.toString();
    }

    isLoadingEmployee = false;
    notifyListeners();
  }

  // Fetch staff transactions
  Future<void> fetchStaffTransactions(int employeeId) async {
    isLoadingStaff = true;
    notifyListeners();

    try {
      staffTransactions =
          await _transactionService.getStaffTransactions(employeeId);
      staffError = null;
    } catch (e) {
      staffError = e.toString();
    }

    isLoadingStaff = false;
    notifyListeners();
  }
}
