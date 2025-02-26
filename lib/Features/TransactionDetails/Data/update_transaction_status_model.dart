class UpdateTransactionStatusModel {
  final String status;
  final String responseMessage;

  UpdateTransactionStatusModel({
    required this.status,
    required this.responseMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "responseMessage": responseMessage,
    };
  }
}