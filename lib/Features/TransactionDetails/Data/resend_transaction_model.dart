class ResendTransactionModel {
  final bool status;
  final String responceMessage;

  ResendTransactionModel({required this.status, required this.responceMessage});

  factory ResendTransactionModel.fromJson(Map<String, dynamic> json) {
    return ResendTransactionModel(
      status: json['status'],
      responceMessage: json['message'],
    );
  }
}
