import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pfeconges/data/services/account_service.dart';
import '../../../data/core/exception/error_const.dart';
import '../../../data/model/account/account.dart';
import '../../../data/provider/user_state.dart';
import '../../../data/services/auth_service.dart';
import 'sign_in_view_event.dart';
import 'sign_in_view_state.dart';

@Injectable()
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserStateNotifier _userStateNotifier;
  final AuthService _authService;
  final AccountService _accountService;

  SignInBloc(
    this._userStateNotifier,
    this._authService,
    this._accountService,
  ) : super(const SignInState()) {
    on<EmailPasswordSignInEvent>(_signInWithEmailPassword);
    on<SignInTextChangedEvent>(_onSignInTextChanged);
  }  

  Future<void> _signInWithEmailPassword(
      EmailPasswordSignInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(emailPasswordSignInLoading: true, error: ''));
    try {
      firebase_auth.User? authUser = await _authService.signInWithEmailPassword(
          event.email, event.password);
      if (authUser != null) {
        final Account user = await _accountService.getUser(authUser);
        await _userStateNotifier.setUser(user);

        emit(state.copyWith(
            emailPasswordSignInLoading: false, signInSuccess: true, error: ''));
      } else {
        emit(state.copyWith(
            emailPasswordSignInLoading: false,
            error: 'Authentication failed')); 
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(state.copyWith(
          emailPasswordSignInLoading: false, error: e.message ?? 'An unknown error occurred'));
    } catch (e) {
      emit(state.copyWith(
          emailPasswordSignInLoading: false, error: 'An unknown error occurred'));
    }
  }
  
  void _onSignInTextChanged(
      SignInTextChangedEvent event, Emitter<SignInState> emit) async {
    if (state.error != null) {
      emit(state.copyWith(error: ''));
    }
  }
}
