import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/data/data_source/auth_dummy_data_source.dart';
import 'package:elevate_super_fitness/data/data_source/auth_local_data_source.dart';
import 'package:elevate_super_fitness/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/register_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entites/requests/email_verification_request_entity.dart';
import '../../domain/entites/requests/forget_password_request_entity.dart';
import '../../domain/entites/requests/reset_password_request_entity.dart';
import '../../domain/entites/email_verification_entity.dart';
import '../../domain/entites/forget_password_response_entity.dart';
import '../../domain/entites/reset_password_response_entity.dart';
import '../../domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthDummyDataSource _authDummyDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepoImpl(this._authDummyDataSource, this._authLocalDataSource);
  @override
  Future<ApiResult<UserEntity>> login({
    required LoginRequestEntity request,
  }) async {
    try {
      final user = await _authDummyDataSource.login(request);
      await _authLocalDataSource.saveLoginData(
        rememberMe: request.rememberMe,
        token: 'dummy-token-${user.id}',
      );
      return ApiSuccessResult<UserEntity>(user.toEntity());
    } catch (error) {
      return ApiErrorResult<UserEntity>(error);
    }
  }

  @override
  Future<ApiResult<UserEntity>> register(RegisterRequestEntity request) async {
    try {
      final user = await _authDummyDataSource.register(request);
      return ApiSuccessResult<UserEntity>(user.toEntity());
    } catch (error) {
      return ApiErrorResult<UserEntity>(error);
    }
  }

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) {
    return _run(() => _authDummyDataSource.forgetPassword(request));
  }

  @override
  Future<ApiResult<EmailVerificationEntity>> verifyResetCode(
    EmailVerificationRequestEntity request,
  ) {
    return _run(() => _authDummyDataSource.verifyResetCode(request));
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    return _run(() => _authDummyDataSource.resetPassword(request));
  }

  Future<ApiResult<T>> _run<T>(Future<T> Function() action) async {
    try {
      final data = await action();
      return ApiSuccessResult<T>(data);
    } catch (error) {
      return ApiErrorResult<T>(error);
    }
  }
}
