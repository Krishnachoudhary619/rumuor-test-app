// features/user/data/repository/random_user_repo_impl.dart

import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/extension/future.dart';

import '../../../../domain/repository/random_user_repo.dart';
import '../model/random_user_api_res_model.dart';
import '../source/random_user_source.dart';

part 'random_user_repo_impl.g.dart';

@riverpod
RandomUserRepository randomUserRepo(RandomUserRepoRef ref) {
  return RandomUserRepositoryImpl(ref.watch(randomUserSourceProvider));
}

class RandomUserRepositoryImpl implements RandomUserRepository {
  RandomUserRepositoryImpl(this._source);

  final RandomUserSource _source;

  @override
  Future<Either<AppException, RandomUserResponse>> getRandomUser() async {
    return _source.getRandomUser().guardFuture();
  }
}
