import 'package:flutter_test/flutter_test.dart';
import 'package:rwzappp/Pages/Login.dart';

void main() {
  test('Test geen e-mailadres', () {
    final emailValidator = EmailValidator();

    expect("Email cannot be empty", emailValidator.validate(""));

  });

  test('Test met e-mailadres', () {
    final emailValidator = EmailValidator();

    expect(null, emailValidator.validate("f.guldenaar@student.fontys.nl"));

  });
}
