import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/utils/store.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/cart.dart';

class AddToCart extends StatelessWidget {

  final Item catalogItem;
  AddToCart(
      {Key? key,
        required this.catalogItem
      }) : super(key: key);

  Widget build(BuildContext context){
    VxState.watch(context, on: [AddMutation,RemoveMutation]);
    final Cart _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(catalogItem);
    return ElevatedButton(
        onPressed: (){
          if(!isInCart){
           AddMutation(catalogItem);
            // setState(() {});
          }
        },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MyTheme.primaryGreen),
          shape: MaterialStateProperty.all(
            StadiumBorder(),
          )),
        child: isInCart ?
        Icon(Icons.done,color: Colors.white) :
        Icon(Icons.add_shopping_cart_rounded,color: Colors.white),
    );
  }
  //   final Cart _cart = (VxState.store as MyStore).cart;
  //   bool isInCart = _cart.items.contains(catalogItem) ?? false;
  //   return ElevatedButton(
  //     onPressed: () {
  //       if (!isInCart) {
  //         AddMutation(catalogItem);
  //       }
  //     },
  //     style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor),
  //         shape: MaterialStateProperty.all(
  //           StadiumBorder(),
  //         )),
  //     child: isInCart ? Icon(Icons.done) : Icon(CupertinoIcons.cart_badge_plus),
  //   );
  // }
}