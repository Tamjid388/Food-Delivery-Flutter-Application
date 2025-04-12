// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/components/my_drawer_tile.dart';
import 'package:food_delivery_app/pages/home_page.dart';
import 'package:food_delivery_app/pages/login_page.dart';
import 'package:food_delivery_app/services/auth/login_or_register.dart';

import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor:Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // App logo
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child:   Image.asset('assets/bgmain.png', height: 150, width: 150)
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
      SizedBox(height: 40,),
          // Home list tile
          MyDrawerTile(
              text: "H O M E",
              icon: Icons.home,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }),
          // Settings list tile
          MyDrawerTile(
            text: "S E T T I N G",
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          const Spacer(),
          // Logout list tile
          MyDrawerTile(
            text: "L O G O U T",
            icon: Icons.logout,
            onTap: () async {
              try {
                // Log out from Firebase
                await FirebaseAuth.instance.signOut();

                // Navigate to the LoginOrRegister widget, removing all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginOrRegister(),
                  ),
                  (route) => false,
                );
              } catch (e) {
                // Handle errors
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error logging out: $e")),
                );
              }
            },
          ),

          const SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
