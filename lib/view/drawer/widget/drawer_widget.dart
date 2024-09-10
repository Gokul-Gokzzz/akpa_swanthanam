import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String imagePath;
  final String text;
  final void Function()? onTap;
  final Widget? trailing;
  final Color textColor; // Add textColor
  final Color iconColor; // Add iconColor

  const MyListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
    this.trailing,
    this.textColor = Colors.black, // Default text color
    this.iconColor = Colors.black, // Default icon color
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 20,
          height: 20,
          color: iconColor, // Apply icon color
        ),
        onTap: onTap,
        trailing: trailing,
        title: Text(
          text,
          style: TextStyle(color: textColor), // Apply text color
        ),
      ),
    );
  }
}
