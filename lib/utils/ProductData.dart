import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/catalog.dart';

class ProductsData{
  static final ProductsData _instance = ProductsData._internal();
  static var catalog;

  ProductsData._internal();

  factory ProductsData(){
    return _instance;
  }

  bool _hasFetchedData = false; // To track if data is already fetched

  Future<void> fetchData() async {
    if (!_hasFetchedData) {
      var url = Uri.parse("https://sushuruta-backend.onrender.com/api/items");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var catalog = response.body;
        var decodedData = jsonDecode(catalog);
        var productData = decodedData["menuItems"];

        // Step 5: Store the fetched data in CatalogueModel
        CatalogueModel.items = List.from(productData)
            .map<Product>((item) => Product.fromMap(item))
            .toList();

        _hasFetchedData = true;  // Mark data as fetched
      } else {
        throw Exception("Failed to load data");
      }
    }
  }
  // Accessing the stored data
  List<Product>? get catalogItems => CatalogueModel.items;
}