import 'dart:convert';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:http/http.dart' as http;
import '../models/CartItem.dart';

Future<void> main() async {
  await CatalogueModel.fetchData();
  List<CartItem> items;
  const url = 'http://localhost:8000/api/confirm';
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({"orderStatement": "ehbhfj"}),
  );

  if (response.statusCode == 200) {
    final resBody = jsonDecode(response.body);
    var apiItems = resBody["items"];
    items = List.from(apiItems)
        .map<CartItem>((item) => CartItem.fromJson(item))
        .toList();
    items.forEach((element) {
      var temp = "Id is ${element.itemId} and quantitiy is ${element.quantity}";
      print(temp);
      print(CatalogueModel().getById(element.itemId));
    }
    );
  }
}