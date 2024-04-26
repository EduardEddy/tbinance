import 'package:email_validator/email_validator.dart';

class HandleValidationEmail {
  static validEmail(String? email) {
    if (!EmailValidator.validate(email!)) {
      return 'Email invalido';
    }
    return null;
  }
}
