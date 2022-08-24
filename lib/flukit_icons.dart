library flukit_icons;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'model.dart';

export './icons.dart';
export './model.dart';

enum FluIconStyles { linear, broken, bulk, twotone }

class FluIcon extends StatelessWidget {
  final FluIconModel icon;
  final FluIconStyles style;
  final Color? color;
  final double size;
  final double strokeWidth;
  final Alignment alignment;

  const FluIcon({
    Key? key,
    required this.icon,
    this.style = FluIconStyles.broken,
    this.size = 24,
    this.strokeWidth = 1.5,
    this.alignment = Alignment.center,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String data = icon.datas[style.name];

    return Align(
      alignment: alignment,
      child: SizedBox(
        height: size,
        width: size,
        child: RepaintBoundary(
          child: SvgPicture.string(
            '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">$data</svg>'
                .replaceAll('stroke-width="1.5"', 'stroke-width="$strokeWidth"'),
            height: size,
            width: size,
            color: color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
