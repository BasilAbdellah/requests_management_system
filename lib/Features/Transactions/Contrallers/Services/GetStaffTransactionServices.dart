import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Transactions/Data/Models/GetStaffTransactionModel.dart';

class TransactionService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://41.239.5.3:8080';

  Future<List<GetStaffTransactionModel>> fetchStaffTransactions(int employeeId) async {
    try {
      final response = await _dio.get('$baseUrl/api/Transaction/GetStaffTransactions/$employeeId');

      if (response.statusCode == 200) {
        final List transactions = response.data;
        return transactions.map((json) => GetStaffTransactionModel.fromJson(json)).toList();
      } else {
        throw Exception('حدث خطأ أثناء تحميل البيانات');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception('خطأ في الاستجابة من الخادم: ${e.response?.statusMessage}');
      } else {
        throw Exception('خطأ في الاتصال بالخادم: ${e.message}');
      }
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
