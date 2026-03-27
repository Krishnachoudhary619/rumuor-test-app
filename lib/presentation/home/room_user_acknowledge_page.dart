import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../chat/components/chat_app_bar.dart';
import '../chat/providers/chat_notifier.dart';
import '../random_user/providers/random_user_notifier.dart';
import '../routes/app_router.dart';
import '../shared/components/app_text_theme.dart';
import '../shared/components/custom_filled_button.dart';
import '../theme/config/app_color.dart';

@RoutePage()
class RoomUserAcknowledgePage extends ConsumerStatefulWidget {
  const RoomUserAcknowledgePage({super.key, required this.roomId});
  final String roomId;

  @override
  ConsumerState<RoomUserAcknowledgePage> createState() =>
      _RoomUserAcknowledgePageState();
}

class _RoomUserAcknowledgePageState
    extends ConsumerState<RoomUserAcknowledgePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(chatNotifierProvider.notifier).init(widget.roomId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final randomUser =
        ref.watch(randomUserNotifierProvider.select((value) => value.data));

    final loading =
        ref.watch(chatNotifierProvider.select((value) => value.loading));
    return Scaffold(
      appBar: ChatAppBar(
        title: 'Room #${widget.roomId}',
        subtitle: '4 members',
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.green,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 35),
                    child: Column(
                      children: [
                        Text(
                          'For this room, you are',
                          style: AppTextTheme.base.copyWith(
                              fontSize: 14,
                              color: AppColor.grey2,
                              fontWeight: FontWeight.w300),
                        ),
                        const Gap(10),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xFFFDE047), // yellow
                                Color(0xFFA3E635), // green
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: Text(
                            randomUser?.name ?? 'Brave Badger',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 50,
                              height: 1.1,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Gap(15),
                        Text(
                          'This is your anonymous identifier, visible only to others in this room.',
                          textAlign: TextAlign.center,
                          style: AppTextTheme.base.copyWith(
                              fontSize: 14,
                              color: AppColor.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                  SizedBox(
                    width: double.maxFinite,
                    child: CustomFilledButton(
                      title: 'Acknowledge and continue',
                      color: AppColor.green,
                      textColor: AppColor.black,
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        context.replaceRoute(ChatRoute(roomId: widget.roomId));
                      },
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),
    );
  }
}
