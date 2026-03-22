import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';
import '../entites/requests/register_request_entity.dart';
import '../entites/requests/email_verification_request_entity.dart';
import '../entites/requests/forget_password_request_entity.dart';
import '../entites/requests/reset_password_request_entity.dart';
import '../entites/email_verification_entity.dart';
import '../entites/forget_password_response_entity.dart';
import '../entites/reset_password_response_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<UserEntity>> login({required LoginRequestEntity request});
  Future<ApiResult<UserEntity>> register(RegisterRequestEntity request);
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  );

  Future<ApiResult<EmailVerificationEntity>> verifyResetCode(
    EmailVerificationRequestEntity request,
  );

  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
}
