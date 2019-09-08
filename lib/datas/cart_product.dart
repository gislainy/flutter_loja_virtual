import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_loja_virtual/datas/product_data.dart';

class CartProduct {

  String cardId;

  String categoryId;

  String productId;

  int quantity;
  String size;

  ProductData productData;
  CartProduct();

  CartProduct.fromDocument(
      DocumentSnapshot document
  ) {
    cardId = document.documentID;
    categoryId = document.data["categoryId"];
    productId = document.data["productId"];
    quantity = document.data["quantify"];
    size = document.data["size"];
  }

  Map<String, dynamic> toMap() {
    return {
      "categoryId": categoryId,
      "productId": productId,
      "quantity": quantity,
      "size": size,
     // "product": productData.toResumeMap()
    };
  }

}