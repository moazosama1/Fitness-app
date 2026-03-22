import 'package:bloc_test/bloc_test.dart';
import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/login_use_case.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy/login_dummy_data.dart';
import 'login_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  group("Login view model test state", () {
    late LoginUseCase loginUseCase;
    late LoginViewModelState state;
    late LoginViewModel viewModel;
    final requestEntity = LoginDummyData.dummyLoginRequestEntity;
    final responseEntity = LoginDummyData.dummyUserEntity;
    final exception = LoginDummyData.dummyException;
    setUp(() {
      loginUseCase = MockLoginUseCase();
      viewModel = LoginViewModel(loginUseCase);
      state = const LoginViewModelState();
      provideDummy<ApiResult<UserEntity>>(ApiSuccessResult(responseEntity));
      provideDummy<ApiResult<UserEntity>>(ApiErrorResult(responseEntity));
    });
    blocTest<LoginViewModel, LoginViewModelState>(
      "test login function emit success",
      build: () {
        viewModel.emailController.text = requestEntity.email!;
        viewModel.passwordController.text = requestEntity.password!;
        when(
          loginUseCase.call(requestEntity),
        ).thenAnswer((_) async => ApiSuccessResult<UserEntity>(responseEntity));
        return viewModel;
      },
      act: (viewModel) => viewModel.doIntent(LoginViewModelSignInEvent()),

      expect: () => [
        state.copyWith(loginState: BaseState.loading()),
        state.copyWith(loginState: BaseState.success(responseEntity)),
      ],
      verify: (viewModel) {
        verify(loginUseCase.call(requestEntity)).called(1);
      },
    );
    blocTest<LoginViewModel, LoginViewModelState>(
      "test login function emit error",
      build: () {
        viewModel.emailController.text = requestEntity.email!;
        viewModel.passwordController.text = requestEntity.password!;
        when(
          loginUseCase.call(requestEntity),
        ).thenAnswer((_) async => ApiErrorResult<UserEntity>(exception));
        return viewModel;
      },
      act: (viewModel) => viewModel.doIntent(LoginViewModelSignInEvent()),
      expect: () => [
        state.copyWith(loginState: BaseState.loading()),
        state.copyWith(loginState: BaseState.error(exception.toString())),
      ],
      verify: (viewModel) {
        verify(loginUseCase.call(requestEntity)).called(1);
      },
    );
  });
}
