import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static String name = "home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgPicture.asset(
              'assets/images/currency.svg',
              width: 200,
            ),
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TextNavigations(
                  title: 'Bienvenido a TestBinance App',
                  color: ThemeData().primaryColor,
                  fontSize: 22,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 250,
              child: _Button(
                route: '/login',
                hasBgColor: true,
                title: 'Iniciar Sesion',
              ),
            ),
            const SizedBox(height: 5),
            const SizedBox(
              width: 250,
              child: _Button(
                route: '/register',
                hasBgColor: false,
                title: 'Registrarse',
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _TextNavigations extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color color;
  const _TextNavigations({
    required this.title,
    this.fontSize,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize, color: color, fontWeight: FontWeight.bold),
    );
  }
}

class _Button extends StatelessWidget {
  final String route;
  final bool hasBgColor;
  final String title;
  const _Button({
    required this.route,
    required this.hasBgColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = hasBgColor
        ? ElevatedButton.styleFrom(
            backgroundColor: ThemeData().primaryColor,
          )
        : ButtonStyle(
            side: MaterialStateProperty.all(
              BorderSide(
                color: ThemeData().primaryColor,
              ),
            ),
            foregroundColor: MaterialStateProperty.all(
              ThemeData().primaryColor,
            ),
          );
    return ElevatedButton(
      onPressed: () {
        context.push(route);
      },
      style: buttonStyle,
      child: _TextNavigations(
        title: title,
        color: hasBgColor ? Colors.white : ThemeData().primaryColor,
        fontSize: 16,
      ),
    );
  }
}
