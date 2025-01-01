class GetStaffTransactionModel {
  final String employeeName;
  final bool seen;
  final int transactionId;
  final String title;
  final String type;
  final String status;
  final String dueDate;
  final String takenDays;
  final String sendDate;

  GetStaffTransactionModel({
    required this.employeeName,
    required this.seen,
    required this.transactionId,
    required this.title,
    required this.type,
    required this.status,
    required this.dueDate,
    required this.takenDays,
    required this.sendDate,
  });

  factory GetStaffTransactionModel.fromJson(Map<String, dynamic> json) {
    return GetStaffTransactionModel(
      employeeName: json['employeeName'],
      seen: json['seen'],
      transactionId: json['transactionId'],
      title: json['title'],
      type: json['type'],
      status: json['status'],
      dueDate: json['dueDate'],
      takenDays: json['takenDays'],
      sendDate: json['sendDate'],
    );
  }
}
