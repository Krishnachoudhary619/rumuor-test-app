import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../shared/components/app_text_theme.dart';
import '../providers/room_notifier.dart';

class OnlyBottomCursor extends ConsumerStatefulWidget {
  const OnlyBottomCursor({super.key});

  @override
  ConsumerState<OnlyBottomCursor> createState() => _OnlyBottomCursorState();

  @override
  String toStringShort() => 'With Bottom Cursor';
}

class _OnlyBottomCursorState extends ConsumerState<OnlyBottomCursor> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).colorScheme.secondary;

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 35,
      textStyle: AppTextTheme.base.copyWith(fontSize: 22),
      decoration: const BoxDecoration(),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Pinput(
      length: 6,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinAnimationType: PinAnimationType.fade,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      showCursor: true,
      cursor: cursor,
      preFilledWidget: preFilledWidget,
      onCompleted: (value) {
        ref.read(roomNotifierProvider.notifier).joinRoom(value);
        controller.clear();
      },
    );
  }
}
