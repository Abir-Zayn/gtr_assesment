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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Company Logo
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(AppImgSrc.appLogo, height: 90, width: 120),
              ),
              const SizedBox(height: 48),
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
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 15,
                    color: isDarkMode ? Colors.white70 : Colors.grey[600]!,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),

                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),

              const SizedBox(height: 20),

              // Password TextField
              TextFormField(
                controller: passwordController,
                obscureText: !passwordVisibility,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(
                    size: 15,
                    Icons.lock_outline,
                    color: isDarkMode ? Colors.white70 : Colors.grey[600]!,
                  ),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),

                  filled: true,
                  fillColor: Colors.transparent,
                ),
              ),

              const SizedBox(height: 12),

              // Forget Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color:
                          theme.textTheme.bodyMedium?.color ?? Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 32),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppText(text: 'Or Continue with', textfontsize: 14),
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
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SocialLoginPlaceholderBtn(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      iconColor: Colors.blue[700]!,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
