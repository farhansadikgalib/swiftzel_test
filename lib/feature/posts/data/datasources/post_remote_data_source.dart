import 'package:dio/dio.dart';
import 'package:swiftzel_test/core/constants/api_end_points.dart';
import 'package:swiftzel_test/core/utils/logger.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient dioClient;

  PostRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await dioClient.get(ApiEndPoints.posts);
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((post) => PostModel.fromJson(post))
            .toList();
      } else {
        printLog("${response.statusCode} \n${response.statusMessage}");
        throw ServerException('Failed to load posts');
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong');
    }
  }
}