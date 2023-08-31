part of 'index.dart';

enum SMButtonStyle {
  primaryFilled,
  primaryOutlined,
  primaryText,

  secondaryFilled,
  secondaryOutlined,
  secondaryText;

  BoxDecoration toDefaultDecoration() {
    switch (this) {
      case SMButtonStyle.primaryFilled:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: PrimaryColors.accent,
        );
      case SMButtonStyle.secondaryFilled:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: SecondaryColors.bg05,
        );
      case SMButtonStyle.primaryOutlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            width: 1.r,
            color: PrimaryColors.accent,
          ),
          color: Colors.white,
        );
      case SMButtonStyle.secondaryOutlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            width: 1.r,
            color: SecondaryColors.bg05,
          ),
          color: Colors.white,
        );
      case SMButtonStyle.primaryText:
      case SMButtonStyle.secondaryText:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.white,
        );
    }
  }

  BoxDecoration toFocusedDecoration() {
    switch (this) {
      case SMButtonStyle.primaryFilled:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            width: 1.r,
            color: PrimaryColors.accent,
          ),
          color: PrimaryColors.light,
        );
      case SMButtonStyle.secondaryFilled:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: SecondaryColors.bg04,
        );
      case SMButtonStyle.primaryOutlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            width: 1.r,
            color: PrimaryColors.accent,
          ),
          color: const Color(0x3382DF94),
        );
      case SMButtonStyle.secondaryOutlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            width: 1.r,
            color: SecondaryColors.bg05,
          ),
          color: const Color(0x33B4B4B5),
        );
      case SMButtonStyle.primaryText:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: const Color(0x3382DF94),
        );
      case SMButtonStyle.secondaryText:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: const Color(0x33B4B4B5),
        );
    }
  }

  BoxDecoration toDisabledDecoration() {
    switch (this) {
      case SMButtonStyle.primaryFilled:
      case SMButtonStyle.secondaryFilled:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: SecondaryColors.bg02,
        );
      case SMButtonStyle.primaryOutlined:
      case SMButtonStyle.secondaryOutlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            width: 1.r,
            color: SecondaryColors.bg03,
          ),
          color: Colors.white,
        );
      case SMButtonStyle.primaryText:
      case SMButtonStyle.secondaryText:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.white,
        );
    }
  }

  TextStyle toDefaultTextStyle() {
    switch (this) {
      case SMButtonStyle.primaryFilled:
        return Pretendard.semiBold.set(
          size: 17,
          color: SecondaryColors.bg05,
        );
      case SMButtonStyle.secondaryFilled:
        return Pretendard.semiBold.set(
          size: 17,
          color: SecondaryColors.bg01,
        );
      case SMButtonStyle.primaryOutlined:
        return Pretendard.semiBold.set(
          size: 17,
          color: PrimaryColors.accent,
        );
      case SMButtonStyle.secondaryOutlined:
        return Pretendard.semiBold.set(
          size: 17,
          color: SecondaryColors.bg05,
        );
      case SMButtonStyle.primaryText:
        return Pretendard.semiBold.set(
          size: 17,
          color: PrimaryColors.accent,
          decoration: TextDecoration.underline,
        );
      case SMButtonStyle.secondaryText:
        return Pretendard.semiBold.set(
          size: 17,
          color: SecondaryColors.bg05,
          decoration: TextDecoration.underline,
        );
    }
  }

  TextStyle toDisabledTextStyle() {
    switch (this) {
      case SMButtonStyle.primaryFilled:
      case SMButtonStyle.secondaryFilled:
      case SMButtonStyle.primaryOutlined:
      case SMButtonStyle.secondaryOutlined:
        return Pretendard.semiBold.set(
          size: 17,
          color: SecondaryColors.bg03,
        );
      case SMButtonStyle.primaryText:
      case SMButtonStyle.secondaryText:
        return Pretendard.semiBold.set(
          size: 17,
          color: SecondaryColors.bg03,
          decoration: TextDecoration.underline,
        );
    }
  }
}

class SMButton extends StatefulWidget {
  final void Function()? onTap;
  final SMButtonStyle style;
  final bool enabled;
  final String text;
  final double height;
  final List<Widget>? left;
  final List<Widget>? right;

  const SMButton(
    this.text, {
    super.key,
    this.style = SMButtonStyle.primaryFilled,
    this.enabled = true,
    this.onTap,
    this.height = 44,
    this.left,
    this.right,
  });

  @override
  State<StatefulWidget> createState() => SMButtonState();
}

class SMButtonState extends State<SMButton> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapUp: (_) {
        if (widget.enabled) {
          Timer(
            const Duration(milliseconds: 100),
            () => setState(() => focused = false),
          );
        }
      },
      onTapDown: (_) {
        if (widget.enabled) {
          setState(() => focused = true);
        }
      },
      onTap: () {
        if (widget.enabled && widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        height: widget.height.h,
        decoration: widget.enabled
            ? focused
                ? widget.style.toFocusedDecoration()
                : widget.style.toDefaultDecoration()
            : widget.style.toDisabledDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...widget.left ?? [],
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                widget.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: widget.enabled ? widget.style.toDefaultTextStyle() : widget.style.toDisabledTextStyle(),
              ),
            ),
            ...widget.right ?? [],
          ],
        ),
      ),
    );
  }
}
