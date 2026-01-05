

  import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future addUserInfo (Map<String, dynamic> userInfoMap, String id){
    return FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);

  }
  Future addProduct (Map<String, dynamic> productInfoMap){
    return FirebaseFirestore.instance.collection("product").add(productInfoMap);
  }
  Future<Stream<QuerySnapshot>>getallProducts(String category)async{
    return await FirebaseFirestore.instance.collection("product").where("category",isEqualTo: category).snapshots();
  }


}