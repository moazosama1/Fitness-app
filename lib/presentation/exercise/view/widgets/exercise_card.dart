import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/constant_dummy_image.dart';
import 'package:elevate_super_fitness/domain/entites/get_selected_exercise_entity.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseCard extends StatelessWidget {
  final GetSelectedExerciseEntity exerciseEntity;
  final bool isFirstIndex;
  final bool isLastIndex;
  const ExerciseCard({
    super.key,
    required this.exerciseEntity,
    required this.isFirstIndex,
    required this.isLastIndex,
  });

  @override
  Widget build(BuildContext context) {
    const thumbnailAsset = AppDummyImage.dummyImageFitness8;

    return Container(
      width: double.infinity,
      height: 101,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.backGroundL.withOpacity(0.8),
        border: const Border(
          bottom: BorderSide(width: 1, color: AppColors.darkGray),
        ),
        borderRadius: BorderRadius.only(
          topLeft: isFirstIndex ? const Radius.circular(20) : Radius.zero,
          topRight: isFirstIndex ? const Radius.circular(20) : Radius.zero,
          bottomLeft: isLastIndex ? const Radius.circular(20) : Radius.zero,
          bottomRight: isLastIndex ? const Radius.circular(20) : Radius.zero,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              thumbnailAsset,
              width: 80,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    exerciseEntity.exercise ??
                        AppLocalizations.of(context).exercise,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.pureWhite,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  flex: 3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(
                                context,
                              ).numberOfExerciseGroups,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.pureWhite,
                                  ),
                            ),
                            Text(
                              AppLocalizations.of(
                                context,
                              ).loremIpsumDolorSitAmetconsecteturTempus,
                              style: Theme.of(context).textTheme.bodySmall!
                                  .copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.pureWhite,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          final videoId = YoutubePlayer.convertUrlToId(
                            exerciseEntity.inDepthYoutubeExplanationLink ??
                                exerciseEntity.shortYoutubeDemonstrationLink ??
                                "",
                          );

                          if (videoId != null) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.all(16),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: YoutubePlayerBuilder(
                                      player: YoutubePlayer(
                                        controller: YoutubePlayerController(
                                          initialVideoId: videoId,
                                          flags: const YoutubePlayerFlags(
                                            autoPlay: true,
                                            mute: false,
                                            showLiveFullscreenButton: true,
                                          ),
                                        ),
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor:
                                            AppColors.mainColorL,
                                      ),
                                      builder: (context, player) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(
                                              0.9,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                              AspectRatio(
                                                aspectRatio: 16 / 9,
                                                child: player,
                                              ),
                                              const SizedBox(height: 16),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).videoNotAvailableForThisExercise,
                                  style: Theme.of(context).textTheme.bodySmall!
                                      .copyWith(color: AppColors.pureWhite),
                                ),
                              ),
                            );
                          }
                        },

                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppIcons.playButtonIcon),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

