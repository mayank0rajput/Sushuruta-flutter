import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/cart.dart';
import '../models/catalog.dart';
import '../utils/store.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Cart".text.make(),
      ),
      body: Column(
        children: [
         _CartList().p32().expand(),
          Divider(),
          _CartTotal()
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final Cart _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxBuilder(
            mutations: {RemoveMutation},
            builder: (context,store,status){
              return "\$${_cart.totalPrice}"
                  .text.xl4.make();},
             ),
          30.widthBox,
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(MyTheme.darkBluishColor)),
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: "Buying not supported yet.".text.make(),
                ));
              },
              child: "Buy".text.color(Colors.white).make()
          )
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final Cart _cart = (VxState.store as MyStore).cart;
    return _cart.items.isEmpty ?
        "Nothing to show".text.xl3.makeCentered():
        ListView.builder(
        itemCount: _cart.items?.length,
           itemBuilder: (context,index) => ListTile(
             leading: Icon(Icons.done),
             trailing: IconButton(
               icon: Icon(Icons.remove_circle_outline),
               onPressed: () {
                 RemoveMutation(_cart.items[index]);
               },
              ),
             title: _cart.items[index].name.text.make(),
         ),
     );
  }
}