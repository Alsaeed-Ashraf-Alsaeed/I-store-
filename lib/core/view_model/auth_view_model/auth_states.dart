class AuthStates {}

class AuthValidationState extends AuthStates {
  String? emailValidator;
  String? passwordValidator;
  AuthValidationState({this.emailValidator, this.passwordValidator});
}
