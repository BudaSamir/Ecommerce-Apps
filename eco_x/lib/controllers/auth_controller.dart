// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eco_x/services/auth.dart';
import 'package:eco_x/utilities/enums.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  final AppAuth auth;
  String email;
  String password;
  AuthFormType authFormType;

  AuthController({
    required this.auth,
    this.email = '',
    this.password = '',
    this.authFormType = AuthFormType.login,
  });

  copyWith({
    String? email,
    String? password,
    AuthFormType? authFormType,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.authFormType = authFormType ?? this.authFormType;
    notifyListeners();
  }

  Future<void> submit() async {
    try {
      if (authFormType == AuthFormType.login) {
        await auth.loginWithEmailAndPassword(email, password);
      } else {
        await auth.signUpWithEmailAndPassword(email, password);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> googleSubmit() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> facebookSubmit() async {
    try {
      await auth.signINWithFaceBook();
    } catch (e) {
      rethrow;
    }
  }

  void toggleFOrmType() {
    // Switch between Login and regigster
    final formType = authFormType == AuthFormType.login
        ? AuthFormType.register
        : AuthFormType.login;
    // reset the text form fields
    copyWith(
      email: '',
      password: '',
      authFormType: formType,
    );
  }

  void updateEmail(String updateEmail) => copyWith(email: updateEmail);

  void updatePassword(String updatePassword) =>
      copyWith(password: updatePassword);

  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
