import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home_widgets/add_to_cart.dart';

class HomeDetailPage extends StatelessWidget {
  final Product catalog;
  const HomeDetailPage({Key? key,required this.catalog}) :
        assert (catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceBetween,
        buttonPadding: EdgeInsets.zero,
        children: [
          "₹${catalog.price}".text.bold.xl4.make(),
          AddToCart(catalogItem :catalog)
        ],
      ).p32(),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            catalog.name.text.xl4.color(Colors.redAccent).bold.make(),
            Hero(
              tag: Key(catalog.id.toString()),
                child: Image.network('https://sushuruta-backend.onrender.com${catalog.image}')
            ).h32(context),
            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.convey,
                edge: VxEdge.top,
                child: Container(
                  width: context.screenWidth,
                  padding: Vx.mV64,
                  color: MyTheme.creamColor,
                  child: Column(
                    children: [
                      catalog.desc.text.xl.textStyle(context.captionStyle).make(),
                    ],
                  ),
                  ),
              ),
              ),
          ],
        )
      ),
    );
  }

}