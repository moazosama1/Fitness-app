import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:elevate_super_fitness/presentation/workout_page/view/widgets/list_workouts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import '../../../../core/di/di.dart';
import '../../view_model/workout_event.dart';
import '../../view_model/workout_states.dart';
import '../../view_model/workout_view_model.dart';
import '../widgets/custom_tab_bar.dart';

class WorkoutsPage extends StatefulWidget {
  final MainHomeViewModel mainHomeViewModel;
  final String? selectedTebId;

  const WorkoutsPage({
    super.key,
    required this.mainHomeViewModel,
    required this.selectedTebId,
  });

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String? _selectedMuscleId;

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      key: const ValueKey('workouts page'),
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          widget.mainHomeViewModel.doIntent(
            OnScrollUpdateEvent(
              notification.metrics.pixels,
              notification.scrollDelta ?? 0,
            ),
          );
        }
        return true;
      },
      child: BlocProvider(
        create: (_) => getIt<WorkoutViewModel>()..doIntent(WorkoutEvent()),
        child: BlocBuilder<WorkoutViewModel, WorkoutStates>(
          builder: (context, state) {
            final musclesGroup = state.musclesGroup?.data?.musclesGroup ?? [];

            if (musclesGroup.isEmpty) {
              return Column(
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: Text(
                      AppLocalizations.of(context).workouts,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildShimmerList(40.h, 104.w),
                  ),
                  Expanded(child: buildShimmerGridWorkoutsItems()),
                ],
              );
            }

            int selectedIndex = musclesGroup.indexWhere(
              (element) => element.id == widget.selectedTebId,
            );
            if (selectedIndex < 0) selectedIndex = 0;

            if (_tabController == null) {
              _tabController = TabController(
                length: musclesGroup.length,
                vsync: this,
                initialIndex: selectedIndex,
              );

              _selectedMuscleId = musclesGroup[selectedIndex].id;

              context.read<WorkoutViewModel>().doIntent(
                MusclesEvent(id: _selectedMuscleId ?? ""),
              );
              _tabController!.addListener(() {
                if (!_tabController!.indexIsChanging) {
                  final newMuscleId = musclesGroup[_tabController!.index].id;
                  if (newMuscleId != _selectedMuscleId) {
                    _selectedMuscleId = newMuscleId;
                    context.read<WorkoutViewModel>().doIntent(
                      MusclesEvent(id: newMuscleId ?? ""),
                    );
                  }
                }
              });
            }

            return Column(
              children: [
                SizedBox(height: 40.h),
                Center(
                  child: Text(
                    AppLocalizations.of(context).workouts,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                  ),
                ),
                SizedBox(height: 24.h),

                CustomTabBarPage(
                  isLoading: state.musclesGroup?.isLoading ?? false,
                  tabController: _tabController!,
                  tabs: musclesGroup.map((e) => e.name ?? '').toList(),
                ),

                ListWorkoutsItem(
                  musclesGroups:
                      state.musclesGroupDetailsById?.data?.musclesEntity ?? [],
                  isLoading: state.musclesGroupDetailsById?.isLoading ?? true,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

