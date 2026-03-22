import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/domain/entites/email_verification_entity.dart';
import 'package:elevate_super_fitness/domain/entites/forget_password_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/email_verification_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/forget_password_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/reset_password_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/reset_password_response_entity.dart';
import 'package:elevate_super_fitness/presentation/auth/forget_password/view_model/forget_password_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/api_result/api_result.dart';
import '../../../../domain/use_cases/email_verification_use_case.dart';
import '../../../../domain/use_cases/forget_password_use_case.dart';
import '../../../../domain/use_cases/reset_password_use_case.dart';
import 'forget_password_events.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._emailVerificationUseCase,
    this._resetPasswordUseCase,
  ) : super(const ForgetPasswordState());

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final EmailVerificationUseCase _emailVerificationUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> verifyResetCodeFormKey = GlobalKey<FormState>();
  final TextEditingController resetCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  void doIntent(ForgetPasswordEvents event) {
    switch (event) {
      case ForgetPasswordEvent():
        _forgetPassword(emailController.text);
      case VerifyResetCodeEvent():
        _verifyResetCode(event.otpCode);
      case ResetPasswordEvent():
        _resetPassword(newPasswordController.text);
      case ResendOtpEvent():
        _resendCode(emailController.text);
    }
  }

  Future<void> _resendCode(String email) async {
    if (email.isEmpty) return;
    emit(
      state.copyWith(
        requestEmailState: BaseState.loading(),
        verifyCodeState: null,
        resetPasswordState: null,
      ),
    );

    final result = await _forgetPasswordUseCase(
      ForgetPasswordRequestEntity(email: email),
    );

    switch (result) {
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            requestEmailState: BaseState.success(result.data),
            verifyCodeState: null,
            resetPasswordState: null,
          ),
        );
        break;

      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            requestEmailState: BaseState.error(result.errorMessage),
            verifyCodeState: null,
            resetPasswordState: null,
          ),
        );
        break;
    }
  }

  Future<void> _forgetPassword(String email) async {
    if (email.isEmpty) return;
    emit(
      state.copyWith(
        requestEmailState: BaseState.loading(),
        verifyCodeState: null,
        resetPasswordState: null,
      ),
    );

    final result = await _forgetPasswordUseCase(
      ForgetPasswordRequestEntity(email: email),
    );

    switch (result) {
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            requestEmailState: BaseState.success(result.data),
            verifyCodeState: null,
            resetPasswordState: null,
          ),
        );
        break;

      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(
          state.copyWith(
            requestEmailState: BaseState.error(result.errorMessage),
            verifyCodeState: null,
            resetPasswordState: null,
          ),
        );
        break;
    }
  }

  Future<void> _verifyResetCode(String otbCode) async {
    if (otbCode.isEmpty) return;
    emit(
      state.copyWith(
        verifyCodeState: BaseState.loading(),
        resetPasswordState: null,
      ),
    );

    final result = await _emailVerificationUseCase(
      EmailVerificationRequestEntity(resetCode: otbCode),
    );

    switch (result) {
      case ApiSuccessResult<EmailVerificationEntity>():
        emit(state.copyWith(verifyCodeState: BaseState.success(result.data)));
        break;

      case ApiErrorResult<EmailVerificationEntity>():
        emit(
          state.copyWith(verifyCodeState: BaseState.error(result.errorMessage)),
        );
        break;
    }
  }

  Future<void> _resetPassword(String newPassword) async {
    if (newPassword.isEmpty) return;
    emit(state.copyWith(resetPasswordState: BaseState.loading()));

    final email = emailController.text.trim();

    final result = await _resetPasswordUseCase(
      ResetPasswordRequestEntity(
        email: email,
        newPassword: newPassword,
      ),
    );
    switch (result) {
      case ApiSuccessResult<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(resetPasswordState: BaseState.success(result.data)),
        );
      case ApiErrorResult<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            resetPasswordState: BaseState.error(result.errorMessage),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    resetCodeController.dispose();
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
