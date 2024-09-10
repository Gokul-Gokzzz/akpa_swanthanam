import 'dart:io';
import 'dart:developer';
import 'package:akpa/model/editprofile/edit_profile_model.dart';
import 'package:dio/dio.dart';

class ProfileService {
  final Dio _dio = Dio();

  Future<EditProfilePicResponse> updateProfilePicture(File profileImage) async {
    String url = 'https://akpa.in/santhwanam/api/v1/user/edit_profile_pic';

    FormData formData = FormData.fromMap({
      'profile_pic': await MultipartFile.fromFile(profileImage.path),
    });

    try {
      log('Sending request to $url');
      log('File path: ${profileImage.path}');

      Response response = await _dio.post(url, data: formData);

      log('Response: ${response.statusCode} ${response.data}');

      if (response.statusCode == 200) {
        return EditProfilePicResponse.fromJson(response.data);
      } else {
        log('Error: Failed to update profile picture, status code: ${response.statusCode}');
        throw Exception('Failed to update profile picture');
      }
    } on DioError catch (dioError) {
      // Log Dio-specific errors
      log('Dio error: ${dioError.response?.statusCode}, message: ${dioError.message}');
      rethrow;
    } catch (e) {
      // General error logging
      log('General error: $e');
      rethrow;
    }
  }
}
