class BaseResponce {
  bool status;
  String message;
  BaseResponce(this.status, this.message);

  factory BaseResponce.fromJson(data) {
    return BaseResponce(data["status"], data['message']);
  }
}