// features/room/data/repository/room_repo_impl.dart

import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/extension/future.dart';
import '../../../domain/repository/room_repo.dart';
import '../source/remote/room_source.dart';

part 'room_repo_impl.g.dart';

@riverpod
RoomRepository roomRepo(RoomRepoRef ref) {
  return RoomRepositoryImpl(ref.watch(roomSourceProvider));
}

class RoomRepositoryImpl implements RoomRepository {
  RoomRepositoryImpl(this._source);

  final RoomSource _source;

  @override
  Future<Either<AppException, String>> createRoom() {
    return _source.createRoom().guardFuture();
  }

  @override
  Future<Either<AppException, bool>> joinRoom(String roomId) {
    return _source.checkRoomExists(roomId).guardFuture();
  }
}
