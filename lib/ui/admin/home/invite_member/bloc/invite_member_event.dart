import 'package:equatable/equatable.dart';
import 'package:pfeconges/data/model/employee/employee.dart';

abstract class InvitationEvent extends Equatable {}

class AddEmailEvent extends InvitationEvent {
  final String query;

  AddEmailEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class InviteMemberEvent extends InvitationEvent {
  @override
  List<Object?> get props => [];
}

class UpdateRoleEvent extends InvitationEvent {
  final Role? role;

  UpdateRoleEvent({required this.role});
  @override
  List<Object?> get props => [role];
}
