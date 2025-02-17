class SendRequestModel {
  bool? status;
  String? message;
  SendRequestModel({required this.status, required this.message});

  factory SendRequestModel.fromJson(Map<String, dynamic> json) {
    return SendRequestModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
