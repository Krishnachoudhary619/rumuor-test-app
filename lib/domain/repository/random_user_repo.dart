// domain/repository/random_user_repo.dart

import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../../data/model/random_user_api_res_model.dart';

abstract class RandomUserRepository {
  Future<Either<AppException, RandomUserResponse>> getRandomUser();
}
