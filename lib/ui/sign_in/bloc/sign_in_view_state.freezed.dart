// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_view_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignInState {
  dynamic get signInSuccess => throw _privateConstructorUsedError;
  dynamic get emailPasswordSignInLoading =>
      throw _privateConstructorUsedError; // Add this line
  String? get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignInStateCopyWith<SignInState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInStateCopyWith<$Res> {
  factory $SignInStateCopyWith(
          SignInState value, $Res Function(SignInState) then) =
      _$SignInStateCopyWithImpl<$Res, SignInState>;
  @useResult
  $Res call(
      {dynamic signInSuccess,
      dynamic emailPasswordSignInLoading,
      String? error});
}

/// @nodoc
class _$SignInStateCopyWithImpl<$Res, $Val extends SignInState>
    implements $SignInStateCopyWith<$Res> {
  _$SignInStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signInSuccess = freezed,
    Object? emailPasswordSignInLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      signInSuccess: freezed == signInSuccess
          ? _value.signInSuccess
          : signInSuccess // ignore: cast_nullable_to_non_nullable
              as dynamic,
      emailPasswordSignInLoading: freezed == emailPasswordSignInLoading
          ? _value.emailPasswordSignInLoading
          : emailPasswordSignInLoading // ignore: cast_nullable_to_non_nullable
              as dynamic,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignInStateImplCopyWith<$Res>
    implements $SignInStateCopyWith<$Res> {
  factory _$$SignInStateImplCopyWith(
          _$SignInStateImpl value, $Res Function(_$SignInStateImpl) then) =
      __$$SignInStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic signInSuccess,
      dynamic emailPasswordSignInLoading,
      String? error});
}

/// @nodoc
class __$$SignInStateImplCopyWithImpl<$Res>
    extends _$SignInStateCopyWithImpl<$Res, _$SignInStateImpl>
    implements _$$SignInStateImplCopyWith<$Res> {
  __$$SignInStateImplCopyWithImpl(
      _$SignInStateImpl _value, $Res Function(_$SignInStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signInSuccess = freezed,
    Object? emailPasswordSignInLoading = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SignInStateImpl(
      signInSuccess:
          freezed == signInSuccess ? _value.signInSuccess! : signInSuccess,
      emailPasswordSignInLoading: freezed == emailPasswordSignInLoading
          ? _value.emailPasswordSignInLoading!
          : emailPasswordSignInLoading,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SignInStateImpl implements _SignInState {
  const _$SignInStateImpl(
      {this.signInSuccess = false,
      this.emailPasswordSignInLoading = false,
      this.error});

  @override
  @JsonKey()
  final dynamic signInSuccess;
  @override
  @JsonKey()
  final dynamic emailPasswordSignInLoading;
// Add this line
  @override
  final String? error;

  @override
  String toString() {
    return 'SignInState(signInSuccess: $signInSuccess, emailPasswordSignInLoading: $emailPasswordSignInLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInStateImpl &&
            const DeepCollectionEquality()
                .equals(other.signInSuccess, signInSuccess) &&
            const DeepCollectionEquality().equals(
                other.emailPasswordSignInLoading, emailPasswordSignInLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(signInSuccess),
      const DeepCollectionEquality().hash(emailPasswordSignInLoading),
      error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInStateImplCopyWith<_$SignInStateImpl> get copyWith =>
      __$$SignInStateImplCopyWithImpl<_$SignInStateImpl>(this, _$identity);
}

abstract class _SignInState implements SignInState {
  const factory _SignInState(
      {final dynamic signInSuccess,
      final dynamic emailPasswordSignInLoading,
      final String? error}) = _$SignInStateImpl;

  @override
  dynamic get signInSuccess;
  @override
  dynamic get emailPasswordSignInLoading;
  @override // Add this line
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$$SignInStateImplCopyWith<_$SignInStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
