import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_user_logged_data_use_case.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@singleton
class MainHomeViewModel extends Cubit<MainHomeStates> {
  MainHomeViewModel(GetUserLoggedDataUseCase userLoggedDataUseCase)
    : super(const MainHomeStates());
  static const Duration _fakeDelay = Duration(milliseconds: 350);

  final PageController pageController = PageController();
  String? selectedTabIdWorkouts = "";
  void doIntent(MainHomeEvent event) {
    switch (event) {
      case OnBottomNavBarTappedEvent():
        _bottomNavBarOnTap(event.index);
        selectedTabIdWorkouts = event.selectedTabId;
        break;
      case OnPageChangedEvent():
        _onPageChanged(event.index);
        break;
      case OnScrollUpdateEvent():
        _handleScroll(event.pixels, event.scrollDelta);
        break;
      case GetUserInfoMainHomeEvent():
        _getUserData();
    }
  }

  Future<void> _getUserData() async {
    emit(state.copyWith(userInfo: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    emit(state.copyWith(userInfo: BaseState.success(AppFakeData.profileUser)));
  }

  void _bottomNavBarOnTap(int index) {
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
    emit(state.copyWith(selectedIndex: index));
  }

  void _onPageChanged(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void _handleScroll(double pixels, double delta) {
    if (pixels > 50 && delta > 0 && state.isBottomBarVisible) {
      emit(state.copyWith(isBottomBarVisible: false));
    } else if (delta < 0 && !state.isBottomBarVisible) {
      emit(state.copyWith(isBottomBarVisible: true));
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
