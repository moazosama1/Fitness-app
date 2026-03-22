import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/domain/entites/email_verification_entity.dart';
import 'package:elevate_super_fitness/domain/entites/forget_password_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/reset_password_response_entity.dart';
import 'package:equatable/equatable.dart';

class ForgetPasswordState extends Equatable {
  static const _unset = Object();

  final BaseState<ForgetPasswordResponseEntity>? requestEmailState;
  final BaseState<EmailVerificationEntity>? verifyCodeState;
  final BaseState<ResetPasswordResponseEntity>? resetPasswordState;

  const ForgetPasswordState({
    this.requestEmailState,
    this.verifyCodeState,
    this.resetPasswordState,
  });

  ForgetPasswordState copyWith({
    Object? requestEmailState = _unset,
    Object? verifyCodeState = _unset,
    Object? resetPasswordState = _unset,
  }) {
    return ForgetPasswordState(
      requestEmailState: requestEmailState == _unset
          ? this.requestEmailState
          : requestEmailState as BaseState<ForgetPasswordResponseEntity>?,
      verifyCodeState: verifyCodeState == _unset
          ? this.verifyCodeState
          : verifyCodeState as BaseState<EmailVerificationEntity>?,
      resetPasswordState: resetPasswordState == _unset
          ? this.resetPasswordState
          : resetPasswordState as BaseState<ResetPasswordResponseEntity>?,
    );
  }

  @override
  List<Object?> get props => [
    requestEmailState,
    verifyCodeState,
    resetPasswordState,
  ];
}
