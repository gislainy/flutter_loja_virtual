import 'package:flutter/material.dart';
import 'package:flutter_loja_virtual/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text("Tamanhos",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
                SizedBox(
                    height: 34.0,
                    child: GridView(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5,
                      ),
                      children: product.sizes.map((size) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              this.size = size;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                color: this.size == size ? primaryColor : null,
                                border: Border.all(
                                    color: this.size == size
                                        ? primaryColor
                                        : Colors.grey[500],
                                    width: 2.0)),
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: TextStyle(
                                color: this.size == size
                                    ? Colors.white
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                SizedBox(height: 16.0),
                SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: size != null ? () {} : null,
                      color: primaryColor,
                      child: Text(
                        "ADICIONAR AO CARRINHO",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    )),
                SizedBox(height: 16.0),
                Text("Descrição",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
                Text(product.description, style: TextStyle(fontSize: 16.0),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
