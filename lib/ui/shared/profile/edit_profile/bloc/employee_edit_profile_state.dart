import 'package:equatable/equatable.dart';

import '../../../../../data/core/utils/bloc_status.dart';
import '../../../../../data/model/employee/employee.dart';

class EmployeeEditProfileState extends Equatable {
  final Status status;
  final DateTime? dateOfBirth;
  final bool nameError;
  final bool numberError;
  final String? error;
  final String? imageURL;

  const EmployeeEditProfileState({
    this.dateOfBirth,
    this.status = Status.initial,
    this.error,
    this.nameError = false,
    this.numberError = false,
    this.imageURL,
  });

  bool get isDataValid => !nameError && !numberError;

  EmployeeEditProfileState copyWith({
    DateTime? dateOfBirth,
    bool? nameError,
    bool? numberError,
    String? error,
    Status? status,
    String? imageURL,
  }) {
    return EmployeeEditProfileState(
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        error: error,
        nameError: nameError ?? this.nameError,
        numberError: numberError ?? this.numberError,
        status: status ?? this.status,
        imageURL: imageURL ?? this.imageURL);
  }

  EmployeeEditProfileState changeDateOfBirth({DateTime? dateOfBirth}) {
    return EmployeeEditProfileState(
      status: status,
      dateOfBirth: dateOfBirth,
      nameError: nameError,
      numberError: numberError,
      error: error,
      imageURL: imageURL,
    );
  }



  @override
  List<Object?> get props =>
      [ dateOfBirth, status, nameError, numberError, error, imageURL];
}
