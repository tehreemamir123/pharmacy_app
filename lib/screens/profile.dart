import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.cyan,
    body: SafeArea(
    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const SizedBox(height: 20),

    /// TITLE
    const Text(
    "Profile Page",
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 30),

    /// PROFILE IMAGE
    CircleAvatar(
    radius: 45,
    backgroundImage: AssetImage(
    "assets/hijab.jpg", // 🔹 tum apni image lagana
    ),
    ),

    const SizedBox(height: 30),

    /// NAME CARD
    profileTile(
    icon: Icons.person_outline,
    title: "Name",
    value: "Tehreem Fatima",
    ),

    const SizedBox(height: 15),

    /// EMAIL CARD
    profileTile(
    icon: Icons.email_outlined,
    title: "Email",
    value: "tehreemamir09@gmail.com",
    ),

    const SizedBox(height: 20),

    /// LOGOUT
    actionTile(
    icon: Icons.logout,
    title: "LogOut",
    iconColor: Colors.black,
    ),

    const SizedBox(height: 15),

    /// DELETE ACCOUNT
    actionTile(
    icon: Icons.delete_outline,
    title: "Delete Account",
    iconColor: Colors.black,
    ),
    ],
    ),
    ),
    ),
    );
    }

    /// 🔹 INFO TILE (Name, Email)
    Widget profileTile({
    required IconData icon,
    required String title,
    required String value,
    }) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
    children: [
    Icon(icon, size: 22),
    const SizedBox(width: 12),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    title,
    style: const TextStyle(
    fontSize: 12,
    color: Colors.grey,
    ),
    ),
    const SizedBox(height: 3),
    Text(
    value,
    style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    ),
    ),
    ],
    ),
    ],
    ),
    );
    }

    /// 🔹 ACTION TILE (Logout / Delete)
    Widget actionTile({
    required IconData icon,
    required String title,
    required Color iconColor,
    }) {
    return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
    children: [
    Icon(icon, color: iconColor),
    const SizedBox(width: 12),
    Text(
    title,
    style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    ),
    ),
    const Spacer(),
    const Icon(Icons.arrow_forward_ios, size: 16),
    ],
    ),
    );
    }
    }

