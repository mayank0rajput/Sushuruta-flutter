import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/pages/home_widgets/catalog_image.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/cart.dart';
import '../models/catalog.dart';
import '../utils/store.dart';

class CartPage extends StatelessWidget {

  List<Product> items = CatalogueModel.items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [_CartList().p16().expand(), Divider(), _CartTotal()],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Cart _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxBuilder(
            mutations: {RemoveMutation},
            builder: (context, store, status) {
              return "₹${_cart.totalPrice}".text.xl4.make();
            },
          ),
          30.widthBox,
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(MyTheme.primaryGreen)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: "Buying not supported yet.".text.make(),
                ));
              },
              child: "Buy".text.color(Colors.white).make())
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var temp = new CatalogueModel(); // for debugging
    AddMutation(temp.getById(2)); // for debugging
    VxState.watch(context, on: [RemoveMutation]);
    final Cart _cart = (VxState.store as MyStore).cart;
    return _cart.items.isEmpty
        ? "Nothing to show".text.xl3.makeCentered()
        : ListView.builder(
            itemCount: _cart.items?.length,
            itemBuilder: (context, index) => ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                          child: Image.asset(_cart.items[index].image.toString().substring(1)).box.make(),
                      )
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _cart.items[index].name.text.make(),
                      _cart.items[index].desc.text.make(),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Quantity"),
                      Row(
                        children: [
                          Text("${_cart.getQuantity(_cart.items[index])}"),
                        ]
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
