part of 'splash_screen_imports.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Page Overview:
// --> Show an animation of a logo fading in and out
// --> After the animation, navigate to the login screen

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fadeAnimation;
  // AnimationController _controller;

  @override
  void initState() {
    super.initState();

    //Initialize animationController
    _controller = AnimationController(
      duration: const Duration(microseconds: 1500),
      vsync: this,
    );

    //fade animation
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    //start the animation
    startAnimation();
  }

  void startAnimation() async {
    // Start fade-in animation
    _controller.forward();

    // Wait for animation to complete + 2 seconds stay duration
    await Future.delayed(const Duration(milliseconds: 3500));

    // Navigate to login screen
    if (mounted) {
      context.go('/login');
    }
  }

  //dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Image.asset(AppImgSrc.appLogo, width: 200, height: 200),
        ),
      ),
    );
  }
}
