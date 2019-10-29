import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetService {
  static Widget discount({double height, double width, String discount}) {
    return Container(
      height: height,
      width: width,
      child: ClipPath(
        clipper: TrapeziumClipper(),
        child: Container(
          padding: EdgeInsets.only(top: 3.0),
          color: Colors.yellow[600],
          child: Column(
            children: <Widget>[
              Text(discount,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500)),
              Container(
                padding: EdgeInsets.only(top: 4.0),
                child: Text("GIẢM",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget starRating({@required double rating, double size}) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int nguyen = (rating).toInt();
        int thapphan = (rating * 10).toInt() % 10;
        // print(index);
        return Icon(
          index < rating.toInt()
              ? Icons.star
              : (index == nguyen
                  ? (thapphan < 5 ? Icons.star_border : Icons.star_half)
                  : Icons.star_border),
          color: Colors.yellow,
          size: size,
        );
      }),
    );
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
