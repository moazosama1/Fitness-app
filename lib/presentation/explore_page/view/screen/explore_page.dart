import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/di/di.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/explore_page_body.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view_model/explore_event.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view_model/explore_view_model_cubit.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatefulWidget {
  final MainHomeViewModel mainHomeViewModel;
  const ExplorePage({super.key, required this.mainHomeViewModel});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late ExploreViewModelCubit viewModel;
  @override
  void initState() {
    viewModel = getIt.get<ExploreViewModelCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.doIntent(ExploreGetAllDataEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      key: const Key(WidgetsKeys.kExploreScreenMainKey),
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
        create: (context) => viewModel,
        child: SafeArea(
          child: ExplorePageBody(mainHomeViewModel: widget.mainHomeViewModel),
        ),
      ),
    );
  }
}
