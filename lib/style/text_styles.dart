part of 'index.dart';

class Pretendard {
  Pretendard._();

  static const thin = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w100,
  );

  static const extraLight = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w200,
  );

  static const light = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w300,
  );

  static const regular = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w400,
  );

  static const medium = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w500,
  );

  static const semiBold = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w600,
  );

  static const bold = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w700,
  );

  static const extraBold = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w800,
  );

  static const black = TextStyle(
    fontFamily: "Pretendard",
    fontWeight: FontWeight.w900,
  );
}

extension DoubleExtension on double {
  double toFigmaLineHeight(double fontSize) {
    return this / fontSize;
  }
}

extension IntExtension on int {
  double toFigmaLineHeight(int fontSize) {
    return this / fontSize;
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle set({
    required double size,
    double? height,
    Color? color,
    double? letter,
    TextDecoration? decoration,
  }) {
    return copyWith(
      fontSize: size.sp,
      height: height?.toFigmaLineHeight(size) ?? 1,
      leadingDistribution: TextLeadingDistribution.even,
      color: color,
      letterSpacing: letter,
      decoration: decoration,
    );
  }
}
