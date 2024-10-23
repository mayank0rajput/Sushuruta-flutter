import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogImage extends StatelessWidget{
  final String image;
  CatalogImage({required this.image,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var imageUrl = "https://sushuruta-backend.onrender.com" + image;
    return Image.network(
      imageUrl,
      fit: BoxFit.fill,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          // The image has finished loading, return the image with VelocityX styling
          return child.box
              .rounded
              .height(context.isMobile ? 200 : 300)
              .color(MyTheme.creamColor)
              .make()
              .wPCT(context: context, widthPCT: context.isMobile ? 40 : 20);
        } else {
          // Show a placeholder (or any widget) while the image is loading
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        // Return an error widget if the image fails to load
        return Text(error.toString());
      },
    );
  }
}