part of 'login_page_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisibility = false;

  //LoginLoading --> Spinner
  //LoginSuccess --> navigate to Home
  //LoginFailure --> Error

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleClick() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    context.read<LoginCubit>().login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void futureUpdateNotice() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.yellow,
        content: AppText(text: "Coming Soon", textfontsize: 12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Find out the user current theme
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: theme.textTheme.headlineMedium?.color ?? Colors.black,
                size: 24,
              ),
            ),
          ),
        ],
      ),

      // If Login is Successful or Failure State
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppText(
                  text: "Successfully Logged In",
                  textfontsize: 12,
                  color: Colors.white,
                ),
                backgroundColor: Colors.lightGreen,
              ),
            );
            context.go('/home');
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: AppText(text: "Failed to Login", textfontsize: 12),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                // Company Logo
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(AppImgSrc.appLogo, height: 90, width: 120),
                ),
                const SizedBox(height: 35),
                // Welcome Text
                AppText(
                  text: 'Welcome Back',
                  textfontsize: 28,
                  color: isDarkMode ? Colors.white : Colors.black,
                  textAlign: TextAlign.left,
                  fontWeight: FontWeight.w600,
                ),

                const SizedBox(height: 8),

                AppText(
                  text: "Sign in to continue",
                  color: isDarkMode ? Colors.white70 : Colors.grey[600],
                  textfontsize: 17,
                ),

                const SizedBox(height: 40),

                // Email TextField
                AppTextfield(
                  controller: emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                // Password TextField
                AppTextfield(
                  controller: passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: !passwordVisibility,
                  suffixIcon: IconButton(
                    icon: Icon(
                      size: 15,
                      passwordVisibility
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isDarkMode ? Colors.white70 : Colors.grey[600]!,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisibility = !passwordVisibility;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 12),

                // Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      futureUpdateNotice();
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color:
                            theme.textTheme.bodyMedium?.color ??
                            Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login Button
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is LoginLoading ? null : handleClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child:
                          state is LoginLoading
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppText(
                        text: 'Or Continue with',
                        textfontsize: 14,
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),

                const SizedBox(height: 24),

                // Social Login Buttons Placeholder
                Row(
                  children: [
                    Expanded(
                      child: SocialLoginPlaceholderBtn(
                        icon: FontAwesomeIcons.google,
                        label: 'Google',
                        iconColor: Colors.red[600]!,
                        onPressed: () {
                          futureUpdateNotice();
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SocialLoginPlaceholderBtn(
                        icon: Icons.facebook,
                        label: 'Facebook',
                        iconColor: Colors.blue[700]!,
                        onPressed: () {
                          futureUpdateNotice();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
