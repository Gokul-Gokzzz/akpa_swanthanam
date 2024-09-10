import 'dart:developer';
import 'package:akpa/model/helpmodel/help_model.dart';
import 'package:akpa/service/api_service.dart';
import 'package:flutter/material.dart';

class HelpProvidedList extends StatefulWidget {
  const HelpProvidedList({super.key});

  @override
  State<HelpProvidedList> createState() => _HelpProvidedListState();
}

class _HelpProvidedListState extends State<HelpProvidedList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Changed background color to white
        body: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Help Provided List',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color changed to black
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<HelpModel>(
                  future: ApiService().getUserList('1129'),
                  builder: (context, snapshot) {
                    log('Snapshot Data: ${snapshot.data}');

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      log('Error ui: ${snapshot.error}');
                      return const Center(
                        child: Text(
                          'Failed to load help list',
                          style: TextStyle(
                              color: Colors.black), // Error text color black
                        ),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.data.isEmpty) {
                      return const Center(
                        child: Text(
                          'No help provided.',
                          style: TextStyle(
                              color:
                                  Colors.black), // Empty list text color black
                        ),
                      );
                    } else {
                      final helpList = snapshot.data!.data;
                      log('Help List Length: ${helpList.length}');
                      return ListView.builder(
                        itemCount: helpList.length,
                        itemBuilder: (context, index) {
                          final help = helpList[index];

                          final name = help.name ?? 'No Name Available';
                          final image = help.image.isNotEmpty
                              ? help.image
                              : 'https://via.placeholder.com/150';

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 16.0),
                              decoration: BoxDecoration(
                                color: Colors
                                    .grey.shade300, // Light container color
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .black), // Name text color black
                                          ),
                                          Text(
                                            help.districtName ?? 'Unknown',
                                            style: const TextStyle(
                                                color: Colors
                                                    .grey), // District name grey
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  HelpInfo(
                                      'Account Amount', help.accountAmount),
                                  HelpInfo(
                                      'Balance Amount', help.balanceAmount),
                                  HelpInfo('Date of Death', help.dateOfDeath),
                                  HelpInfo('Cheque Number', help.chequeNumber),
                                  HelpInfo(
                                      'Credited Amount', help.creditedAmount),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget HelpInfo(String? title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              color: Colors.black87, // Info title color black
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value?.toString() ?? 'N/A',
            style:
                const TextStyle(color: Colors.black), // Info value color black
          ),
        ],
      ),
    );
  }
}
