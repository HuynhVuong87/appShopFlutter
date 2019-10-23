import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_pro/carousel_pro.dart';

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
            resizeToAvoidBottomPadding: true,
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
                SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 4.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.teal[100 * (index % 9)],
                          child: Text('Grid Item $index'),
                        );
                      },
                      childCount: 30,
                    )),
              ],
            )));
  }
}
