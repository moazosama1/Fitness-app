import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/validations.dart';
import '../../../../generated/l10n.dart';
import '../../view_model/edit_profile_events.dart';
import '../../view_model/edit_profile_view_model.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = context.read<EditProfileViewModel>();
    return Column(
      spacing: 16.h,
      children: [
        buildTextFormField(
          context: context,
          controller: editProfileViewModel.firstNameController,
          validator: Validations.validateFullName,
          icon: Icons.person_outline_outlined,
          hint: AppLocalizations.of(context).firstName,
          editProfileViewModel: editProfileViewModel,
        ),
        buildTextFormField(
          context: context,
          controller: editProfileViewModel.lastNameController,
          validator: Validations.validateFullName,
          icon: Icons.person_outline_outlined,
          hint: AppLocalizations.of(context).lastName,
          editProfileViewModel: editProfileViewModel,
        ),
        buildTextFormField(
          context: context,
          controller: editProfileViewModel.emailController,
          validator: Validations.validateEmail,
          icon: Icons.email_outlined,
          hint: AppLocalizations.of(context).email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          editProfileViewModel: editProfileViewModel,
        ),
      ],
    );
  }

  Widget buildTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    required EditProfileViewModel editProfileViewModel,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.backGroundL[90]),
        hintText: hint,
        hintStyle: context.bodySmall?.copyWith(
          color: AppColors.backGroundL[90],
        ),
      ),
      style: context.bodySmall?.copyWith(color: AppColors.white),
      keyboardType: keyboardType ?? TextInputType.name,
      textInputAction: textInputAction ?? TextInputAction.next,
      onChanged: (value){
        editProfileViewModel.doIntent(ToggleButtonStatusProfileEvent());
      },
    );
  }
}

