import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/post_repository.dart';
import '../entities/post.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getPosts();
  }
}