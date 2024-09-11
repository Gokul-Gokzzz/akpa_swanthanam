import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String imagePath;
  final String text;
  final void Function()? onTap;
  final Widget? trailing;
  final Color textColor;
  final Color iconColor;

  const MyListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
    this.trailing,
    this.textColor = Colors.black,
    this.iconColor = Colors.black,
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
          color: iconColor,
        ),
        onTap: onTap,
        trailing: trailing,
        title: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
