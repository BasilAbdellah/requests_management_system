import 'package:dio/dio.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = await AuthServiceJWT.getToken(ApiKey.tokenKey);

    options.headers = {
      'Authorization': token != null ? 'Bearer $token' : null,
      'Content-Type': 'application/json',
    };

    super.onRequest(options, handler);
  }
}
