import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;

  const AppNetworkImage({
    super.key,
    this.width,
    this.height,
    required this.url,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    final image = CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) =>
          Center(child: CupertinoActivityIndicator(color: color.text)),
      errorWidget: (context, url, error) => Icon(
        CupertinoIcons.exclamationmark_triangle,
        color: color.disableStatus,
      ),
    );

    return image;
  }
}
