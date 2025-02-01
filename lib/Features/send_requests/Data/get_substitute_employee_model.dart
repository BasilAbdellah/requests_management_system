class GetSubstituteEmployeeModel {
  GetSubstituteEmployeeModel({
    this.employeeId,
    this.employeeName,
  });

  GetSubstituteEmployeeModel.fromJson(dynamic json) {
    employeeId = json['employeeId'];
    employeeName = json['employeeName'];
  }
  int? employeeId;
  String? employeeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['employeeId'] = employeeId;
    map['employeeName'] = employeeName;
    return map;
  }
}