import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/network/network_info.dart';
import 'core/network/dio_client.dart';
import 'feature/posts/data/datasources/post_remote_data_source.dart';
import 'feature/posts/data/repositories/post_repository_impl.dart';
import 'feature/posts/domain/repositories/post_repository.dart';
import 'feature/posts/domain/usecases/get_posts.dart';
import 'feature/posts/presentation/bloc/post_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(
        () => PostBloc(getPosts: sl()),
  );

  sl.registerLazySingleton(() => GetPosts(sl()));

  sl.registerLazySingleton<PostRepository>(
        () => PostRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<PostRemoteDataSource>(
        () => PostRemoteDataSourceImpl(dioClient: sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DioClient(sl()));

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}