import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  const TextTitle(
    this.text, {
    super.key,
    this.textAlign,
    this.fontWeight = FontWeight.bold,
    this.fontSize = 16,
    this.maxLines = 1,
    this.color,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
        color: color,
        fontFamily: 'Almarai',
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class TextBody14 extends StatelessWidget {
  const TextBody14(
    this.text, {
    super.key,
    this.textAlign,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.maxLines = 1,
    this.color,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
        color: color,
        fontFamily: 'Almarai',
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class TextBody12 extends StatelessWidget {
  const TextBody12(
    this.text, {
    super.key,
    this.textAlign,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 12,
    this.color,
    this.maxLines = 1,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
        color: color,
        fontFamily: 'Almarai',
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription(
    this.text, {
    super.key,
    this.textAlign,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 10,
    this.color,
    this.maxLines = 1,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
        color: color,
        fontFamily: 'Almarai',
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

class TextLink extends StatelessWidget {
  const TextLink(
    this.text, {
    super.key,
    this.textAlign,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.color,
    this.onTap,
  });

  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final TextAlign? textAlign;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: MediaQuery.textScalerOf(context).scale(fontSize),
          color: Colors.blue,
          fontFamily: 'Almarai',
          decoration: TextDecoration.underline,
          decorationColor: Colors.blue,
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
      ),
    );
  }
}
