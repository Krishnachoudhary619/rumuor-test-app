import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/chat_app_bar.dart';
import 'components/chat_input_widget.dart';
import 'components/chat_list_widget.dart';
import 'providers/chat_notifier.dart';

@RoutePage()
class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.roomId});

  final String roomId;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent + 100) {
      ref.read(chatNotifierProvider.notifier).loadMore();
    }
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    ref.read(chatNotifierProvider.notifier).sendMessage(text: text);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chatNotifierProvider);
    final notifier = ref.read(chatNotifierProvider.notifier);

    return Scaffold(
      appBar: ChatAppBar(
        title: 'Room #${notifier.getRoomId()}',
        subtitle: '4 members',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ChatListView(
                messages: state.data.messages,
                scrollController: _scrollController,
                isPaginating: state.data.isPaginating,
              ),
            ),
            ChatInputField(
              controller: _controller,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
