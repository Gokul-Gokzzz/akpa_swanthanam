class EditProfilePicResponse {
  final bool status;
  final String message;

  EditProfilePicResponse({required this.status, required this.message});

  factory EditProfilePicResponse.fromJson(Map<String, dynamic> json) {
    return EditProfilePicResponse(
      status: json['status'],
      message: json['message'],
    );
  }
}
