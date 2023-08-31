part of 'index.dart';

enum MessageType {
  success,
  error;

  Color toColor() {
    switch (this) {
      case MessageType.success:
        return StateColors.success;
      case MessageType.error:
        return StateColors.error;
    }
  }
}

class SMInput extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? message;
  final MessageType messageType;
  final bool obscureText;
  final int? maxLength;

  const SMInput({
    super.key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.message,
    this.messageType = MessageType.error,
    this.obscureText = false,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    final isMessageNotEmpty = message?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          maxLength: maxLength,
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: isMessageNotEmpty ? messageType.toColor() : SecondaryColors.bg03, width: 1.r),
              borderRadius: BorderRadius.circular(6.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: isMessageNotEmpty ? messageType.toColor() : SecondaryColors.bg03, width: 1.r),
              borderRadius: BorderRadius.circular(6.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: isMessageNotEmpty ? messageType.toColor() : SecondaryColors.bg05, width: 1.r),
              borderRadius: BorderRadius.circular(6.r),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            hintText: hintText,
            counterText: "",
            hintStyle: Pretendard.regular.set(
              size: 17,
              height: 24,
              color: SecondaryColors.bg03,
            ),
          ),
          cursorColor: SecondaryColors.bg05,
          style: Pretendard.regular.set(
            size: 17,
            height: 24,
            color: SecondaryColors.bg05,
          ),
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SMHeight(2),
              Text(
                message ?? '',
                style: Pretendard.regular.set(
                  size: 14,
                  height: 24,
                  color: messageType.toColor(),
                ),
              ),
            ],
          ),
          sizeCurve: Curves.fastOutSlowIn,
          crossFadeState: isMessageNotEmpty ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
