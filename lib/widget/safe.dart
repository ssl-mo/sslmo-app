part of 'index.dart';

class SMSafeBox extends SafeArea {
  const SMSafeBox({
    super.key,
    super.left = false,
    super.top = false,
    super.right = false,
    super.bottom = false,
    super.minimum,
    super.maintainBottomViewPadding,
    super.child = const SizedBox.shrink(),
  });
}

class SMSafeColumn extends Column {
  final bool top;
  final bool bottom;

  SMSafeColumn({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    required List<Widget> children,
    this.top = false,
    this.bottom = false,
  }) : super(
          children: [
            if (top) const SMSafeBox(top: true),
            ...children,
            if (bottom) const SMSafeBox(bottom: true),
          ],
        );
}
