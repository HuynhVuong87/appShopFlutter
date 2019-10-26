// import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:myapp/home/productDetail.dart';
import 'dart:math' as math;

import 'package:myapp/model/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageStates createState() => _HomePageStates();
}

class _HomePageStates extends State<HomePage> {
  FocusNode _focus = new FocusNode();

  bool state = false;

  List<Product> items = new List();
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  // StreamSubscription<QuerySnapshot> noteSub;

  @override
  void initState() {
    super.initState();

    items = new List();
    print("this.items");
    // print(this.items);
    // noteSub?.cancel();
    // List<Product> notes = new List();
    // noteSub =
    db.getProductList().listen((QuerySnapshot snapshot) {
      setState(() {
        snapshot.documentChanges.forEach((f) {
          // print(f.type);
          if (f.type.toString().contains("added")) {
            this.items.add(Product.fromMap(f.document.data));
            print("add");
          }
          if (f.type.toString().contains("modified")) {
            print("modified");
            int i = this
                .items
                .indexWhere((data) => data.id == f.document.data['itemid']);
            this.items[i] = Product.fromMap(f.document.data);
          }
          if (f.type.toString().contains("removed")) {
            print("removed");
            int i = this
                .items
                .indexWhere((data) => data.id == f.document.data['itemid']);
            this.items.removeAt(i);
          }
        });
        state = true;
      });
    });

    _focus.addListener(() {
      setState(() {
        _focus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // noteSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget appBar() {
      return SliverAppBar(
          floating: false,
          pinned: true,
          snap: false,
          backgroundColor: Colors.orange,
          title: Container(
            height: 40.0,
            child: TextField(
              textInputAction: TextInputAction.search,
              focusNode: _focus,
              style: TextStyle(fontSize: 16, color: Colors.grey),
              decoration: InputDecoration(
                  focusedBorder: new OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none, width: 0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5.0),
                      )),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
                  prefixIcon: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.grey,
                    size: 21,
                  ),
                  border: new OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none, width: 0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                  hintText: 'Enter a search term',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
          ),
          expandedHeight: 190.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Carousel(
              images: [
                AssetImage('assets/images/ad1.jpg'),
                AssetImage('assets/images/ad3.jpg'),
                AssetImage('assets/images/ad4.jpg'),
              ],
              autoplayDuration: const Duration(milliseconds: 6000),
              autoplay: true,
              animationDuration: Duration(milliseconds: 300),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotColor: Colors.lightGreenAccent,
              indicatorBgPadding: 5.0,
              dotBgColor: Colors.purple.withOpacity(0.5),
              borderRadius: true,
            ),
          ),
          actions: _focus.hasFocus
              ? [
                  MaterialButton(
                    minWidth: 5.0,
                    padding: EdgeInsets.all(0.0),
                    child: Text(
                      "Hủy",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      _focus.unfocus();
                    },
                  )
                ]
              : [
                  IconButton(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.shoppingCart),
                    onPressed: () => {},
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(FontAwesomeIcons.solidCommentDots),
                    onPressed: () => {},
                  )
                ]);
    }

    return new MaterialApp(
        home: new Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                MediaQuery.of(context).viewInsets.bottom +
                6.0),
        child: CustomScrollView(
          slivers: <Widget>[
            appBar(),
            SliverPersistentHeader(
              floating: false,
              pinned: false,
              delegate: _SliverAppBarDelegate(
                minHeight: 60.0,
                maxHeight: 60.0,
                child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    color: Colors.lightBlue,
                    child: Center(child: Text("Sản phẩm"))),
              ),
            ),
            SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 6.0,
                  childAspectRatio: 0.7,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext sliverGridContext, int index) {
                    if (!state) {
                      return Text("Loading");
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute<void>(
                              builder: (BuildContext context) =>
                                  ProductDetail(product: this.items[index],)));
                          // ProductDetail();
                        },
                        child: Container(
                          margin: index % 2 == 0
                              ? EdgeInsets.only(left: 6.0)
                              : EdgeInsets.only(right: 6.0),
                          alignment: Alignment.center,
                          color: Colors.white,
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    child: Image.network(
                                      'https://cf.shopee.vn/file/${items[index].image}',
                                      height: MediaQuery.of(sliverGridContext)
                                                  .size
                                                  .width /
                                              2 -
                                          6.0 -
                                          3,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 15.0, left: 10.0, right: 10.0),
                                      child: Text(
                                        this.items[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              "₫",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 13),
                                            ),
                                            Text(
                                              new FlutterMoneyFormatter(
                                                  amount: (items[index].price /
                                                          10000)
                                                      .toDouble(),
                                                  settings:
                                                      MoneyFormatterSettings(
                                                    symbol: '',
                                                    symbolAndNumberSeparator:
                                                        '',
                                                    fractionDigits: 0,
                                                    thousandSeparator: '.',
                                                  )).output.symbolOnLeft,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: Text(
                                              new FlutterMoneyFormatter(
                                                  amount: items[index]
                                                      .sold
                                                      .toDouble(),
                                                  settings:
                                                      MoneyFormatterSettings(
                                                    symbol: "Đã bán",
                                                    symbolAndNumberSeparator:
                                                        ' ',
                                                    fractionDigits: 1,
                                                    thousandSeparator: ',',
                                                  )).output.compactSymbolOnLeft,
                                              style: TextStyle(fontSize: 11),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              this.items[index].discount != null
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height: 50.0,
                                        width: 50.0,
                                        child: ClipPath(
                                          clipper: TrapeziumClipper(),
                                          child: Container(
                                            padding: EdgeInsets.only(top: 3.0),
                                            color: Colors.yellow[600],
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                    "${this.items[index].discount}",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 4.0),
                                                  child: Text("GIẢM",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  childCount: items.length,
                )),
          ],
        ),
      ),
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, size.height * 7 / 8);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
