import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Transaction/Data/StaffTransactionModel.dart';
import 'package:requests_management_system/Features/Transaction/Data/TransactionEmployeeModel.dart';


class TransactionService {
  final Dio _dio = Dio();
  final String baseUrl = "http://41.239.5.3:8080/api/Transaction";

  // Fetch transactions by employee ID
  Future<List<GetAllTransactionsByEmployeeIdModel>> getTransactionsByEmployeeId(
      int employeeId) async {
    final url = "$baseUrl/GetAllTransactionsByEmployeeId/$employeeId";

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => GetAllTransactionsByEmployeeIdModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load transactions: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error fetching transactions: $e');
    }
  }

  // Fetch staff transactions
  Future<List<GetStaffTransactions>> getStaffTransactions(int employeeId) async {
    final url = "$baseUrl/GetStaffTransactions/$employeeId";

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => GetStaffTransactions.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load staff transactions: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error fetching staff transactions: $e');
    }
  }
}
