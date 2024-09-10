import 'package:akpa/model/confgmodel/config_model.dart';
import 'package:akpa/model/usermodel/user_model.dart';
import 'package:akpa/service/api_service.dart';
import 'package:akpa/service/notification_service.dart';
import 'package:akpa/view/dashboard/dashboard.dart';
import 'package:akpa/view/death_details/death_details.dart';
import 'package:akpa/view/help_provided_list/help_provided_list.dart';
import 'package:akpa/view/drawer/drawer.dart';
import 'package:akpa/view/home_screen/widgets/widget.dart';
import 'package:akpa/view/transaction/transaction.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Config> config;
  late Future<UserProfile> userProfile;
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    config = ApiService().fetchConfig();
    userProfile = ApiService().getUserProfile('1129');
    loadUnreadNotificationsCount();
  }

  Future<void> loadUnreadNotificationsCount() async {
    final count = await NotificationService().getUnreadCount('1129');
    setState(() {
      unreadCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: Future.wait([config, userProfile]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final config = snapshot.data![0] as Config;
            final userProfile = snapshot.data![1] as UserProfile;

            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Image.asset(
                            'assets/menus.png',
                            height: 30,
                            width: 30,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search',
                                hintStyle:
                                    const TextStyle(color: Colors.black54),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                suffixIcon: Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(Icons.search,
                                      color: Colors.black),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: buildProfileImage(config, userProfile),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfile.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              userProfile.districtName,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'What do you want to donate today',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Dashboard',
                      'View your dashboard &\ncheck your details',
                      'assets/dashboard.png',
                      Colors.blue.shade100,
                      Color.fromARGB(255, 3, 111, 200),
                      DashBoardScreen(),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Transactions',
                      'View your transaction & details',
                      'assets/transaction.png',
                      Colors.red.shade100,
                      Color.fromARGB(255, 237, 111, 102),
                      TransactionScreen(),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Help Provided list',
                      'View your Help Provided list',
                      'assets/help.png',
                      Colors.teal.shade100,
                      Colors.green,
                      HelpProvidedList(),
                    ),
                    const SizedBox(height: 30),
                    buildCard(
                      context,
                      'Death list',
                      'View Death list',
                      'assets/death.png',
                      Colors.red,
                      Colors.white,
                      DeathListPage(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
