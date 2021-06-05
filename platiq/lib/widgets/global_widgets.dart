import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:platiq/globals.dart';

class TitleText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final TextDecoration? decoration;
  final List<Shadow>? shadows;
  final bool extraBold;

  const TitleText(this.text,
      {Key? key,
      this.maxLines,
      this.fontSize,
      this.fontWeight,
      this.fontFamily,
      this.textOverflow,
      this.textAlign,
      this.color,
      this.decoration,
      this.shadows,
      this.extraBold = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          color: color,
          fontFamily: fontFamily != null
              ? fontFamily
              : extraBold
                  ? GoogleFonts.montserrat(fontWeight: FontWeight.bold)
                      .fontFamily
                  : null,
          fontSize: fontSize ?? 20,
          fontWeight: fontWeight ?? FontWeight.bold,
          shadows: shadows),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final TextDecoration? decoration;
  final List<Shadow>? shadows;
  final bool extraBold;

  const SubtitleText(this.text,
      {Key? key,
      this.maxLines,
      this.fontSize,
      this.fontWeight,
      this.fontFamily,
      this.textOverflow,
      this.textAlign,
      this.color,
      this.decoration,
      this.shadows,
      this.extraBold = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        color: color != null
            ? color
            : Theme.of(context).brightness == Brightness.light
                ? GlobalValues.fontColorDark
                : GlobalValues.fontColorLight,
        fontFamily: fontFamily != null
            ? fontFamily
            : extraBold
                ? GoogleFonts.montserrat(fontWeight: FontWeight.w900).fontFamily
                : null,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        shadows: shadows,
      ),
    );
  }
}

class SemiCircularButton extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double? height, width;
  final Function() onPressed;
  final Function()? onLongPressed;
  final bool isLoading, isRotated;

  const SemiCircularButton(
      {Key? key,
      this.color,
      required this.child,
      this.height,
      this.width,
      required this.onPressed,
      this.onLongPressed,
      this.isLoading = false,
      this.isRotated = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin:
          isLoading ? EdgeInsets.symmetric(horizontal: 40.0) : EdgeInsets.zero,
      duration: Duration(milliseconds: 500),
      height: height,
      width: isLoading ? height : width,
      decoration: BoxDecoration(
        borderRadius: isLoading
            ? BorderRadius.circular(500)
            : isRotated
                ? BorderRadius.only(
                    topLeft: Radius.circular(500),
                    bottomLeft: Radius.circular(500),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(500),
                    bottomRight: Radius.circular(500),
                  ),
        color: color ?? Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xff9c84e0).withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(5, 5),
          ),
          BoxShadow(
            color: Color(0xff9c84e0).withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(5, -3),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: isRotated
            ? BorderRadius.only(
                topLeft: Radius.circular(500),
                bottomLeft: Radius.circular(500),
              )
            : BorderRadius.only(
                topRight: Radius.circular(500),
                bottomRight: Radius.circular(500),
              ),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(
                  color: color == null
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                ),
              )
            : TextButton(
                child: child,
                onPressed: onPressed,
                onLongPress: onLongPressed,
              ),
      ),
    );
  }
}
