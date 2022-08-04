// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  String? title;
  double? size;
  var maxline, fontstyle, fontWeight, textalign;
  Color? colors;
  var overflow;

  MyText(
      {Key? key,
      required this.title,
      this.colors,
      this.size,
      this.maxline,
      this.overflow,
      this.textalign,
      this.fontWeight,
      this.fontstyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      textAlign: textalign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxline,
      style: GoogleFonts.inter(
          fontSize: size,
          fontStyle: fontstyle,
          color: colors,
          fontWeight: fontWeight),
    );
  }
}
