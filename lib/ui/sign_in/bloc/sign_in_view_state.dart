import 'package:freezed_annotation/freezed_annotation.dart';

part "sign_in_view_state.freezed.dart";

@freezed
class SignInState with _$SignInState {
  const factory SignInState(
      {
      @Default(false) signInSuccess,
      @Default(false)  emailPasswordSignInLoading, 
      // Add this line

      String? error}) = _SignInState;
}
