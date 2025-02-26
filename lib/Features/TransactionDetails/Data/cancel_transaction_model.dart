class CancelTransactionModel {
  final String? message;
  final bool success;

  CancelTransactionModel({required this.message, required this.success});

  factory CancelTransactionModel.fromJson(Map<String, dynamic> json) {
    return CancelTransactionModel(
      message: json['message'],
      success: json['success'] ?? false,
    );
  }
}