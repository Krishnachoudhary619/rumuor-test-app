import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../core/extension/widget.dart';
import '../../data/model/room_state_model.dart';
import '../routes/app_router.dart';
import '../shared/components/app_text_theme.dart';
import '../shared/components/custom_filled_button.dart';
import '../shared/gen/assets.gen.dart';

import '../theme/config/app_color.dart';
import 'components/pin_widget.dart';
import 'providers/room_notifier.dart';

@RoutePage()
class JoinRoomPage extends ConsumerStatefulWidget {
  const JoinRoomPage({super.key});

  @override
  ConsumerState<JoinRoomPage> createState() => _JoinRoomPageState();
}

class _JoinRoomPageState extends ConsumerState<JoinRoomPage> {
  @override
  void initState() {
    super.initState();
  }

  void setListener() {
    ref.listen<RoomState>(roomNotifierProvider, (prev, next) {
      if (next.status == RoomStatus.success && next.roomId != null) {
        context.pushRoute(RoomUserAcknowledgeRoute(roomId: next.roomId!));
      }

      if (next.status == RoomStatus.error && next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setListener();
    final state = ref.watch(roomNotifierProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(100),
                      child: Assets.icons.logoDev.image(height: 60)),
                  // Consumer(builder: (context, ref, child) {
                  //   final isDarkTheme = ref.watch(themeNotifierProvider);
                  //   return IconButton(
                  //     onPressed: () {
                  //       ref.read(themeNotifierProvider.notifier).state =
                  //           !isDarkTheme;
                  //     },
                  //     icon: isDarkTheme
                  //         ? const Icon(Icons.dark_mode)
                  //         : const Icon(Icons.light_mode),
                  //   );
                  // })
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Join A Room',
                        style: AppTextTheme.base.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColor.white),
                      ),
                      const Gap(10),
                      Text(
                        'Enter the code to join the anonymous chat room',
                        style: AppTextTheme.base.copyWith(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(30),
                      Container(
                          decoration: BoxDecoration(
                              color: AppColor.darkGrey,
                              borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: IgnorePointer(
                            ignoring: state.status == RoomStatus.loading,
                            child: const OnlyBottomCursor(),
                          )),
                      const Text('OR').padAll(20),
                      Consumer(
                        builder: (context, ref, child) {
                          return state.status == RoomStatus.loading
                              ? const CircularProgressIndicator()
                              : CustomFilledButton(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor.green,
                                  textColor: AppColor.blueGrey,
                                  title: 'Create Room',
                                  onTap: state.status == RoomStatus.loading
                                      ? null
                                      : () {
                                          ref
                                              .read(
                                                  roomNotifierProvider.notifier)
                                              .createRoom();
                                        },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
