import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/constants/constant_dummy_image.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view/widgets/chat_message_custom_widget.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_events.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_states.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatViewBody extends StatefulWidget {
  final SmartCoachViewModel smartCoachViewModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ChatViewBody({
    super.key,
    required this.smartCoachViewModel,
    required this.scaffoldKey,
  });

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  @override
  void initState() {
    super.initState();
    widget.smartCoachViewModel.doIntent(OnLoadWelcomeMessageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SmartCoachViewModel, SmartCoachStates>(
      bloc: widget.smartCoachViewModel,
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ResizeImage(
                    AssetImage(AppDummyImage.dummyImageFitness8),
                    width: 828,
                    policy: ResizeImagePolicy.fit,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.55),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: Navigator.of(context).maybePop,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.mainColorL,
                          child: const ImageIcon(
                            AssetImage(AppIcons.arrowBack),
                            size: 10,
                            color: AppColors.pureWhite,
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).smartCoach,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.scaffoldKey.currentState!.openEndDrawer();
                        },
                        child: SizedBox(
                          height: 24,
                          width: 24,
                          child: ImageIcon(
                            const AssetImage(AppIcons.menuIcon),
                            color: AppColors.mainColorL,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    child: ListView.builder(
                      controller: widget.smartCoachViewModel.scrollController,
                      itemCount: state.messagesListSuccess.length,
                      itemBuilder: (context, index) {
                        final message = state.messagesListSuccess[index];
                        return ChatMessageCustomWidget(message: message);
                      },
                    ),
                  ),

                  if (state.isLoading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundImage: AssetImage(AppImages.aiImage),
                          ),
                          const SizedBox(width: 12),
                          DefaultTextStyle(
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: AppColors.pureWhite,
                                  fontSize: 14,
                                ),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                TyperAnimatedText(
                                  AppLocalizations.of(
                                    context,
                                  ).smartCoachIsTyping,
                                  speed: const Duration(milliseconds: 70),
                                ),
                              ],
                              repeatForever: true,
                              isRepeatingAnimation: true,
                            ),
                          ),
                        ],
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller:
                                widget.smartCoachViewModel.inputController,
                            textInputAction: TextInputAction.send,
                            onFieldSubmitted: state.isLoading
                                ? null
                                : (value) => widget.smartCoachViewModel
                                      .doIntent(OnSendMessageEvent()),
                            maxLines: null,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: AppColors.pureWhite),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(
                                context,
                              ).messageSmartCoach,
                              hintStyle: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColors.pureWhite),
                              suffixIcon: IconButton(
                                onPressed: state.isLoading
                                    ? null
                                    : () => widget.smartCoachViewModel.doIntent(
                                        OnSendMessageEvent(),
                                      ),
                                icon: const Icon(Icons.send),
                                color: AppColors.transparentOrange.withOpacity(
                                  0.5,
                                ),
                              ),
                              filled: true,
                              fillColor: AppColors.backGroundL.withOpacity(0.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            cursorColor: AppColors.mainColorL,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
