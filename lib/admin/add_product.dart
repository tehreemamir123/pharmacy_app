import 'package:flutter/material.dart';
import 'package:pharmacy_app/services/database.dart';
import 'package:pharmacy_app/widget/Support_Widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  // CONTROLLERS
  final TextEditingController productnamecontroller = TextEditingController();
  final TextEditingController productpricecontroller = TextEditingController();
  final TextEditingController companynamecontroller = TextEditingController();
  final TextEditingController desccontroller = TextEditingController();

  final List<String> productCategory = [
    'Suppliment',
    'Medicines',
    'Herbal',
    'Vitamins',
  ];

  String? selectedCategory;

  @override
  void dispose() {
    productnamecontroller.dispose();
    productpricecontroller.dispose();
    companynamecontroller.dispose();
    desccontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [

            // TOP PART
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
                    "Add Product",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Manage Complete App",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // FORM CARD
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 6,
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

                  _title("Product Name"),
                  _inputField("Product Name", productnamecontroller),

                  const SizedBox(height: 20),

                  _title("Product Price"),
                  _inputField(
                    "Product Price",
                    productpricecontroller,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 20),

                  _title("Product Category"),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      hint: const Text("Select Category"),
                      isExpanded: true,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down),
                      items: productCategory.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  _title("Company Name"),
                  _inputField("Company Name", companynamecontroller),

                  const SizedBox(height: 10),

                  _title("Product Description"),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: TextField(
                      controller: desccontroller,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write something about product...",
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  GestureDetector(
                    onTap: () async {
                      if (
                      productnamecontroller.text.isNotEmpty &&
                          productpricecontroller.text.isNotEmpty &&
                          companynamecontroller.text.isNotEmpty &&
                          desccontroller.text.isNotEmpty &&
                          selectedCategory != null
                      ) {

                        Map<String, dynamic> addProduct = {
                          "name": productnamecontroller.text,
                          "price": double.parse(productpricecontroller.text),
                          "category": selectedCategory,
                          "description": desccontroller.text,
                          "companyName": companynamecontroller.text,
                        };

                        await DatabaseMethods().addProduct(addProduct);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Product added successfully!",
                              style: AppWidget.whiteTextStyle(18),
                            ),
                          ),
                        );

                        // clear fields
                        productnamecontroller.clear();
                        productpricecontroller.clear();
                        companynamecontroller.clear();
                        desccontroller.clear();
                        setState(() => selectedCategory = null);

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              "Please fill all fields",
                              style: AppWidget.whiteTextStyle(18),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xfff7bc3c),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: const Center(
                        child: Text(
                          "Add Product",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _inputField(
      String hint,
      TextEditingController controller, {
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}
