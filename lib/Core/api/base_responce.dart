class BaseResponce {
  bool status;
  String message;
  BaseResponce({required this.status, required this.message});

  factory BaseResponce.fromJson(data) {
    return BaseResponce(status: data["status"], message: data['message']);
  }
}
