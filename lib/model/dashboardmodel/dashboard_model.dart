class DashBoardModel {
  bool? status;
  String? message;

  DashBoardModel({
    this.status,
    this.message,
  });

  DashBoardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson(data) {
    data['status'] = status;
    data['message'] = message;

    return data;
  }
}
