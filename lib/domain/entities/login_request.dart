class LoginRequest {
  final String userName;
  final String password;
  final int comId;

  const LoginRequest({
    required this.userName,
    required this.password,
    required this.comId,
  });
}
