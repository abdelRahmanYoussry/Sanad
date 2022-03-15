import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final title;
  final textsize;
  final color;
  final page;
  final boldfont;
  final letterspace;
  final overflow;

  const TextView(
      {Key? key,
      @required this.title,
      @required this.textsize,
      @required this.color,
      this.page,
      this.boldfont,
      this.letterspace,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        child: Text(
          title,
          overflow: overflow,
          style: TextStyle(
              color: color,
              fontSize: textsize,
              fontWeight: boldfont,
              letterSpacing: letterspace),
        ),
      ),
    );
  }
}
