import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elevate_super_fitness/core/api_result/api_result.dart';
import 'package:elevate_super_fitness/domain/entites/requests/edit_profile_request_entity.dart';
import 'package:elevate_super_fitness/domain/entites/user_info_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/edit_user_profile_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_user_logged_data_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/upload_user_photo_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../core/enums/goal_enum.dart';
import '../../../core/enums/level_enum.dart';
import 'edit_profile_events.dart';

part 'edit_profile_state.dart';

@injectable
class EditProfileViewModel extends Cubit<EditProfileState> {
  final GetUserLoggedDataUseCase _getUserLoggedDataUseCase;
  final EditUserProfileUseCase _editUserProfileUseCase;
  final UploadUserPhotoUseCase _uploadUserPhotoUseCase;

  EditProfileViewModel(
    this._getUserLoggedDataUseCase,
    this._editUserProfileUseCase,
    this._uploadUserPhotoUseCase,
  ) : super(const EditProfileState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ValueNotifier isButtonEnabled = ValueNotifier(false);

  int selectedWeight = 80;
  GoalEnum selectedGoal = GoalEnum.gainWeight;
  LevelEnum selectedLevel = LevelEnum.rookie;

  void doIntent(EditProfileEvents events) {
    switch (events) {
      case GetUserDataProfileEvent():
        _getUserLoggedData();
        break;
      case ToggleButtonStatusProfileEvent():
        _toggleButtonStatus();
        break;
      case UploadUserPhotoProfileEvent():
        _uploadUserPhoto();
        break;
      case UpdateUserProfileEvent():
        _editUserProfile(events.isBodyInfo);
        break;
    }
  }

  Future<void> _getUserLoggedData() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getUserLoggedDataUseCase();
    switch (result) {
      case ApiSuccessResult<UserInfoEntity>():
        _initUserData(result.data);
        emit(state.copyWith(isLoading: false, userData: result.data));
        break;
      case ApiErrorResult<UserInfoEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
        break;
    }
  }

  void _initUserData(UserInfoEntity userData) {
    firstNameController.text = userData.firstName ?? "";
    lastNameController.text = userData.lastName ?? "";
    emailController.text = userData.email ?? "";
    selectedWeight = userData.weight?.toInt() ?? 0;
    selectedGoal = goalFromValue(userData.goal ?? "");
    selectedLevel = levelFromValue(userData.activityLevel ?? "");
  }

  void _toggleButtonStatus() {
    final String firstName = state.userData?.firstName ?? "";
    final String updatedFirstName = firstNameController.text.trim();
    final String lastName = state.userData?.lastName ?? "";
    final String updatedLastName = lastNameController.text.trim();
    final String email = state.userData?.email ?? "";
    final String updatedEmail = emailController.text.trim();

    if (updatedFirstName.isNotEmpty && updatedFirstName != firstName ||
        updatedLastName.isNotEmpty && updatedLastName != lastName ||
        updatedEmail.isNotEmpty && updatedEmail != email) {
      isButtonEnabled.value = true;
    } else {
      isButtonEnabled.value = false;
    }
  }

  Future<void> _uploadUserPhoto() async {
    emit(state.copyWith(isUserPhotoLoading: true));
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      emit(state.copyWith(isUserPhotoLoading: false));
      return;
    }

    final file = File(image.path);
    final multipart = await MultipartFile.fromFile(file.path);
    final result = await _uploadUserPhotoUseCase(photo: multipart);
    switch (result) {
      case ApiSuccessResult<String>():
        emit(state.copyWith(isUserPhotoLoading: false, pickedImage: file));
        break;
      case ApiErrorResult<String>():
        emit(
          state.copyWith(
            isUserPhotoLoading: false,
            errorMessage: result.errorMessage,
          ),
        );
        break;
    }
  }

  Future<void> _editUserProfile(bool isBodyInfo) async {
    emit(state.copyWith(isLoading: true));
    final result = await _editUserProfileUseCase(
      request: EditProfileRequestEntity(
        firstName: isBodyInfo
            ? state.userData?.firstName
            : firstNameController.text.trim(),
        lastName: isBodyInfo
            ? state.userData?.lastName
            : lastNameController.text.trim(),
        email: isBodyInfo ? state.userData?.email : emailController.text.trim(),
        weight: selectedWeight,
        goal: selectedGoal.value,
        activityLevel: selectedLevel.value,
      ),
    );

    switch (result) {
      case ApiSuccessResult<UserInfoEntity>():
        _initUserData(result.data);
        isButtonEnabled.value = false;
        emit(state.copyWith(isLoading: false, userData: result.data));
        break;
      case ApiErrorResult<UserInfoEntity>():
        emit(
          state.copyWith(isLoading: false, errorMessage: result.errorMessage),
        );
    }
  }

  GoalEnum goalFromValue(String text) {
    return GoalEnum.values.firstWhere(
      (g) => g.value == text,
      orElse: () => GoalEnum.gainWeight,
    );
  }

  LevelEnum levelFromValue(String text) {
    return LevelEnum.values.firstWhere(
      (l) => l.value == text,
      orElse: () => LevelEnum.rookie,
    );
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    isButtonEnabled.dispose();
    return super.close();
  }
}
