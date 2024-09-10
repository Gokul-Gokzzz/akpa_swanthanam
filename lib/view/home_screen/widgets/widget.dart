import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/usermodel/user_model.dart';
import 'package:flutter/material.dart';

Widget buildProfileImage(Config config, UserProfile userProfile) {
  final imageUrl = '${config.baseUrls.customerImageUrl}/${userProfile.image}';
  return Image.network(
    imageUrl,
    height: 80,
    width: 80,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.person, size: 80, color: Colors.grey);
    },
  );
}

Widget buildCard(BuildContext context, String title, String subtitle,
    String imagePath, Color bgColor, Color titleColor, Widget nextScreen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
    },
    child: Card(
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      'assets/right-arrow.png',
                      height: 14,
                      width: 14,
                      color: titleColor,
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: bgColor,
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
