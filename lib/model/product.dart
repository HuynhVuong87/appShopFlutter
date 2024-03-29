import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int _id;
  String _name;
  String _image;
  List<dynamic> _imageList;
  List<dynamic> _attributes;
  int _price;
  int _priceBeforeDiscount;
  int _sold;
  int _stock;
  String _discount;
  double _rating;
  String _description;

  // Product(this._id, this._name, this._image, this._description, this._price);

  // Product.map(dynamic obj) {
  //   this._id = obj['itemid'];
  //   this._name = obj['name'];
  //   this._image = obj['image'];
  //   this._price = obj['price'];
  //   this._sold = obj['sold'];
  //   this._description = obj['description'];
  // }

  int get id => _id;
  String get name => _name;
  String get image => _image;
  List<dynamic> get imageList => _imageList;
  List<dynamic> get attributes => _attributes;
  int get price => _price;
  int get priceBeforeDiscount => _priceBeforeDiscount;
  int get sold => _sold;
  int get stock => _stock;
  String get discount => _discount;
  double get rating => _rating;
  String get description => _description;

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

  Product.fromMap(Map<String, dynamic> map) {
    this._id = map['itemid'];
    this._name = map['name'];
    this._image = map['image'];
    this._imageList = map['image_list'];
    this._attributes = map['attributes'];
    this._price = map['price'];
    this._priceBeforeDiscount = map['price_before_discount'];
    this._sold = map['sold'];
    this._stock = map['stock'];
    this._discount = map['discount'];
    this._rating = double.parse(map['rating_star'].toString());
    this._description = map['description'];
  }
}

final CollectionReference productCollection =
    Firestore.instance.collection('sp_product');

class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
      new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  // Future<Product> createProduct(
  //     String name, String image, String description, int price) async {
  //   final TransactionHandler createTransaction = (Transaction tx) async {
  //     final DocumentSnapshot ds = await tx.get(productCollection.document());

  //     final Product product =
  //         new Product(ds.data['itemid'], name, image, description, price);
  //     final Map<String, dynamic> data = product.toMap();

  //     await tx.set(ds.reference, data);

  //     return data;
  //   };

  //   return Firestore.instance.runTransaction(createTransaction).then((mapData) {
  //     return Product.fromMap(mapData);
  //   }).catchError((error) {
  //     print('error: $error');
  //     return null;
  //   });
  // }

  Stream<QuerySnapshot> getProductList() {
    Stream<QuerySnapshot> snapshots = productCollection.limit(6).snapshots();
    return snapshots;
  }

  // Future<dynamic> updateProduct(Product product) async {
  //   final TransactionHandler updateTransaction = (Transaction tx) async {
  //     final DocumentSnapshot ds =
  //         await tx.get(productCollection.document("${product.id}"));

  //     await tx.update(ds.reference, product.toMap());
  //     return {'updated': true};
  //   };

  //   return Firestore.instance
  //       .runTransaction(updateTransaction)
  //       .then((result) => result['updated'])
  //       .catchError((error) {
  //     print('error: $error');
  //     return false;
  //   });
  // }

  Future<dynamic> deleteProduct(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(productCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
