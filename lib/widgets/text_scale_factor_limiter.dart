import 'package:flutter/material.dart';

class TextScaleFactorLimiter extends StatelessWidget {
  final double scaleMaxLimit;
  final double scaleMinLimit;

  const TextScaleFactorLimiter({
    required this.child,
    this.scaleMinLimit = 1.0,
    this.scaleMaxLimit = 1.0,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(
      scaleMinLimit,
      scaleMaxLimit,
    );

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: constrainedTextScaleFactor,
      ),
      child: child,
    );
  }
}
