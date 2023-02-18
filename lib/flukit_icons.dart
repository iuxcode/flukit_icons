library flukit_icons;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icons.dart';

export 'icons.dart';

enum FluIconStyles { linear, broken, bulk, twotone }

/* TODO Fix:
  - Bulk Brand icons
  - Mobile icon: Linear && Twotone
  - Document copy: Twotone
  - Document sketch: Twotone
  - Task Square: Bulk
  - Blend2: Linear && Twotone
  - Brush: Bulk
  - Recovery: Linear && Twotone
  - CD: Linear && Twotone && Bulk
  - Frame 1 & 2 & 3 & 4: Bulk
  - QuoteDown: Broken
  - VolumeCross: Twotone
  - VolumeSlash: Twotone
*/

class FluIcon extends StatelessWidget {
  const FluIcon(
    this.icon, {
    Key? key,
    this.style = FluIconStyles.twotone,
    this.size = 24,
    this.strokeWidth = 1.5,
    this.alignment = Alignment.center,
    this.color,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  final Alignment alignment;
  final Color? color;
  final FluIcons icon;
  final EdgeInsets margin;
  final double size;
  final double strokeWidth;
  final FluIconStyles style;

  @override
  Widget build(BuildContext context) {
    bool isUnicon = icon.category.toLowerCase() == 'unicon';
    FluIconStyles iconStyle = style;

    if (isUnicon &&
        (iconStyle == FluIconStyles.broken ||
            iconStyle == FluIconStyles.twotone)) {
      iconStyle = icon.paths[FluIconStyles.linear.name] != null
          ? FluIconStyles.linear
          : FluIconStyles.bulk;
    }

    String? path = icon.paths[iconStyle.name];

    if (path == null) {
      print(
          'Error: Style ${iconStyle.name} doesn\'t exist for icon ${icon.name}');
    }

    return Container(
      height: size,
      width: size,
      alignment: alignment,
      margin: margin,
      child: RepaintBoundary(
        child: SvgPicture.string(
          '<svg width="$size" height="$size" viewBox="0 0 24 24" ${isUnicon ? '' : 'fill="none"'} xmlns="http://www.w3.org/2000/svg">${isUnicon ? '<g>%data%</g>' : '%data%'}</svg>'
              .replaceAll('%data%', path ?? '')
              .replaceAll('stroke-width="1.5"', 'stroke-width="$strokeWidth"'),
          height: size,
          width: size,
          color: color ?? Colors.black, // TODO: Remove me!
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
