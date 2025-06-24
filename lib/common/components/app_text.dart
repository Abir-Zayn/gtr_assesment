import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double textfontsize;
  final Color? color;
  final String fontFamily;
  final TextAlign? textAlign;
  final bool softwrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontWeight? fontWeight;
  const AppText({
    super.key,
    required this.text,
    required this.textfontsize,
    this.color,
    this.fontFamily = 'Nunito',
    this.textAlign,
    this.softwrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: softwrap,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.getFont(
        fontFamily,
        fontSize: textfontsize,
        color: color ?? Theme.of(context).textTheme.bodyLarge?.color,
        fontWeight: fontWeight,
      ),
    );
  }
}
