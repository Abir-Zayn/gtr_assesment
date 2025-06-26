part of 'app_router_imports.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => const Homepage()),
    GoRoute(
      path: '/customer-details',
      builder: (context, state) {
        final customer = state.extra as Customer;
        return CustomerDetailsPage(customer: customer);
      },
    ),
  ],
);
GoRouter get appRouter => _router;
