import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';

abstract class RoomRepository {
  Future<Either<AppException, String>> createRoom();
  Future<Either<AppException, bool>> joinRoom(String roomId);
}
