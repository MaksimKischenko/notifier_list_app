import 'package:flutter/material.dart';

class InkWrapper extends StatelessWidget {
  // final Color splashColor;
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback? onLongTap;
  final double borderRadius;

  const InkWrapper({
    Key? key,
    // this.splashColor,
    required this.child,
    required this.onTap,
    this.onLongTap,
    this.borderRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Stack(
      children: [
        Positioned.fill(child: child),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              // splashColor: splashColor,
              onTap: onTap,
              onLongPress: onLongTap,
            ),
          ),
        ),
      ],
    ),
  );
}
