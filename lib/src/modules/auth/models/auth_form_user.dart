class AuthFormUser {
  String? login;
  String? email;
  String? fullName;

  String? password;
  String? repeatPassword;

  AuthFormUser({
    required this.login,
    required this.email,
    required this.fullName,
    required this.password,
    required this.repeatPassword,
  });
}