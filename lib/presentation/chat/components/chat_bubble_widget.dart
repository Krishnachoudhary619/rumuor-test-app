import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/extension/datetime.dart';
import '../../../core/extension/widget.dart';
import '../../../domain/model/message_model.dart';
import '../../shared/components/app_text_theme.dart';
import '../../theme/config/app_color.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.nextMessage,
  });

  final MessageModel message;
  final MessageModel? nextMessage;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? AppColor.green : Theme.of(context).cardColor;

    final alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (nextMessage?.senderId != message.senderId)
              Text(
                textAlign: isMe ? TextAlign.right : TextAlign.left,
                isMe ? 'You' : '@${message.senderName}',
                style: AppTextTheme.base.copyWith(color: AppColor.white),
              ).pad(top: 5)
            else
              const SizedBox(),
            IntrinsicWidth(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                constraints: const BoxConstraints(maxWidth: 280),
                decoration: BoxDecoration(
                  color: bubbleColor,
                  borderRadius: isMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(11),
                          bottomLeft: Radius.circular(11),
                          bottomRight: Radius.circular(11),
                        )
                      : const BorderRadius.only(
                          topRight: Radius.circular(11),
                          bottomLeft: Radius.circular(11),
                          bottomRight: Radius.circular(11),
                        ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.text,
                      style: AppTextTheme.base.copyWith(
                        fontSize: 13,
                        color: isMe ? AppColor.blueGrey : AppColor.white,
                      ),
                    ),
                    const Gap(5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        message.createdAt?.toHHMM() ?? '',
                        style: AppTextTheme.base.copyWith(
                          fontSize: 10,
                          color: isMe ? AppColor.blueGrey : AppColor.grey2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
