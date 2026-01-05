import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/admin/add_product.dart';
import 'package:pharmacy_app/widget/Support_Widget.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  adminLogin() async {
    setState(() {
      loading = true;
    });

    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("Admin").get();

      bool found = false;

      for (var doc in snapshot.docs) {
        if (doc["id"] == nameController.text.trim() &&
            doc["password"] == passwordController.text.trim()) {
          found = true;
          break;
        }
      }

      setState(() {
        loading = false;
      });

      if (found) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AddProduct()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Invalid Admin Credentials",
              style: AppWidget.whiteTextStyle(18),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Something went wrong",
            style: AppWidget.whiteTextStyle(18),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: const BoxDecoration(
                  color: Color(0xfff7bc3c),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
                child: Column(
                  children: const [
                    SizedBox(height: 50),
                    Text(
                      "Admin Login",
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Manage Complete App",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 4,
                  left: 20,
                  right: 20,
                  bottom: 70,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xfff9faf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Center(
                      child: Text(
                        "Unique Id",
                        style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 30),

                    const Text("User Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    inputField(nameController, "Your User Name"),

                    const SizedBox(height: 30),

                    const Text("Password",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    inputField(passwordController, "Your Password",
                        isPassword: true),

                    const SizedBox(height: 30),

                    GestureDetector(
                      onTap: () {
                        if (nameController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          adminLogin();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xfff7bc3c),
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Center(
                          child: loading
                              ? const CircularProgressIndicator(
                              color: Colors.black)
                              : const Text(
                            "Login Account",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(TextEditingController controller, String hint,
      {bool isPassword = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration:
        InputDecoration(border: InputBorder.none, hintText: hint),
      ),
    );
  }
}
