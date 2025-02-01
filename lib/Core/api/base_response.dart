class BaseResponse {
  bool status;
  String message;
  BaseResponse({required this.status, required this.message});

  factory BaseResponse.fromJson(data) {
    return BaseResponse(status: data["status"], message: data['message']);
  }
}
