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

  ProfileModel.fromJson(dynamic json) {
    employeeId = json['employeeId'] is int
        ? json['employeeId']
        : int.tryParse(json['employeeId'].toString()) ?? 0;
    employeeName = json['employeeName'] ?? '';
    departmentName = json['departmentName'] ?? '';
    casualLeaveCount = json['casualLeaveCount'] is int
        ? json['casualLeaveCount']
        : int.tryParse(json['casualLeaveCount'].toString()) ?? 0;
    dateOfEmployment = json['dateOfEmployment'] ?? '';
    managerName = json['managerName'] ?? '';
    regularLeaveCount = json['regularLeaveCount'] is int
        ? json['regularLeaveCount']
        : int.tryParse(json['regularLeaveCount'].toString()) ?? 0;
  }

  int? employeeId;
  String? employeeName;
  String? departmentName;
  int? casualLeaveCount;
  String? dateOfEmployment;
  String? managerName;
  int? regularLeaveCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employeeId'] = employeeId;
    map['employeeName'] = employeeName;
    map['departmentName'] = departmentName;
    map['casualLeaveCount'] = casualLeaveCount;
    map['dateOfEmployment'] = dateOfEmployment;
    map['managerName'] = managerName;
    map['regularLeaveCount'] = regularLeaveCount;
    return map;
  }
}
