import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loja_virtual/datas/product_data.dart';
import 'package:flutter_loja_virtual/tiles/product_tile.dart';

class ProductsSreen extends StatelessWidget {
  final DocumentSnapshot product;

  ProductsSreen(this.product);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(product.data['title']),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list))
              ],
            ),
          ),
          body: FutureBuilder(
              future: Firestore.instance
                  .collection("products")
                  .document(product.documentID)
                  .collection('items')
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  /*return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[Container(), Container()]);
                      */
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      GridView.builder(
                          padding: EdgeInsets.all(4.0),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                childAspectRatio: 0.65
                              ),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                            data.category = this.product.documentID;
                            return ProductTile("grid", data);
                          }),
                      ListView.builder(
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            ProductData data = ProductData.fromDocument(snapshot.data.documents[index]);
                            data.category = this.product.documentID;
                            return ProductTile("list", data);
                          }),
                    ],
                  );
                }
              })),
    );
  }
}
