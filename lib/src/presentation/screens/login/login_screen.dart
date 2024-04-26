import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_binance/src/config/helpers/alert_message_helper.dart';
import 'package:test_binance/src/presentation/providers/login/login_provider.dart';
import 'package:test_binance/src/presentation/providers/user/user_provider.dart';
import 'package:test_binance/src/presentation/utils/handle_validation_email.dart';
import 'package:test_binance/src/presentation/utils/handle_validation_password.dart';
import 'package:test_binance/src/presentation/widget/custom_button.dart';
import 'package:test_binance/src/presentation/widget/custom_input.dart';

class LoginScreen extends StatelessWidget {
  static String name = 'login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: _FormLogin(),
      ),
    );
  }
}

class _FormLogin extends StatelessWidget {
  const _FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle styleText = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    final UserProvider userProvider = context.read<UserProvider>();

    return ChangeNotifierProvider(
      create: (contex_) => LoginProvider(),
      child: Consumer<LoginProvider>(
        builder: (_, loginProvider, __) => Form(
          key: loginProvider.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/images/login.svg',
                width: 200,
              ),
              const SizedBox(height: 40),
              Text(
                'Email',
                style: styleText,
              ),
              CustomInput(
                hintText: 'ingrese email',
                validate: (email) => HandleValidationEmail.validEmail(email),
                keyboardType: TextInputType.emailAddress,
                controller: loginProvider.email,
              ),
              const SizedBox(height: 20),
              Text(
                'Password',
                style: styleText,
              ),
              CustomInput(
                  hintText: 'ingrese password',
                  validate: (password) =>
                      HandleValidationPassword.emptyInput(password),
                  isObscureText: true,
                  controller: loginProvider.password),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    label: 'Iniciar sesión',
                    icon: Icons.login,
                    action: () async {
                      dynamic result = await loginProvider.submit();

                      if (result['showMessage']) {
                        alertMessage(context, 'Credenciales inválidas');
                      }
                      if (result['navigate']) {
                        userProvider.setEmail = loginProvider.email.text;
                        context.go('/dashboard');
                      }
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        context.push('/register');
                      },
                      child: const Text('Registrarse'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
