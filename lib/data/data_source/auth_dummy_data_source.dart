import 'package:elevate_super_fitness/data/models/user_model.dart';
import 'package:elevate_super_fitness/domain/entites/email_verification_entity.dart';
import 'package:elevate_super_fitness/domain/entites/forget_password_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/email_verification_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/forget_password_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/register_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/reset_password_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/reset_password_response_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthDummyDataSource {
  final List<UserModel> _users = [
    UserModel(
      id: 'seed-user-1',
      firstName: 'Demo',
      lastName: 'User',
      email: 'demo@fitness.app',
      password: 'password123',
      gender: 'male',
      age: 25,
      weight: 75,
      height: 175,
      activityLevel: 'rookie',
      goal: 'lose_weight',
      photo: null,
      createdAt: DateTime.now().toIso8601String(),
    ),
  ];

  final Map<String, String> _resetCodesByEmail = {};
  final Set<String> _verifiedResetEmails = <String>{};

  Future<UserModel> login(LoginRequestEntity request) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final email = request.email?.trim().toLowerCase() ?? '';
    final password = (request.password ?? '').trim();
    final index = _users.indexWhere((u) => u.email.toLowerCase() == email);
    if (index == -1) {
      if (!_isValidEmail(email)) {
        throw 'Invalid email format';
      }
      if (password.length < 8) {
        throw 'Password must be at least 8 characters';
      }

      final user = UserModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        firstName: 'Dummy',
        lastName: 'User',
        email: email,
        password: password,
        gender: 'male',
        age: 22,
        weight: 70,
        height: 172,
        activityLevel: 'rookie',
        goal: 'fitness',
        photo: null,
        createdAt: DateTime.now().toIso8601String(),
      );
      _users.add(user);
      return user;
    }
    final user = _users[index];
    if (user.password != password) {
      throw 'Wrong password';
    }
    return user;
  }

  Future<UserModel> register(RegisterRequestEntity request) async {
    await Future.delayed(const Duration(milliseconds: 900));
    final email = request.email?.trim().toLowerCase() ?? '';
    final password = request.password ?? '';
    if (!_isValidEmail(email)) {
      throw 'Invalid email format';
    }
    if (password.length < 8) {
      throw 'Password must be at least 8 characters';
    }
    final alreadyExists = _users.any((u) => u.email.toLowerCase() == email);
    if (alreadyExists) {
      throw 'Email is already registered';
    }
    final user = UserModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      firstName: request.firstName?.trim().isNotEmpty == true
          ? request.firstName!.trim()
          : 'User',
      lastName: request.lastName?.trim().isNotEmpty == true
          ? request.lastName!.trim()
          : 'Account',
      email: email,
      password: password,
      gender: request.gender ?? 'male',
      age: request.age ?? 18,
      weight: request.weight ?? 70,
      height: request.height ?? 170,
      activityLevel: request.activityLevel ?? 'rookie',
      goal: request.goal ?? 'fitness',
      photo: null,
      createdAt: DateTime.now().toIso8601String(),
    );
    _users.add(user);
    return user;
  }

  Future<ForgetPasswordResponseEntity> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final email = request.email?.trim().toLowerCase() ?? '';
    final userExists = _users.any((u) => u.email.toLowerCase() == email);
    if (!userExists) {
      throw 'User not found';
    }
    const resetCode = '123456';
    _resetCodesByEmail[email] = resetCode;
    return ForgetPasswordResponseEntity(
      message: 'Reset code sent successfully',
      info: resetCode,
    );
  }

  Future<EmailVerificationEntity> verifyResetCode(
    EmailVerificationRequestEntity request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 650));
    final code = request.resetCode?.trim() ?? '';
    final matched = _resetCodesByEmail.entries.where((e) => e.value == code);
    if (matched.isEmpty) {
      throw 'Invalid reset code';
    }
    final email = matched.first.key;
    _verifiedResetEmails.add(email);
    return EmailVerificationEntity(status: 'verified');
  }

  Future<ResetPasswordResponseEntity> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    await Future.delayed(const Duration(milliseconds: 850));
    final email = request.email?.trim().toLowerCase() ?? '';
    final newPassword = request.newPassword ?? '';
    if (newPassword.length < 8) {
      throw 'Password must be at least 8 characters';
    }
    if (!_verifiedResetEmails.contains(email)) {
      throw 'Reset code is not verified';
    }
    final index = _users.indexWhere((u) => u.email.toLowerCase() == email);
    if (index == -1) {
      throw 'User not found';
    }
    _users[index] = _users[index].copyWith(password: newPassword);
    _verifiedResetEmails.remove(email);
    _resetCodesByEmail.remove(email);
    return ResetPasswordResponseEntity(
      message: 'Password reset successfully',
      token: 'dummy-token-${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }
}
