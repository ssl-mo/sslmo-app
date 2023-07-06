import 'package:freezed_annotation/freezed_annotation.dart';

enum SignInType {
  @JsonValue("EMAIL")
  email,
  @JsonValue("APPLE")
  apple,
  @JsonValue("GOOGLE")
  google,
  @JsonValue("NAVER")
  naver,
  @JsonValue("KAKAO")
  kakao;
}
