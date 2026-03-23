import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/auth/register/view/widgets/custom_register_page.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/enums/gender_enum.dart';
import '../../view_model/register_events.dart';
import '../../view_model/register_view_model.dart';

class RegisterGenderPage extends StatelessWidget {
  final RegisterViewModel registerViewModel;

  const RegisterGenderPage({super.key, required this.registerViewModel});

  @override
  Widget build(BuildContext context) {
    return CustomRegisterPage(
      registerViewModel: registerViewModel,
      title: AppLocalizations.of(context).tellUsAboutYourself,
      desc: AppLocalizations.of(context).weNeedToKnowYourGender,
      child: ValueListenableBuilder(
        valueListenable: registerViewModel.selectedGender,
        builder: (context, value, child) {
          return Column(
            spacing: 24.h,
            children: [
              genderWidget(
                context: context,
                image: AppImages.maleImage,
                title: AppLocalizations.of(context).male,
                selected: value == GenderEnum.male,
              ),
              genderWidget(
                context: context,
                image: AppImages.femaleImage,
                title: AppLocalizations.of(context).female,
                selected: value == GenderEnum.female,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget genderWidget({
    required BuildContext context,
    required String image,
    required String title,
    required bool selected,
  }) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: () {
        registerViewModel.doIntent(ToggleRegisterGenderEvent());
      },
      child: Container(
        width: 95.sp,
        height: 95.sp,
        decoration: BoxDecoration(
          color: selected ? AppColors.mainColorL : null,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? AppColors.mainColorL : AppColors.white,
            width: 1.0,
          ),
        ),
        child: Column(
          children: [
            Expanded(child: SvgPicture.asset(image)),
            Text(
              title,
              style: context.bodyLarge?.copyWith(
                fontSize: 12.sp,
                color: AppColors.white,
              ),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
}

