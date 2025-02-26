class ResendTransactionModel {
  final String status;
  final String responceMessage;

  ResendTransactionModel({required this.status, required this.responceMessage});

  factory ResendTransactionModel.fromJson(Map<String, dynamic> json) {
    return ResendTransactionModel(
      status: json['status'],
      responceMessage: json['responceMessage'],
    );
  }
}