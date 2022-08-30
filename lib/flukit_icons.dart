library flukit_icons;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'icons.dart';
// import 'model.dart';

export 'icons.dart';
// export 'model.dart';

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
  final FluIcons icon;
  final FluIconStyles style;
  final Color? color;
  final double size;
  final double strokewidth;
  final Alignment alignment;
  final EdgeInsets margin;

  const FluIcon(this.icon,
      {Key? key,
      this.style = FluIconStyles.twotone,
      this.size = 24,
      this.strokewidth = 1.5,
      this.alignment = Alignment.center,
      this.color,
      this.margin = EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUnicon = icon.category.toLowerCase() == 'unicon';
    FluIconStyles _style = style;

    if (isUnicon &&
        (style == FluIconStyles.broken || style == FluIconStyles.twotone)) {
      _style = icon.paths[FluIconStyles.linear.name] != null
          ? FluIconStyles.linear
          : FluIconStyles.bulk;
    }

    String? path = icon.paths[_style.name];

    if (path == null) {
      print('Error: Style ${_style.name} doesn\'t exist for icon ${icon.name}');
    }

    return Container(
      height: size,
      width: size,
      alignment: alignment,
      margin: margin,
      child: RepaintBoundary(
        child: SvgPicture.string(
          '<svg width="24" height="24" viewBox="0 0 24 24" ${isUnicon ? '' : 'fill="none"'} xmlns="http://www.w3.org/2000/svg">${isUnicon ? '<g>%data%</g>' : '%data%'}</svg>'
              .replaceAll('%data%', path ?? '')
              .replaceAll('stroke-width="1.5"', 'stroke-width="$strokewidth"'),
          height: size,
          width: size,
          color: color ?? Colors.black,
        ),
      ),
    );
  }
}
