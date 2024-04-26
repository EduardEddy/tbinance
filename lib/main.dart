import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_binance/src/config/router/app_router.dart';
import 'package:test_binance/src/config/theme/app_theme.dart';
import 'package:test_binance/src/presentation/providers/user/user_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        title: 'Test Binance',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
