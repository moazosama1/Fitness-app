import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/enums/change_password.dart';
import 'package:elevate_super_fitness/domain/entites/change_password_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/requests/change_password_request_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/change_password_use_case.dart';
import 'package:elevate_super_fitness/presentation/auth/change_password/view_model/change_password_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_password_view_model_state.dart';

@lazySingleton
class ChangePasswordViewModel extends Cubit<ChangePasswordViewModelState> {
  ChangePasswordViewModel(this._changePasswordUseCase)
    : super(const ChangePasswordViewModelState());
  final ChangePasswordUseCase _changePasswordUseCase;
  void doIntent(ChangePasswordEvent event) {
    switch (event) {
      case ChangePasswordExecuteEvent():
        _changePassword(request: event.request);
      case ChangePasswordShowIconEvent():
        _showIcon(event.enumEvent);
    }
  }

  void _showIcon(ChangePasswordEnum iconName) {
    if (iconName == ChangePasswordEnum.oldPassword) {
      showOldPassword.value = !showOldPassword.value;
    }
    if (iconName == ChangePasswordEnum.newPassword) {
      showNewPassword.value = !showNewPassword.value;
    }
    if (iconName == ChangePasswordEnum.confirmPassword) {
      showConfirmPassword.value = !showConfirmPassword.value;
    }
  }

  ValueNotifier<bool> showOldPassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> showNewPassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> showConfirmPassword = ValueNotifier<bool>(true);
  Future<void> _changePassword({
    required ChangePasswordRequestEntity request,
  }) async {
    emit(
      state.copyWith(
        changePasswordResponse:
            BaseState<ChangePasswordResponseEntity>.loading(),
      ),
    );
    final result = await _changePasswordUseCase.call(request);
    switch (result) {
      case ApiSuccessResult<ChangePasswordResponseEntity>():
        emit(
          state.copyWith(
            changePasswordResponse:
                BaseState<ChangePasswordResponseEntity>.success(result.data),
          ),
        );
      case ApiErrorResult<ChangePasswordResponseEntity>():
        emit(
          state.copyWith(
            changePasswordResponse:
                BaseState<ChangePasswordResponseEntity>.error(
                  result.errorMessage,
                ),
          ),
        );
    }
  }

  @override
  Future<void> close() {
    showOldPassword.dispose();
    showNewPassword.dispose();
    showConfirmPassword.dispose();
    return super.close();
  }
}
