enum RoomStatus {
  initial,
  loading,
  success,
  error,
}

class RoomState {

  const RoomState({
    this.status = RoomStatus.initial,
    this.roomId,
    this.error,
  });
  final RoomStatus status;
  final String? roomId;
  final String? error;

  RoomState copyWith({
    RoomStatus? status,
    String? roomId,
    String? error,
  }) {
    return RoomState(
      status: status ?? this.status,
      roomId: roomId ?? this.roomId,
      error: error ?? this.error,
    );
  }
}