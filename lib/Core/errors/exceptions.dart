import 'package:dio/dio.dart';
import 'package:requests_management_system/Core/Utils/settings/endpoints.dart';
import 'package:requests_management_system/Core/Utils/settings/instances.dart';
import 'package:requests_management_system/Core/errors/error_model.dart';
import 'package:requests_management_system/Core/local_storage/cash_helper.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errModel: ErrorModel(
              status: 408,
              errorMessage:
                  "انتهت مهلة الاتصال. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.sendTimeout:
      throw ServerException(
          errModel: ErrorModel(
              status: 408,
              errorMessage:
                  "انتهت مهلة الإرسال. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errModel: ErrorModel(
              status: 408,
              errorMessage:
                  "انتهت مهلة الاستلام. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.badCertificate:
      throw ServerException(
          errModel: ErrorModel(
              status: 495,
              errorMessage:
                  "شهادة سيئة. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.cancel:
      throw ServerException(
          errModel: ErrorModel(
              status: 499,
              errorMessage:
                  "تم إلغاء الطلب. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.connectionError:
      throw ServerException(
          errModel: ErrorModel(
              status: 503,
              errorMessage:
                  "خطأ في الاتصال. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.unknown:
      throw ServerException(
          errModel: ErrorModel(
              status: 520,
              errorMessage:
                  "خطأ غير معروف. يرجى التحقق من الشبكة. تفاصيل: ${e.message}"));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
        case 401: //unauthorized
          handleRefreshToken();
        case 403: //forbidden
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
        case 404: //not found
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
        case 409: //cofficient
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
        case 422: //  Unprocessable Entity
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
        case 504: // Server exception
          throw ServerException(errModel: ErrorModel.responseInfo(e.response!));
      }
  }
}

void handleRefreshToken() async {
  try {
    var refreshtoke = await AuthServiceJWT.getToken(ApiKey.refreshTokenKey);
    var responce = await Instances.dioConsumerInstance.dio
        .get('${Endpoints.baseUrl}Employee/NewToken?refreshToken=$refreshtoke');
    await AuthServiceJWT.updateToken(ApiKey.tokenKey, responce.data);
  } on DioException catch (e) {
    if (e.response?.statusCode == 401) {
      throw ServerException(
          errModel:
              ErrorModel(status: 401, errorMessage: 'يرجى إعادة تسجيل الدخول'));
    } else {
      handleDioExceptions(e);
    }
  }
}
