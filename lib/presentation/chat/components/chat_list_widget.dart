import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/model/message_model.dart';
import '../../random_user/providers/random_user_notifier.dart';
import 'chat_bubble_widget.dart';
import 'date_separator.dart';

class ChatListView extends ConsumerWidget {
  const ChatListView({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.isPaginating,
  });

  final List<MessageModel> messages;
  final ScrollController scrollController;
  final bool isPaginating;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId =
        ref.read(randomUserNotifierProvider.select((value) => value.data?.id));
    return ListView.builder(
      controller: scrollController,
      reverse: true,
      itemCount: messages.length + (isPaginating ? 1 : 0),
      itemBuilder: (context, index) {
        if (isPaginating && index == messages.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        final message = messages[index];

        final nextMessage =
            index != messages.length - 1 ? messages[index + 1] : null;

        final showDateSeparator = _shouldShowDateSeparator(
          message,
          nextMessage,
        );

        return Column(
          children: [
            if (showDateSeparator && message.createdAt != null)
              DateSeparator(date: message.createdAt!),
            ChatBubble(
              message: message,
              nextMessage: nextMessage,
              isMe: message.senderId == currentUserId,
            ),
          ],
        );
      },
    );
  }

  bool _shouldShowDateSeparator(
    MessageModel current,
    MessageModel? next,
  ) {
    if (current.createdAt == null) {
      return false;
    }

    if (next == null) {
      return true;
    }

    if (next.createdAt == null) {
      return true;
    }

    final currentDate = DateTime(
      current.createdAt!.year,
      current.createdAt!.month,
      current.createdAt!.day,
    );

    final nextDate = DateTime(
      next.createdAt!.year,
      next.createdAt!.month,
      next.createdAt!.day,
    );

    return currentDate != nextDate;
  }
}
