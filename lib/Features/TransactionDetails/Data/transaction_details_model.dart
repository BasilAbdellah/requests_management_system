class TransactionDetailsModel {
  int? transactionId;
  String? title;
  String? type;
  String? startDate;
  String? endDate;
  dynamic itinerary;
  dynamic respondDate;
  String? respondMessage;
  String? status;
  String? creationDate;
  Employee? employee;
  SubstituteEmployee? substituteEmployee;
  String? takenDays;
  String? seenStatus;
  

  TransactionDetailsModel({this.transactionId, this.title, this.type, this.startDate, this.endDate, this.itinerary, this.respondDate, this.respondMessage, this.status, this.creationDate, this.employee, this.substituteEmployee, this.takenDays, this.seenStatus});

  TransactionDetailsModel.fromJson(Map<String, dynamic> json) {
    transactionId = json["transactionId"];
    title = json["title"];
    type = json["type"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    itinerary = json["itinerary"];
    respondDate = json["respondDate"];
    respondMessage = json["respondMessage"];
    status = json["status"];
    creationDate = json["creationDate"];
    employee = json["employee"] == null ? null : Employee.fromJson(json["employee"]);
    substituteEmployee = json["substituteEmployee"] == null ? null : SubstituteEmployee.fromJson(json["substituteEmployee"]);
    takenDays = json["takenDays"];
    seenStatus = json["seenStatus"];
  }

  static List<TransactionDetailsModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(TransactionDetailsModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["transactionId"] = transactionId;
    _data["title"] = title;
    _data["type"] = type;
    _data["startDate"] = startDate;
    _data["endDate"] = endDate;
    _data["itinerary"] = itinerary;
    _data["respondDate"] = respondDate;
    _data["respondMessage"] = respondMessage;
    _data["status"] = status;
    _data["creationDate"] = creationDate;
    if(employee != null) {
      _data["employee"] = employee?.toJson();
    }
    if(substituteEmployee != null) {
      _data["substituteEmployee"] = substituteEmployee?.toJson();
    }
    _data["takenDays"] = takenDays;
    _data["seenStatus"] = seenStatus;
    return _data;
  }
}

class SubstituteEmployee {
  int? employeeId;
  String? employeeName;

  SubstituteEmployee({this.employeeId, this.employeeName});

  SubstituteEmployee.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"];
    employeeName = json["employeeName"];
  }

  static List<SubstituteEmployee> fromList(List<Map<String, dynamic>> list) {
    return list.map(SubstituteEmployee.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["employeeName"] = employeeName;
    return _data;
  }
}

class Employee {
  int? employeeId;
  String? employeeName;

  Employee({this.employeeId, this.employeeName});

  Employee.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"];
    employeeName = json["employeeName"];
  }

  static List<Employee> fromList(List<Map<String, dynamic>> list) {
    return list.map(Employee.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["employeeName"] = employeeName;
    return _data;
  }
}