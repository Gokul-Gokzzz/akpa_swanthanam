// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/deathmodel/death_model.dart';
import 'package:akpa/service/api_service.dart';
import 'package:akpa/view/death_details/death_detail.dart';
import 'dart:developer';
import 'package:intl/intl.dart';

class DeathListPage extends StatefulWidget {
  const DeathListPage({super.key});

  @override
  _DeathListPageState createState() => _DeathListPageState();
}

class _DeathListPageState extends State<DeathListPage> {
  late Future<List<DeathDetail>> deathDetails;
  late Future<Config> config;

  @override
  void initState() {
    super.initState();
    deathDetails = ApiService().fetchDeathDetails('1129');
    config = ApiService().fetchConfig();
  }

  String formatDate(String date) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateFormat outputFormat = DateFormat('dd-MM-yyyy');
    DateTime parsedDate = inputFormat.parse(date);
    return outputFormat.format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Death List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<Config>(
        future: config,
        builder: (context, configSnapshot) {
          if (configSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (configSnapshot.hasError) {
            log("Error fetching config: ${configSnapshot.error}");
            return const Center(
              child: Text(
                'Failed to load configuration',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else if (!configSnapshot.hasData) {
            return const Center(child: Text('No configuration found'));
          } else {
            final config = configSnapshot.data!;
            return FutureBuilder<List<DeathDetail>>(
              future: deathDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  log("Error fetching death details: ${snapshot.error}");
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'An error occurred while loading the death details.',
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              deathDetails =
                                  ApiService().fetchDeathDetails('1129');
                            });
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No death details found'));
                } else {
                  final deathDetails = snapshot.data!;
                  return ListView.builder(
                    itemCount: deathDetails.length,
                    itemBuilder: (context, index) {
                      final detail = deathDetails[index];
                      return ListTile(
                        leading: Image.network(
                          '${config.baseUrls.customerImageUrl}/${detail.image}',
                        ),
                        title: Text(
                          detail.name,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'Date of Death: ${formatDate(detail.dateOfDeath)}',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeathDetailPage(
                                deathDetail: detail,
                                config: config,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
