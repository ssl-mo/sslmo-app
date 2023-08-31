import 'package:email_validator/email_validator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sslmo/widget/index.dart';

part 'onboard_provider.g.dart';

@riverpod
class Email extends _$Email {
  @override
  String build() => "";

  void update(String value) {
    if (value.isNotEmpty && !EmailValidator.validate(value)) {
      ref.read(emailMessageProvider.notifier).update("올바르지 않은 형식입니다.");
      ref.read(emailMessageTypeProvider.notifier).update(MessageType.error);
    } else {
      ref.read(emailMessageProvider.notifier).update(null);
      ref.read(emailMessageTypeProvider.notifier).update(MessageType.error);
    }

    state = value;
  }
}

@riverpod
class EmailMessageType extends _$EmailMessageType {
  @override
  MessageType build() => MessageType.error;

  void update(MessageType value) {
    state = value;
  }
}

@riverpod
class EmailMessage extends _$EmailMessage {
  @override
  String? build() => null;

  void update(String? value) {
    state = value;
  }
}

@riverpod
bool signInEnabled(SignInEnabledRef ref) {
  final email = ref.watch(emailProvider);
  final emailMessage = ref.watch(emailMessageProvider);

  return email.isNotEmpty && emailMessage == null;
}
