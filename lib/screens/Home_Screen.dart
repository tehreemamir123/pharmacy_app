import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/detailed_screen.dart';
import 'package:pharmacy_app/services/database.dart';
import 'package:pharmacy_app/widget/Support_Widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool allMedicine = true;
  bool supplement = false;
  bool vitamin = false;
  bool herbal = false;

  String selectedCategory = "Medicines";
  Stream<QuerySnapshot>? productStream;

  final TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  loadProducts() async {
    productStream =
    await DatabaseMethods().getallProducts(selectedCategory);
    setState(() {});
  }

  /// 🔥 IMAGE LOGIC (same as before)
  String getProductImage(String name, String category) {
    final n = name.toLowerCase();
    final c = category.toLowerCase();

    if (n.contains("cold") || n.contains("flu")) {
      return "assets/kit.png";
    }
    if (c == "medicines") return "assets/medicine.png";
    if (c == "suppliment" || c == "supplement") {
      return "assets/supplement.png";
    }
    if (c == "vitamin" || c == "vitamins") {
      return "assets/vitamic.png";
    }
    if (c == "herbal") return "assets/herbal.png";

    return "assets/kit.png";
  }

  /// 🔍 PRODUCTS + SEARCH FILTER
  Widget allProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: productStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs.where((doc) {
          final name = doc["name"].toString().toLowerCase();
          final company = doc["companyName"].toString().toLowerCase();
          final category = doc["category"].toString().toLowerCase();

          return name.contains(searchText) ||
              company.contains(searchText) ||
              category.contains(searchText);
        }).toList();

        if (docs.isEmpty) {
          return const Center(child: Text("No products found"));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final ds = docs[index];

            return medicineCard(
              context,
              image: getProductImage(ds["name"], ds["category"]),
              name: ds["name"],
              company: ds["companyName"],
              price: ds["price"].toString(),
              description: ds["description"],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// PROFILE
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/hijab.jpg",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 20),
                Text("Tehreem Fatima",
                    style: AppWidget.headlineTextStyle(20)),

                const SizedBox(height: 10),
                Text("Your Trusted",
                    style: AppWidget.headlineTextStyle(26)),
                Text("Online Pharmacy",
                    style: AppWidget.lightTextStyle(28)),

                const SizedBox(height: 30),

                /// 🔍 SEARCH (NOW WORKING 🔥)
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color:  Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchText = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Medicine...",
                      hintStyle: AppWidget.lightTextStyle(18),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.search,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// CATEGORIES (same)
                SizedBox(
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      allMedicine
                          ? AppWidget.selectedCategory("All Medicines")
                          : categoryButton("All Medicines", () {
                        selectedCategory = "Medicines";
                        allMedicine = true;
                        supplement = vitamin = herbal = false;
                        loadProducts();
                      }),
                      const SizedBox(width: 20),
                      supplement
                          ? AppWidget.selectedCategory("Suppliment")
                          : categoryButton("Suppliment", () {
                        selectedCategory = "Suppliment";
                        supplement = true;
                        allMedicine = vitamin = herbal = false;
                        loadProducts();
                      }),
                      const SizedBox(width: 20),
                      vitamin
                          ? AppWidget.selectedCategory("Vitamin")
                          : categoryButton("Vitamin", () {
                        selectedCategory = "Vitamins";
                        vitamin = true;
                        allMedicine = supplement = herbal = false;
                        loadProducts();
                      }),
                      const SizedBox(width: 20),
                      herbal
                          ? AppWidget.selectedCategory("Herbal")
                          : categoryButton("Herbal", () {
                        selectedCategory = "Herbal";
                        herbal = true;
                        allMedicine = supplement = vitamin = false;
                        loadProducts();
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                allProducts(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryButton(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title, style: AppWidget.lightTextStyle(18)),
    );
  }

  /// CARD (same)
  Widget medicineCard(
      BuildContext context, {
        required String image,
        required String name,
        required String company,
        required String price,
        required String description,
      }) {
    final bool isKit =
        name.toLowerCase().contains("cold") ||
            name.toLowerCase().contains("flu");

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(
              name: name,
              description: description,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        height: 300,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Color(0xffddd7cd),
              Colors.white,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                image,
                height: isKit ? 260 : 220,
              ),
            ),
            Positioned(
              bottom: 8,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:  Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: AppWidget.whiteTextStyle(18)),
                        Text(company,
                            style: AppWidget.whiteTextStyle(14)),
                      ],
                    ),
                    Text("Rs $price",
                        style: AppWidget.whiteTextStyle(18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
