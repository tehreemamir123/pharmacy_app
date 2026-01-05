import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:pharmacy_app/screens/Home_Screen.dart';
import 'package:pharmacy_app/screens/order_screen.dart';
import 'package:pharmacy_app/screens/profile.dart';
import 'package:pharmacy_app/screens/wallet.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    OrderScreen(),
    Wallet(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.black,
        buttonBackgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 400),

        items: const [
          Icon(Icons.home, color: Colors.white, size: 28),
          Icon(Icons.shopping_bag, color: Colors.white, size: 28),
          Icon(Icons.account_balance_wallet, color: Colors.white, size: 28),
          Icon(Icons.person, color: Colors.white, size: 28),
        ],

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
