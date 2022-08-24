library flukit_icons;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'model.dart';

export './icons.dart';
export './model.dart';

class FluIcon extends StatelessWidget {
  final FluIconModel icon;
  final FluIconStyle? style;

  const FluIcon({
    required this.icon,
    this.style,
    Key? key,
  }) : super(key: key);

  double get size => style?.size ?? 24;

  @override
  Widget build(BuildContext context) => Align(
      alignment: style?.alignment ?? Alignment.center,
      child: SizedBox(
          height: size,
          width: size,
          child: RepaintBoundary(
            child: SvgPicture.string(
              '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">${icon.data}</svg>'
                  .replaceAll('stroke-width="1.5"',
                      'stroke-width="${style?.strokeWidth ?? 1.5}"'),
              height: size,
              width: size,
              color: style?.color ?? Colors.black,
            ),
          )));
}

class FluIconStyle {
  Color? color;
  double? size;
  double? strokeWidth;
  Alignment? alignment;

  FluIconStyle({
    this.color,
    this.size = 24,
    this.strokeWidth = 1.5,
    this.alignment = Alignment.center,
  });

  FluIconStyle merge(FluIconStyle? iconStyle) => FluIconStyle(
      color: iconStyle?.color ?? color,
      size: iconStyle?.size ?? size,
      strokeWidth: iconStyle?.strokeWidth ?? strokeWidth,
      alignment: iconStyle?.alignment ?? alignment);
}
