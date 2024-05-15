import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogImage extends StatelessWidget{
  final String image;
  CatalogImage({required this.image,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Image.asset(image,fit: BoxFit.fill).box
       .rounded
       .height(context.isMobile? 200: 300)
       .color(MyTheme.creamColor)
       .make()
       .wPCT(context: context, widthPCT: context.isMobile ? 40 : 20);
  }
}