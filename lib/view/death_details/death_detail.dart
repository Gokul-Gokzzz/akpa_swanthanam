import 'package:flutter/material.dart';
import 'package:akpa/model/deathmodel/death_model.dart';
import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:intl/intl.dart';

class DeathDetailPage extends StatelessWidget {
  final DeathDetail deathDetail;
  final Config config;

  const DeathDetailPage(
      {super.key, required this.deathDetail, required this.config});

  // Method to calculate age from date of birth
  String calculateAge(String dateOfBirth) {
    // Parse the date of birth string in yyyy-MM-dd format
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(dateOfBirth);
    DateTime currentDate = DateTime.now();

    int age = currentDate.year - birthDate.year;

    // Adjust for if the birthdate hasn't occurred yet this year
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age.toString();
  }

  // Method to format a date string from yyyy-MM-dd to dd-MM-yyyy
  String formatDate(String date, String format) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateFormat outputFormat = DateFormat(format);
    DateTime parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deathDetail.name),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Image.network(
                '${config.baseUrls.customerImageUrl}/${deathDetail.image}',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Name'),
              subtitle: Text(deathDetail.name),
              leading: const Icon(Icons.person),
            ),
            ListTile(
              title: const Text('District Name'),
              subtitle: Text(deathDetail.districtName),
              leading: const Icon(Icons.location_city),
            ),
            ListTile(
              title: const Text('Meghala Name'),
              subtitle: Text(deathDetail.meghalaName),
              leading: const Icon(Icons.place),
            ),
            ListTile(
              title: const Text('Unit Name'),
              subtitle: Text(deathDetail.unitName),
              leading: const Icon(Icons.business),
            ),
            ListTile(
              title: const Text('Age'),
              subtitle: Text(calculateAge(deathDetail.dateOfBirth)),
              leading: const Icon(Icons.cake),
            ),
            ListTile(
              title: const Text('Join Year'),
              subtitle: Text(deathDetail.joinYear),
              leading: const Icon(Icons.calendar_today),
            ),
            ListTile(
              title: const Text('Date of Death'),
              subtitle: Text(formatDate(deathDetail.dateOfDeath, 'dd-MM-yyyy')),
              leading: const Icon(Icons.event),
            ),
            ListTile(
              title: const Text('Date of Birth'),
              subtitle: Text(formatDate(deathDetail.dateOfBirth, 'dd-MM-yyyy')),
              leading: const Icon(Icons.cake),
            ),
            const ListTile(
              title: Text('Amount'),
              subtitle: Text('100'),
              leading: Icon(Icons.money),
            ),
          ],
        ),
      ),
    );
  }
}
