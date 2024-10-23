import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class CatalogueModel{
  static List<Product> items = [
  ];

  static Future<void> fetchData() async{
    await Future.delayed(Duration(seconds: 2));
    var catalog = await rootBundle.loadString("assets/files/catalog.json");
    var decodedData = jsonDecode(catalog);
    var productData = decodedData["products"];

    // var url = Uri.parse("https://sushuruta-backend.onrender.com/api/items");
    // var response = await http.get(url);
    // var catalog = response.body;
    // var decodedData = jsonDecode(catalog);
    // var productData = decodedData["menuItems"];
    CatalogueModel.items = List.from(productData)
        .map<Product>((item) => Product.fromMap(item))
        .toList();
  }

  // Get Item by ID
  Product getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Product getByPosition(int pos) => items[pos];
}

class Product{
  final int id;
  final String name;
  final String desc;
  final String price;
  final String image;

  Product({required this.id,required this.name,required this.desc,required this.price,required this.image});

  factory Product.fromMap(Map<String,dynamic> mpp){
    return Product(
        id: mpp["id"],
        name: mpp["name"],
        desc: mpp["size"],
        price: mpp["price"],
        image: mpp["image"]
    );
  }
    toMap() => {
      "id" : id,
      "name" : name,
      "size" : desc,
      "price" : price,
      "image" : image,
    };
  @override
  String toString() {
    return 'Item(id: $id, name: $name, desc: $desc, price: $price, image: $image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product &&
        o.id == id &&
        o.name == name &&
        o.desc == desc &&
        o.price == price &&
        o.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    desc.hashCode ^
    price.hashCode ^
    image.hashCode;
  }
}