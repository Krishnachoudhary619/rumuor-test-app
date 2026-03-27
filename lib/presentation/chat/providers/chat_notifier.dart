import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../data/model/chat_notifier_model.dart';
import '../../../data/repository/chat_repo_impl.dart';
import '../../../domain/model/load_error_state.dart';
import '../../../domain/model/message_model.dart';
import '../../../domain/repository/chat_repo.dart';
import '../../random_user/providers/random_user_notifier.dart';
part 'chat_notifier.g.dart';

@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  late ChatRepository _repo;

  StreamSubscription<List<MessageModel>>? _subscription;

  @override
  LoadErrorState<ChatNotifierModel> build() {
    _repo = ref.read(chatRepoProvider);

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return LoadErrorState(data: const ChatNotifierModel());
  }

  String? _roomId;

  Future<void> init(String roomId) async {
    _roomId = roomId;
    reset(loading: true);

    await ref.read(randomUserNotifierProvider.notifier).getOrCreateUser(roomId);

    _startListener();
  }

  String getRoomId() {
    return _roomId ?? 'Offline';
  }

  Future<void> loadMore() async {
    if (_roomId == null) {
      return;
    }

    final current = state.data;

    if (current.lastDoc == null || current.isPaginating) {
      return;
    }

    state = state.copyWith(
      data: current.copyWith(isPaginating: true),
    );

    final result = await _repo.fetchMessages(
      roomId: _roomId!,
      lastDoc: current.lastDoc,
    );

    result.fold(
      onException,
      (res) {
        final (messages, lastDoc) = res;

        state = state.copyWith(
          data: current.copyWith(
            messages: [...current.messages, ...messages],
            lastDoc: lastDoc,
            isPaginating: false,
          ),
        );
      },
    );
  }

  void _startListener() {
    if (_roomId == null) {
      return;
    }

    _subscription?.cancel();

    _subscription = _repo.getLatestMessages(_roomId!).listen(
      (messages) {
        final current = state.data;

        final Map<String, MessageModel> messageMap = {
          for (final msg in current.messages) msg.id: msg,
        };

        for (final msg in messages) {
          messageMap[msg.id] = msg;
        }

        final updatedMessages = messageMap.values.toList()
          ..sort(
            (a, b) => (b.createdAt ?? DateTime(0))
                .compareTo(a.createdAt ?? DateTime(0)),
          );

        state = state.copyWith(
          data: current.copyWith(
            messages: updatedMessages,
          ),
          loading: false,
        );
      },
      onError: (e, _) {
        state = state.copyWith(
          error: e.toString(),
          loading: false,
        );
      },
    );
  }

  Future<void> sendMessage({
    required String text,
  }) async {
    if (_roomId == null || text.trim().isEmpty) return;

    final user =
        ref.read(randomUserNotifierProvider.select((value) => value.data));

    final result = await _repo.sendMessage(
      roomId: _roomId!,
      text: text,
      senderId: user?.id ?? 'Unknown',
      senderName: user?.name ?? 'Unknown',
    );

    result.fold(onException, (_) {});
  }

  void onException(AppException e) {
    state = state.copyWith(
      error: e.message,
      loading: false,
    );
  }

  void reset({bool? loading}) {
    state = LoadErrorState(
      data: const ChatNotifierModel(),
      loading: loading ?? false,
    );
  }
}
