import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class SvgIcon extends StatelessWidget {
  final BoxFit fit;
  final String path;
  final Color? color;
  final double? width;
  final double? height;
  final SvgTheme? theme;
  final String? package;
  final Clip clipBehavior;
  final AssetBundle? bundle;
  final String? semanticsLabel;
  final bool matchTextDirection;
  final ColorFilter? colorFilter;
  final ColorMapper? colorMapper;
  final bool excludeFromSemantics;
  final AlignmentGeometry alignment;
  final bool allowDrawingOutsideViewBox;
  final Widget Function(BuildContext)? placeholderBuilder;
  final Widget Function(BuildContext, Object, StackTrace)? errorBuilder;

  const SvgIcon(
    this.path, {
    super.key,
    this.color,
    this.width,
    this.theme,
    this.height,
    this.bundle,
    this.package,
    this.colorFilter,
    this.colorMapper,
    this.errorBuilder,
    this.semanticsLabel,
    this.placeholderBuilder,
    this.fit = BoxFit.contain,
    this.matchTextDirection = false,
    this.alignment = Alignment.center,
    this.clipBehavior = Clip.hardEdge,
    this.excludeFromSemantics = false,
    this.allowDrawingOutsideViewBox = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      fit: fit,
      key: key,
      width: width,
      theme: theme,
      height: height,
      bundle: bundle,
      package: package,
      alignment: alignment,
      colorMapper: colorMapper,
      errorBuilder: errorBuilder,
      semanticsLabel: semanticsLabel,
      placeholderBuilder: placeholderBuilder,
      matchTextDirection: matchTextDirection,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      colorFilter: color == null
          ? colorFilter
          : ColorFilter.mode(color!, BlendMode.srcIn),
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
    );
  }
}
