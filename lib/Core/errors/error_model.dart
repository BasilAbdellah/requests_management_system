import 'package:dio/dio.dart';

class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.responseInfo(Response<dynamic> response) {
    return ErrorModel(
      status: response.statusCode ?? 0,
      errorMessage: response.statusMessage ?? 'unexpected error',
    );
  }
}
