import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_virtual/datas/cart_product.dart';
import 'package:flutter_loja_virtual/models/user_model.dart';
import "package:scoped_model/scoped_model.dart";

class CartModel extends Model {
  UserModel user;

  List<CartProduct> products = [];

  CartModel(this.user);

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cardId = doc.documentID;
      products.add(cartProduct);
      notifyListeners();
    });
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("items").document(cartProduct.cardId).delete();
    products.remove(cartProduct);
    notifyListeners();
  }
}
