import 'package:flutter/material.dart';
import 'package:pharmacy_app/widget/Support_Widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      body: Container(
        margin: EdgeInsets.only(top: 50,left: 10),
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Page",style: AppWidget.headlineTextStyle(28),),
              SizedBox(height: 20.0,),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(right: 30.0),
                      decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white),
                      ),child: Image.asset("assets/medicine.png",height: 110,width: 120,fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 20.0,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Paracetamol",style: AppWidget.headlineTextStyle(20),),
                      SizedBox(height: 2.0,),
                      Text("Quantity :"+ "5",style: AppWidget.headlineTextStyle(18),),
                        SizedBox(height: 2.0,),
                        Text("Google",style: AppWidget.headlineTextStyle(18),),
                        SizedBox(height: 2.0,),
                        Text("Total price: "+"\$200",style: AppWidget.headlineTextStyle(18),),
                    ],),
                  ],
                ),


              ),
            ],
          ),
      ),

    );
  }
}
