import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/custom_widget/custom_cached_network_image.dart';
import '../../view_model/edit_profile_events.dart';
import '../../view_model/edit_profile_view_model.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = context.read<EditProfileViewModel>();
    final editProfileState = editProfileViewModel.state;
    return Column(
      spacing: 8.h,
      children: [
        InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            editProfileViewModel.doIntent(UploadUserPhotoProfileEvent());
          },
          child: Container(
            width: 100.sp,
            height: 100.sp,
            decoration: BoxDecoration(
              color: AppColors.backGroundL.withAlpha(20),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mainColorL.withAlpha(25),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: BlocBuilder<EditProfileViewModel, EditProfileState>(
                    builder: (context, state) {
                      if (state.isUserPhotoLoading == true ||
                          state.isLoading == true) {
                        return buildShimmerEditImage();
                      }
                      if (state.pickedImage != null) {
                        return Image.file(
                          state.pickedImage!,
                          fit: BoxFit.cover,
                        ).setOpacity(opacity: .5);
                      }
                      return CustomCachedNetworkImage(
                        imageUrl: state.userData?.photo ?? "",
                        fit: BoxFit.cover,
                      ).setOpacity(opacity: .5);
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SvgPicture.asset(
                    AppIcons.editIcon,
                    width: 20.sp,
                    height: 20.sp,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          "${editProfileState.userData?.firstName ?? ""} ${editProfileState.userData?.lastName ?? ""}",
          style: context.bodyLarge?.copyWith(color: AppColors.white),
        ),
      ],
    );
  }
}

