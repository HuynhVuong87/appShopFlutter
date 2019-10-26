import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/model/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({Key key, @required this.product}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProductDetailPage(this.product);
  }
}

class ProductDetailPage extends State<ProductDetail> {
  final Product product;

  ProductDetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Text(product.name),
    );
  }
}
