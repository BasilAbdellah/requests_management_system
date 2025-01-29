class GetStaffTransactions {
  final String employeeName;
  final bool seen;
  final int transactionId;
  final String title;
  final String type;
  final String status;
  final String dueDate;
  final String takenDays;
  final String sendDate;

  GetStaffTransactions({
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

  // Factory method to create an instance from a JSON object
  factory GetStaffTransactions.fromJson(Map<String, dynamic> json) {
    return GetStaffTransactions(
      employeeName: json['employeeName'] as String,
      seen: json['seen'] as bool,
      transactionId: json['transactionId'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      dueDate: json['dueDate'] as String,
      takenDays: json['takenDays'] as String,
      sendDate: json['sendDate'] as String,
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'employeeName': employeeName,
      'seen': seen,
      'transactionId': transactionId,
      'title': title,
      'type': type,
      'status': status,
      'dueDate': dueDate,
      'takenDays': takenDays,
      'sendDate': sendDate,
    };
  }
}
