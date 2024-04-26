import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_binance/src/config/helpers/alert_message_helper.dart';
import 'package:test_binance/src/presentation/providers/register/register_provider.dart';
import 'package:test_binance/src/presentation/utils/handle_validation_email.dart';
import 'package:test_binance/src/presentation/utils/handle_validation_password.dart';
import 'package:test_binance/src/presentation/widget/custom_button.dart';
import 'package:test_binance/src/presentation/widget/custom_input.dart';

class RegisterScreen extends StatelessWidget {
  static String name = 'register';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: _FormRegister(),
      ),
    );
  }
}

class _FormRegister extends StatelessWidget {
  const _FormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle styleText = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return ChangeNotifierProvider(
      create: (contex_) => RegisterProvider(),
      child: Consumer<RegisterProvider>(
        builder: (_, registerProvider, __) => Form(
          key: registerProvider.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/images/register.svg',
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
                controller: registerProvider.email,
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
                  controller: registerProvider.password),
              const SizedBox(height: 20),
              Text(
                'Confirmar Password',
                style: styleText,
              ),
              CustomInput(
                  hintText: 'confirmar password',
                  validate: (password) =>
                      registerProvider.validateConfirmPassword(),
                  isObscureText: true,
                  controller: registerProvider.confirmPassword),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    label: 'Guardar',
                    icon: Icons.save,
                    action: () async {
                      dynamic result = await registerProvider.submit();
                      if (result['messageError']) {
                        alertMessage(context, 'Usuario ya registrado');
                      }
                      if (result['messageSuccess']) {
                        alertMessage(context, 'Ya puedes iniciar sesión');
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
                        context.push('/login');
                      },
                      child: const Text('ir al Login'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
