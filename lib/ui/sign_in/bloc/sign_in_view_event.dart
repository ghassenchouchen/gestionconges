abstract class SignInEvent {}

class GoogleSignInEvent extends SignInEvent {}

class AppleSignInEvent extends SignInEvent {}
class EmailPasswordSignInEvent extends SignInEvent {
  final String email;
  final String password;

  EmailPasswordSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
