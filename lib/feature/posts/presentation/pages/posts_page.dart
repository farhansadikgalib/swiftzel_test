import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../bloc/post_bloc.dart';
import '../../domain/entities/post.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Posts Data'),
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostInitial) {
            BlocProvider.of<PostBloc>(context).add(GetPostsEvent());
            return const LoadingWidget();
          } else if (state is PostLoading) {
            return const LoadingWidget();
          } else if (state is PostLoaded) {
            return _buildPostsList(state.posts);
          } else if (state is PostError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildPostsList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          child: ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
            leading: CircleAvatar(
              child: Text(post.id.toString()),
            ),
          ),
        );
      },
    );
  }
}