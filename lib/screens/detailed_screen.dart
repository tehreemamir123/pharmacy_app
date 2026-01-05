import 'package:flutter/material.dart';
import 'package:pharmacy_app/screens/order_screen.dart';
import 'package:pharmacy_app/widget/Support_Widget.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String description;
  final String price;

  const DetailScreen({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.cyanAccent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// BACK BUTTON
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(color: Colors.black, width: 1.2),
                        ),
                        child: const Icon(Icons.arrow_back, size: 20),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// IMAGE
              Image.asset(
                "assets/medicine.png",
                height: MediaQuery.of(context).size.height / 2.9,
              ),

              const SizedBox(height: 20),

              /// DETAILS CARD
              Container(
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 1.2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔹 NAME + QUANTITY (SAME ROW)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: AppWidget.headlineTextStyle(22),
                          ),
                        ),

                        /// 🔹 QUANTITY CONTAINER
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: const Icon(Icons.remove,
                                    color: Colors.white, size: 18),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: const Icon(Icons.add,
                                    color: Colors.white, size: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    /// DESCRIPTION
                    Text("Description",
                        style: AppWidget.lightTextStyle(16)),
                    const SizedBox(height: 8),
                    Text(widget.description,
                        style: AppWidget.lightTextStyle(15)),

                    const SizedBox(height: 22),

                    /// PRICE (WITH QUANTITY)
                    Text("Total Price",
                        style: AppWidget.lightTextStyle(18)),
                    const SizedBox(height: 5),
                    Text(
                      "Rs ${int.parse(widget.price) * quantity}",
                      style: AppWidget.headlineTextStyle(20),
                    ),

                    const SizedBox(height: 15),

                    /// ORDER BUTTON
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child:  Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen()));
                            },
                            child: Text(
                              "Order Now",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
