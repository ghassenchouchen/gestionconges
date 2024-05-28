import 'package:equatable/equatable.dart';
import 'package:pfeconges/data/model/employee/employee.dart';
import '../../../../../data/core/utils/bloc_status.dart';

class InviteMemberState extends Equatable {
  final Status status;
  final String? error;
  final String email;
  final bool emailError;
  final Role role;
  const InviteMemberState(
      {this.status = Status.initial,
      this.error,
      this.email = '',
      this.emailError = false,
      this.role= Role.employee  });

  InviteMemberState copyWith(
      {Status? status, String? error, String? email, bool? emailError, Role? role}) {
    return InviteMemberState(
        status: status ?? this.status,
        error: error,
        email: email ?? this.email,
        emailError: emailError ?? this.emailError,
        role: role ?? this.role); 
  }

  @override
  List<Object?> get props => [status, error, email, emailError,role];
}
