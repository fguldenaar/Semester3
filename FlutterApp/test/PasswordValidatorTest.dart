import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwzappp/Pages/Login.dart';

void main() {
  test('Test zonder password', () {
    final passwordValidator = PasswordValidator();

    expect("Password cannot be empty", passwordValidator.validate(""));

  });

  test('Test met password', () {
    final passwordValidator = PasswordValidator();

    expect(null, passwordValidator.validate("wachtwoord"));

  });
}
