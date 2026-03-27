// features/user/data/source/random_user_source.dart

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helper/dio_instance.dart';
import '../model/random_user_api_res_model.dart';

part 'random_user_source.g.dart';

@riverpod
RandomUserSource randomUserSource(RandomUserSourceRef ref) {
  return RandomUserSource(ref.watch(dioInstanceProvider));
}

@RestApi(baseUrl: 'https://randomuser.me/')
abstract class RandomUserSource {
  factory RandomUserSource(Dio dio) = _RandomUserSource;

  @GET('api/')
  Future<RandomUserResponse> getRandomUser();
}
