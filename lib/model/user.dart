
class User {
  static int id;
  static String name;
  static String image;
  static String url;

  // Product(this._id, this._name, this._image, this._description, this._price);

  // Product.map(dynamic obj) {
  //   this._id = obj['itemid'];
  //   this._name = obj['name'];
  //   this._image = obj['image'];
  //   this._price = obj['price'];
  //   this._sold = obj['sold'];
  //   this._description = obj['description'];
  // }

  // Map<String, dynamic> toMap() {
  //   var map = new Map<String, dynamic>();
  //   if (_id != null) {
  //     map['itemid'] = _id;
  //   }
  //   map['name'] = _name;
  //   map['image'] = _image;
  //   map['description'] = _description;

  //   return map;
  // }

  User.fromMap(Map<String, dynamic> map) {
    id = map['itemid'];
    name = map['name'];
    image = map['image'];
    url = map[url];
  }
}