import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({Key? key, this.image, this.imageScale}) : super(key: key);
  final double? imageScale;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return image != null && image != ""
        ? FadeInImage.assetNetwork(
            alignment: Alignment.bottomCenter,
            placeholderFit: BoxFit.fill,
            imageScale: imageScale ?? 1,
            placeholder: "assets/images/pokeball_placeholder.png",
            fit: BoxFit.fill,
            image: image!,
          )
        : Image.asset(
            "assets/images/pokeball_placeholder.png",
            scale: imageScale ?? 0,
          );
  }
}
