class AuthFormUser {
  String? login;
  String? email;
  String? fullName;

  String? password;
  String? repeatPassword;
  bool isUserAgree;

  AuthFormUser({
    this.login,
    this.email,
    this.fullName,
    this.password,
    this.repeatPassword,
    this.isUserAgree = false,
  });
}
