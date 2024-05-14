import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/pages/home_detail.dart';
import 'package:flutter_application_1/pages/home_widgets/add_to_cart.dart';
// import 'package:flutter_application_1/pages/home_detail_page.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/catalog.dart';
import 'catalog_image.dart';

class CatalogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogueModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogueModel.items[index];
        return InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeDetailPage(catalog: catalog)
          )
          ),
          child: CatalogItem(catalogItem: catalog),
        );
      },
    );
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalogItem;

  const CatalogItem({Key? key, required this.catalogItem})
      : assert(catalogItem != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Hero(
            tag: Key(catalogItem.id.toString()),
            child: CatalogImage(
              image: catalogItem.image.toString(),
            ),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  catalogItem.name.text.lg.color(MyTheme.darkBluishColor).bold.make(),
                  catalogItem.desc.text.textStyle(context.captionStyle).make(),
                  10.heightBox,
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      "\$${catalogItem.price}".text.bold.xl.make(),
                      AddToCart(catalogItem: catalogItem)
                    ],
                  ).pOnly(right: 8.0)
                ],
              ))
        ],
      ),
    ).white.rounded.square(150).make().py16();
  }
}