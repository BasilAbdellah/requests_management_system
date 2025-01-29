import 'package:flutter/material.dart';
import 'package:requests_management_system/Core/errors/exceptions.dart';
import 'package:requests_management_system/Features/ViewTransactions/Contrallers/transactions_service.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/StaffTransactionModel.dart';
import 'package:requests_management_system/Features/ViewTransactions/Data/TransactionEmployeeModel.dart';

class TransactionProvider with ChangeNotifier {
  final TransactionService _transactionService = TransactionService();

  // State for employee transactions
  List<GetAllTransactionsByEmployeeIdModel> employeeTransactions = [];
  bool employeeDataLoaded = false;
  bool staffDataLoaded = false;
  String? employeeError;

  // State for staff transactions
  List<GetStaffTransactions> staffTransactions = [];
  bool isLoadingStaff = false;
  String? staffError;

  // Fetch employee transactions
  Future<void> fetchEmployeeTransactions() async {
    employeeDataLoaded = true;
    // notifyListeners();

    try {
      employeeTransactions =
          await _transactionService.getTransactionsByEmployeeId();
      employeeError = null;
      if (employeeTransactions.isEmpty) {
        employeeError = "لا يوجد طلبات سابقة";
      }
    } catch (e) {
      employeeError = e.toString();
      if (e is ServerException) {
        employeeError = e.errModel.errorMessage;
      }
    }

    // employeeDataLoaded = false;
    notifyListeners();
  }

  // Fetch staff transactions
  Future<void> fetchStaffTransactions() async {
    staffDataLoaded = true;
    // notifyListeners();

    try {
      staffTransactions = await _transactionService.getStaffTransactions();
      staffError = null;
      if (staffTransactions.isEmpty) {
        staffError = "لا يوجد طلبات موظفين";
      }
    } catch (e) {
      staffError = e.toString();
      if (e is ServerException) {
        staffError = e.errModel.errorMessage;
      }
    }

    // isLoadingStaff = false;
    notifyListeners();
  }
}
