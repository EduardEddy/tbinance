import 'package:go_router/go_router.dart';
import 'package:test_binance/src/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:test_binance/src/presentation/screens/home/home_screen.dart';
import 'package:test_binance/src/presentation/screens/login/login_screen.dart';
import 'package:test_binance/src/presentation/screens/register/register_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/login',
    name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/dashboard',
    name: DashboardScreen.name,
    builder: (context, state) => const DashboardScreen(),
  ),
]);
