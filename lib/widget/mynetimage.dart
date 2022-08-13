import 'package:flutter/material.dart';

class MyNetImage extends StatelessWidget {
  double height;
  double width;
  String imagePath;
  // ignore: prefer_typing_uninitialized_variables
  var fit;
  // var alignment;

  MyNetImage(
      {Key? key,
      required this.width,
      required this.height,
      required this.imagePath,
      // this.alignment,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(imagePath.toString()),
      height: height,
      width: width,
      fit: fit,
    );
  }
}
