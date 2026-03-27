// features/room/presentation/providers/room_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../domain/repository/room_repo.dart';
import '../../../data/model/room_state_model.dart';
import '../../../data/repository/room_repo_impl.dart';
import '../../chat/providers/chat_notifier.dart';

part 'room_notifier.g.dart';

@riverpod
class RoomNotifier extends _$RoomNotifier {
  late RoomRepository _repo;

  @override
  RoomState build() {
    _repo = ref.read(roomRepoProvider);
    return const RoomState();
  }

  Future<void> createRoom() async {
    state = state.copyWith(status: RoomStatus.loading, error: null);

    final result = await _repo.createRoom();

    await result.fold(
      (l) {
        state = state.copyWith(
          status: RoomStatus.error,
          error: l.message,
        );
      },
      (roomId) async {
        state = state.copyWith(
          status: RoomStatus.success,
          roomId: roomId,
        );
      },
    );
  }

  Future<void> joinRoom(String roomId) async {
    state = state.copyWith(status: RoomStatus.loading, error: null);

    final result = await _repo.joinRoom(roomId);

    await result.fold(
      (l) {
        state = state.copyWith(
          status: RoomStatus.error,
          error: l.message,
        );
      },
      (exists) async {
        if (!exists) {
          state = state.copyWith(
            status: RoomStatus.error,
            error: 'Room not found',
          );
          return;
        }

        state = state.copyWith(
          status: RoomStatus.success,
          roomId: roomId,
        );
      },
    );
  }
}
