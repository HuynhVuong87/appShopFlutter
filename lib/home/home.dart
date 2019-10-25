import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageStates createState() => _HomePageStates();
}

class _HomePageStates extends State<HomePage> {
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {
        _focus.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actionIcon() {
      if (_focus.hasFocus) {
        return [
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
        ];
      } else {
        return [
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
        ];
      }
    }

    return new MaterialApp(
        home: new Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.grey[300],
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
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
                              borderSide:
                                  BorderSide(style: BorderStyle.none, width: 0),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(5.0),
                              )),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5.0),
                          prefixIcon: Icon(
                            FontAwesomeIcons.search,
                            color: Colors.grey,
                            size: 21,
                          ),
                          border: new OutlineInputBorder(
                            borderSide:
                                BorderSide(style: BorderStyle.none, width: 0),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                          ),
                          hintText: 'Enter a search term',
                          hintStyle:
                              TextStyle(fontSize: 16, color: Colors.grey)),
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
                  actions: actionIcon(),
                ),
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
                      (BuildContext context, int index) {
                        return Container(
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
                                      'https://cbu01.alicdn.com/img/ibank/2018/220/168/9350861022_759254113.400x400.jpg',
                                      height:
                                          MediaQuery.of(context).size.width /
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
                                        "Túi chườm nóng Túi chườm nóng Túi chườm nóng Túi chườm nóng",
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
                                        Expanded(
                                          child: Text(
                                            new FlutterMoneyFormatter(
                                                amount: 150000,
                                                settings:
                                                    MoneyFormatterSettings(
                                                  symbol: "₫",
                                                  symbolAndNumberSeparator: '',
                                                  fractionDigits: 0,
                                                  thousandSeparator: '.',
                                                )).output.symbolOnLeft,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.red),
                                          ),
                                        ),
                                        Text(
                                          "Đã bán 997",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  child: ClipPath(
                                    clipper: TrapeziumClipper(),
                                    child: Container(
                                      color: Colors.yellow[600],
                                      child: Column(
                                        children: <Widget>[
                                          Text("50%"),
                                          Text("GIẢM")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 30,
                    )),
              ],
            )));
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
    path.lineTo(size.width/2, size.height*7/8);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}
