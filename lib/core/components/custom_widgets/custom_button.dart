import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    required this.child,
    this.backgroundColor,
    this.elevationColor,
    this.elevation,
    this.borderRadius,
    this.height,
    this.width,
  });

  final void Function()? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? elevationColor;
  final double? elevation;
  final double? borderRadius;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 32,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation:
              WidgetStateProperty.resolveWith((states) => elevation ?? 9),
          shadowColor: WidgetStateColor.resolveWith((states) =>
              elevationColor ?? Colors.black.withValues(alpha: 0.5)),
          backgroundColor: WidgetStateColor.resolveWith(
              (states) => backgroundColor ?? AppColors.mainColor),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8)),
          ),
        ),
        child: child,
      ),
    );
  }
}
