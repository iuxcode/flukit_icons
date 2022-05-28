import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'model.dart';

class FluIcon extends StatefulWidget {
  final FluIconModel icon;
  final Color? color;
  final double size, strokeWidth;
  /// final EdgeInsets? margin;
  final Alignment alignment;

  const FluIcon({
    Key? key,
    required this.icon,
    this.color,
    /// this.margin,
    this.size = 24,
    this.strokeWidth = 1.5,
    this.alignment = Alignment.center,
  }) : super(key: key);

  @override
  State<FluIcon> createState() => _FluIconState();
}

class _FluIconState extends State<FluIcon> {
  late String iconString;

  @override
  void initState() {
    iconString = '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">${widget.icon.data}</svg>'
      .replaceAll('stroke-width="1.5"', 'stroke-width="${widget.strokeWidth}"');
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Align( /// TODO add margin
    alignment: widget.alignment,
    child: SizedBox(
      height: widget.size, width: widget.size,
      child: RepaintBoundary(
        child: SvgPicture.string(
          iconString,
          height: widget.size, width: widget.size,
          color: widget.color ?? Colors.black,
        ),
      )
    )
  );
}
