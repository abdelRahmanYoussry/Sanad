import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight fontWeight;
  Color? colors;

  CustomText({
    Key? key,
    required this.title,
    required this.size,
    required this.fontWeight,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: GoogleFonts.poppins(
            color: colors, fontSize: size, fontWeight: fontWeight));
  }
}
