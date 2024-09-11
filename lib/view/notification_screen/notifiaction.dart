// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:akpa/model/notificationmodel/notification_model.dart';
import 'package:akpa/service/notification_service.dart';
import 'package:akpa/view/death_details/death_details.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<NotificationModel>> _notifications;
  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final notifications =
        await NotificationService().fetchNotifications('1129');

    setState(() {
      _notifications = Future.value(notifications ?? []);
      _unreadCount = notifications?.where((n) => n.isSeen == 0).length ?? 0;
    });
  }

  void _markAsSeen(String notificationId) async {
    final bool response =
        await NotificationService().markAsSeen(notificationId);
    if (response) {
      setState(() {
        _notifications = _notifications.then((notifications) {
          return notifications.map((n) {
            if (n.id.toString() == notificationId) {
              n.isSeen = 1;
              _unreadCount--;
            }
            return n;
          }).toList();
        });
      });
    } else {
      log('Failed to mark notification as seen');
    }
  }

  void _clearAllNotifications() async {
    await NotificationService().clearAllNotifications();
    loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
              if (_unreadCount > 0)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Center(
                      child: Text(
                        '$_unreadCount',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.clear_all, color: Colors.white),
            onPressed: _clearAllNotifications,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<NotificationModel>>(
        future: _notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No notifications available.',
                    style: TextStyle(color: Colors.white)));
          }

          final notifications = snapshot.data!;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final textColor = notification.type == "SUCCESS"
                  ? Colors.white
                  : notification.type == "ERROR"
                      ? Colors.red
                      : Colors.grey;

              return ListTile(
                title: Text(
                  notification.description,
                  style: TextStyle(
                    color: notification.isSeen == 1
                        ? textColor.withOpacity(0.5)
                        : textColor,
                  ),
                ),
                onTap: () {
                  if (notification.isSeen == 0) {
                    _markAsSeen(notification.id.toString());
                  }

                  if (notification.type == "ERROR") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeathListPage()),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
