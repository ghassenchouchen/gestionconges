abstract class SignInEvent {}

class EmailPasswordSignInEvent extends SignInEvent {
  final String email;
  final String password;

  EmailPasswordSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignInTextChangedEvent extends SignInEvent {
  final String email;
  final String password;

  SignInTextChangedEvent({this.email = '', this.password = ''});

  @override
  List<Object> get props => [email,password];
}
