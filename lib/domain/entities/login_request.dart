class LoginRequest {
  final String userEmail;
  final String password;
  final int comId;

  const LoginRequest({
    required this.userEmail,
    required this.password,
    required this.comId,
  });
}
