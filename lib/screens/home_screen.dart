import 'package:flutter/material.dart';
import 'package:flutter_loja_virtual/tab/home_tab.dart';
import 'package:flutter_loja_virtual/tab/products_tab.dart';
import 'package:flutter_loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Container(color: Colors.blue),
        Container(color: Colors.red),
      ],
    );
  }
}
