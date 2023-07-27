part of 'index.dart';

class SMPngImage extends StatelessWidget {
  final String assetName;
  final double? size;
  final double? height;
  final double? width;
  final BoxFit fit;

  const SMPngImage(
    this.assetName, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetName,
      height: size != null ? size!.r : height?.h,
      width: size != null ? size!.r : width?.w,
      fit: fit,
    );
  }
}

class SMSvgImage extends StatelessWidget {
  final String assetName;
  final double? size;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;

  const SMSvgImage(
    this.assetName, {
    super.key,
    this.size,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size != null ? size!.r : height?.h,
      width: size != null ? size!.r : width?.w,
      fit: fit,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
