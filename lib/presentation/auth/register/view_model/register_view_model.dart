import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/enums/gender_enum.dart';
import 'package:elevate_super_fitness/core/enums/goal_enum.dart';
import 'package:elevate_super_fitness/domain/entites/requests/register_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/register_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/enums/level_enum.dart';
import 'register_events.dart';

part 'register_state.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase) : super(const RegisterState());

  PageController pageController = PageController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ValueNotifier<bool> isPasswordVisible = ValueNotifier<bool>(false);

  ValueNotifier<int> selectedPage = ValueNotifier<int>(0);

  ValueNotifier<GenderEnum> selectedGender = ValueNotifier<GenderEnum>(
    GenderEnum.male,
  );

  ValueNotifier<int> selectedAge = ValueNotifier<int>(15);
  ValueNotifier<int> selectedWeight = ValueNotifier<int>(80);
  ValueNotifier<int> selectedHeight = ValueNotifier<int>(170);

  ValueNotifier<GoalEnum> selectedGoal = ValueNotifier<GoalEnum>(
    GoalEnum.gainWeight,
  );

  ValueNotifier<LevelEnum> selectedLevel = ValueNotifier<LevelEnum>(
    LevelEnum.rookie,
  );

  ValueNotifier<double> registerProgress = ValueNotifier<double>(4);

  void doIntent(RegisterEvents events) {
    switch (events) {
      case ToggleRegisterPasswordVisibilityEvent():
        _togglePasswordVisibility();
      case ToggleRegisterGenderEvent():
        _toggleGender();
      case ChangeRegisterGoalEvent():
        _changeGoal(events.goal);
      case ChangeRegisterLevelEvent():
        _changeLevel(events.level);
      case RegisterNextPageEvent():
        _nextPage();
      case RegisterPreviousPageEvent():
        _previousPage();
      case ChangeRegisterPageEvent():
        _changePage(events.page);
      case ChangeRegisterAgeEvent():
        _changeAge(events.age);
      case ChangeRegisterWeightEvent():
        _changeWeight(events.weight);
      case ChangeRegisterHeightEvent():
        _changeHeight(events.height);
    }
  }

  void _togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void _toggleGender() {
    selectedGender.value = selectedGender.value == GenderEnum.male
        ? GenderEnum.female
        : GenderEnum.male;
  }

  void _changeAge(int age) {
    selectedAge.value = age;
  }

  void _changeWeight(int weight) {
    selectedWeight.value = weight;
  }

  void _changeHeight(int height) {
    selectedHeight.value = height;
  }

  void _changeGoal(GoalEnum goal) {
    selectedGoal.value = goal;
  }

  void _changeLevel(LevelEnum level) {
    selectedLevel.value = level;
  }

  void _nextPage() {
    if (selectedPage.value >= 6) {
      _register();
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _changePage(int page) {
    selectedPage.value = page;
    _updateRegisterProgress();
  }

  void _updateRegisterProgress() {
    registerProgress.value = selectedPage.value / 6;
  }

  Future<void> _register() async {
    emit(state.copyWith(registerState: BaseState.loading()));
    final result = await _registerUseCase(
      RegisterRequestEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        rePassword: passwordController.text,
        gender: selectedGender.value.name,
        age: selectedAge.value,
        weight: selectedWeight.value,
        height: selectedHeight.value,
        goal: selectedGoal.value.value,
        activityLevel: selectedLevel.value.value,
      ),
    );
    switch (result) {
      case ApiSuccessResult<UserEntity>():
        emit(state.copyWith(registerState: BaseState.success(result.data)));
        break;
      case ApiErrorResult<UserEntity>():
        emit(
          state.copyWith(registerState: BaseState.error(result.errorMessage)),
        );
        break;
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    isPasswordVisible.dispose();
    selectedPage.dispose();
    selectedGender.dispose();
    selectedAge.dispose();
    selectedWeight.dispose();
    selectedHeight.dispose();
    selectedGoal.dispose();
    selectedLevel.dispose();
    pageController.dispose();
    return super.close();
  }
}
