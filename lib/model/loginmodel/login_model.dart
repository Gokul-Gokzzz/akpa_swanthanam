class LoginModel {
  final String? memberId;
  String? userName;
  String? password;

  LoginModel({
    this.memberId,
    this.userName,
    this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userName: json['userName'],
      password: json['password'],
      memberId: json['member_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'member_id': memberId,
    };
  }
}
