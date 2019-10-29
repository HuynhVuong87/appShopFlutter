import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/model/product.dart';
import 'package:myapp/widget-service/widget-service.dart';

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

  int imageIndex = 1;
  bool readmore = false;
  ProductDetailPage(this.product);
  List<Widget> nameAttribute = new List();
  List<Widget> valueAttribute = new List();
  List<NetworkImage> image = new List();

  @override
  void initState() {
    super.initState();
    this.product.imageList.forEach((f) {
      setState(() {
        image.add(NetworkImage("https://cf.shopee.vn/file/" + f.toString()));
      });
    });
    if (this.product.stock != null) {
      nameAttribute.add(Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text("Kho"),
      ));
      valueAttribute.add(Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(this.product.stock.toString()),
      ));
    }
    this.product.attributes.forEach((f) {
      nameAttribute.add(Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(f['name'].toString()),
      ));
      valueAttribute.add(Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(f['value'].toString()),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(this.product.name);

    return MaterialApp(
      home: new Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          // color: Colors.white,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                floating: false,
                pinned: true,
                snap: false,
                backgroundColor: Colors.orange,
                // leading: Icon(Icons.backspace),
                // automaticallyImplyLeading: true,
                title: Text('${this.product.name}'),
                expandedHeight: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).padding.top,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Carousel(
                        showIndicator: false,
                        autoplay: false,
                        onImageChange: (current, chang) {
                          setState(() {
                            imageIndex = chang + 1;
                          });
                        },
                        images: this.image,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0x8fdddddd),
                              border:
                                  Border.all(color: Colors.black26, width: 0.5),
                              borderRadius: BorderRadius.circular(50)),
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Text(
                            '${imageIndex.toString()}/${this.image.length}',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
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
                ],
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                '${this.product.name}',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          this.product.discount != null
                              ? Container(
                                  alignment: Alignment.topCenter,
                                  child: WidgetService.discount(
                                      // width: 50,
                                      // height: 50,
                                      discount: this.product.discount),
                                )
                              : Container()
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            new FlutterMoneyFormatter(
                                amount: (this.product.price / 10000).toDouble(),
                                settings: MoneyFormatterSettings(
                                  symbol: '₫',
                                  symbolAndNumberSeparator: '',
                                  fractionDigits: 0,
                                  thousandSeparator: '.',
                                )).output.symbolOnLeft,
                            style: TextStyle(fontSize: 17, color: Colors.red),
                          ),
                          Text(
                            new FlutterMoneyFormatter(
                                amount:
                                    (this.product.priceBeforeDiscount / 10000)
                                        .toDouble(),
                                settings: MoneyFormatterSettings(
                                  symbol: '₫',
                                  symbolAndNumberSeparator: '',
                                  fractionDigits: 0,
                                  thousandSeparator: '.',
                                )).output.symbolOnLeft,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          WidgetService.starRating(
                              rating: this.product.rating.toDouble()),
                          Text(
                            new FlutterMoneyFormatter(
                                amount: (this.product.rating),
                                settings: MoneyFormatterSettings(
                                  symbol: '',
                                  fractionDigits: 1,
                                  thousandSeparator: '.',
                                )).output.symbolOnLeft,
                            style: TextStyle(
                                // fontSize: 13,
                                // color: Colors.grey[600]
                                ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 10.0),
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                  border: Border(left: BorderSide(width: 0.8))),
                              child: Text(
                                  "Đã bán ${this.product.sold.toString()}"),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                            alignment: AlignmentDirectional.centerEnd,
                            padding: EdgeInsets.all(0),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Thông tin sản phẩm",
                          style: TextStyle(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(width: 1),
                                bottom: BorderSide(width: 1))),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 15),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: nameAttribute,
                            ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: valueAttribute,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          this.product.description,
                          maxLines: readmore ? null : 4,
                        ),
                      ),
                      MaterialButton(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        shape: Border(top: BorderSide(width: 1)),
                        textColor: Colors.red,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: readmore
                              ? [Text("Thu gọn"), Icon(Icons.expand_less)]
                              : [Text("Xem thêm"), Icon(Icons.expand_more)],
                        ),
                        onPressed: () {
                          setState(() {
                            readmore = !readmore;
                          });
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.green,
          // margin: EdgeInsets.all(0),
          // padding: EdgeInsets.all(0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(FontAwesomeIcons.commentDots),
                        onPressed: () {},
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                                    width: 1, color: Colors.grey[800]))),
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: MaterialButton(
                    child: Text(
                      "Mua ngay",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
