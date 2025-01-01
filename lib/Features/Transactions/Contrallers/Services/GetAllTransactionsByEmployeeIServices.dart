import 'package:dio/dio.dart';
import 'package:requests_management_system/Features/Transactions/Data/Models/GetAllTransactionsByEmployeeIdModel.dart';

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
        throw Exception('فشل في تحميل البيانات: ${response.statusMessage}');
      }
    } on DioError catch (dioError) {
      throw Exception(
          'خطأ Dio: ${dioError.message}, استجابة: ${dioError.response?.data}');
    } catch (e) {
      throw Exception('حدث خطأ غير متوقع: $e');
    }
  }
}
