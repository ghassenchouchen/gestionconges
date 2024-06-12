  mixin InputValidationMixin {
    bool validInputLength(String? name) => (name?.trim() ?? "").length >= 3;

    bool validDomain(String? email) =>
        email != null && email.length >= 4 && email.contains('.') ||
        email!.isEmpty;

    bool validEmail(String? email) =>
        email != null &&
        email.length >= 4 &&
        email.contains('@') &&
        email.contains('.');

    bool validPhoneNumber(String? number) {
      String pattern = r'(^(?:[+0]9)?[0-9]{8}$)';
      RegExp regExp = RegExp(pattern);
      return number != null && regExp.hasMatch(number);
    }
  }
