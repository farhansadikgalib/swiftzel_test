import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPosts getPosts;

  PostBloc({required this.getPosts}) : super(PostInitial()) {
    on<GetPostsEvent>((event, emit) async {
      emit(PostLoading());
      final failureOrPosts = await getPosts();
      failureOrPosts.fold(
            (failure) => emit(PostError(failure.message)),
            (posts) => emit(PostLoaded(posts)),
      );
    });
  }
}