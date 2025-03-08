import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double? size;
  final TextStyle? textStyle;
  final VoidCallback onPressed;

  const ProductivityButton({
    super.key,
    required this.color,
    required this.text,
    this.size,
    this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      minWidth: size ?? 0,
      onPressed: onPressed,
      child: Text(text, style: textStyle ?? TextStyle(color: Colors.white)),
    );
  }
}
