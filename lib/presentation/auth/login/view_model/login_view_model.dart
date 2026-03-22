import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/domain/entites/requests/login_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/login_use_case.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_view_model_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginViewModelState> {
  LoginViewModel(this._loginUseCase) : super(const LoginViewModelState());
  final LoginUseCase _loginUseCase;
  void doIntent(LoginViewModelEvent event) {
    switch (event) {
      case LoginViewModelSignInEvent():
        _login();
      case LoginViewModelVisiblePasswordEvent():
        _viewPassword();
    }
  }

  ValueNotifier<bool> passwordVisible = ValueNotifier(true);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void _viewPassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> _login() async {
    emit(state.copyWith(loginState: BaseState.loading()));
    final result = await _loginUseCase.call(
      LoginRequestEntity(
        email: emailController.text,
        password: passwordController.text,
        rememberMe: true,
      ),
    );
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(state.copyWith(loginState: BaseState.success(result.data)));
      case ApiErrorResult<UserEntity>():
        emit(state.copyWith(loginState: BaseState.error(result.errorMessage)));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    passwordVisible.dispose();
    return super.close();
  }
}
