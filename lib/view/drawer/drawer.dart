import 'package:akpa/service/api_service.dart';
import 'package:akpa/service/store_service.dart';
import 'package:akpa/view/dashboard/dashboard.dart';
import 'package:akpa/view/death_details/death_details.dart';
import 'package:akpa/view/family_details/family_details.dart';
import 'package:akpa/view/help_provided_list/help_provided_list.dart';
import 'package:akpa/view/drawer/widget/drawer_widget.dart';
import 'package:akpa/view/member_list/member_list.dart';
import 'package:akpa/view/notification_screen/notifiaction.dart';
import 'package:akpa/view/profile_screen/profile.dart';
import 'package:akpa/view/transaction/transaction.dart';
import 'package:akpa/view/welcome_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white, // Change background to white
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              MyListTile(
                imagePath: 'assets/user.png',
                text: 'Profile',
                textColor: Colors.black, // Set text color to black
                iconColor: Colors.black, // Set icon color to black
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                ),
              ),
              MyListTile(
                imagePath: 'assets/dashboardicon.png',
                text: 'Dashboard',
                textColor: Colors.black,
                iconColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashBoardScreen(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/transactionicon.png',
                text: 'Transaction',
                textColor: Colors.black,
                iconColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TransactionScreen(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/helpprovided.png',
                text: 'Help Provided list',
                textColor: Colors.black,
                iconColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpProvidedList(),
                    ),
                  );
                },
              ),
              MyListTile(
                imagePath: 'assets/members.png',
                text: 'Death List',
                textColor: Colors.black,
                iconColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeathListPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: MyListTile(
              imagePath: 'assets/logout.png',
              text: 'L O G O U T',
              textColor: Colors.red, // Set logout text color to red
              iconColor: Colors.red, // Set logout icon color to red
              onTap: () async {
                await ApiService().logout();
                await StoreService().clearValues();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
