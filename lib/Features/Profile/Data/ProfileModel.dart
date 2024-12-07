class ProfileModel {
  ProfileModel({
    this.employeeId,
    this.employeeName,
    this.departmentName,
    this.casualLeaveCount,
    this.dateOfEmployment,
    this.managerName,
    this.regularLeaveCount,
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    employeeId = _parseInt(json['employeeId']);
    employeeName = json['employeeName'] ?? '';
    departmentName = json['departmentName'] ?? '';
    casualLeaveCount = _parseInt(json['casualLeaveCount']);
    dateOfEmployment = json['dateOfEmployment'] ?? '';
    managerName = json['managerName'] ?? '';
    regularLeaveCount = _parseInt(json['regularLeaveCount']);
  }

  int? employeeId;
  String? employeeName;
  String? departmentName;
  int? casualLeaveCount;
  String? dateOfEmployment;
  String? managerName;
  int? regularLeaveCount;

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
      'departmentName': departmentName,
      'casualLeaveCount': casualLeaveCount,
      'dateOfEmployment': dateOfEmployment,
      'managerName': managerName,
      'regularLeaveCount': regularLeaveCount,
    };
  }

  // Helper function to handle both String and int data types
  int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return value is int ? value : 0;
  }
}
