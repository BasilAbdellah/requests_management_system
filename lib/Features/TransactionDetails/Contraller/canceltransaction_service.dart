import 'package:dio/dio.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';

class CancelTransactionService {
  static Dio dio = Dio();
  
  static Future<Response> cancelTransaction(int transactionId) async {
    try {
      final String url = "${Endpoints.cancelTransaction}$transactionId";
      var response = await dio.delete(
        url,
        options: Options(
          validateStatus: (status) => status! < 500, // Don't throw for 4xx errors
        ),
      );
      return response;
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        return e.response!; // Return the error response
      } else {
        rethrow; // Re-throw other Dio errors
      }
    }
  }
}