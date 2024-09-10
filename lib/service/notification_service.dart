import 'dart:developer';
import 'package:akpa/model/notificationmodel/notification_model.dart';
import 'package:dio/dio.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String _url =
      'https://akpa.in/santhwanam/api/v1/user/get_notifications';

  Future<List<NotificationModel>?> fetchNotifications(String memberId) async {
    try {
      final response = await _dio.post(
        _url,
        data: {'member_id': memberId},
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      print('API Response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data != null && response.data['data'] is List) {
          final data = response.data['data'] as List;
          return data.map((json) => NotificationModel.fromJson(json)).toList();
        } else {
          print('Unexpected API response structure: ${response.data}');
          return [];
        }
      }
      return [];
    } catch (e) {
      print('Error fetching notifications: $e');
      if (e is DioException) {
        print('Dio error: ${e.response?.data}');
      }
      return [];
    }
  }

  Future<bool> markAsSeen(String notificationId) async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/notifications_seen',
        data: {
          'notification_id': notificationId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Failed to mark notification as seen. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error marking notification as seen: $e');
      return false;
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      final response = await _dio.post(
        'https://lifelinekeralatrust.com/api/v1/user/notifications_clear_all',
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        log('All notifications cleared successfully.');
      } else {
        log('Failed to clear all notifications. Status code: ${response.statusCode}');
        log('Response: ${response.data}');
      }
    } catch (e) {
      log('Error clearing all notifications: $e');
    }
  }

  Future<int> getUnreadCount(String memberId) async {
    try {
      final notifications = await fetchNotifications(memberId);
      return notifications?.where((n) => n.isSeen == 0).length ?? 0;
    } catch (e) {
      log('Error fetching unread count: $e');
      return 0;
    }
  }
}
