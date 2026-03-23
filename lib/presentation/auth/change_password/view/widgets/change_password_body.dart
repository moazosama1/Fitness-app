import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_auth_bg.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_dialog.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_glass_shape_widget.dart';
import 'package:elevate_super_fitness/presentation/auth/change_password/view/widgets/custom_title_page.dart';
import 'package:elevate_super_fitness/presentation/auth/change_password/view/widgets/section_text_field_to_change_password.dart';
import 'package:elevate_super_fitness/presentation/auth/change_password/view_model/change_password_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  late GlobalKey<FormState> _globalKey;
  @override
  void initState() {
    _globalKey = GlobalKey<FormState>();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePasswordViewModel, ChangePasswordViewModelState>(
      listener: (context, state) {
        if (state.changePasswordResponse?.isLoading == true) {
          CustomDialog.fitnessLoading(context: context);
        } else {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          final response = state.changePasswordResponse;
          if (response?.data != null) {
            CustomDialog.fitnessPositiveButton(
              context: context,
              message: state.changePasswordResponse!.data!.message,
            );
          } else if (response?.errorMessage != null) {
            CustomDialog.fitnessPositiveButton(
              context: context,
              message: state.changePasswordResponse!.errorMessage,
            );
          }
        }
      },
      child: CustomAuthBg(
        arrowIconPath: AppIcons.arrowBackIcon,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 39.h),
              const CustomTitlePage(
                key: Key(WidgetsKeys.kChangePasswordScreenWidgetTitleKey),
              ),
              CustomGlassShapeWidget(
                key: const Key(WidgetsKeys.kChangePasswordSectionFormFieldKey),
                child: SectionTextFieldToChangePassword(
                  oldPasswordController: oldPasswordController,
                  newPasswordController: newPasswordController,
                  confirmPasswordController: confirmPasswordController,
                  globalKey: _globalKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

