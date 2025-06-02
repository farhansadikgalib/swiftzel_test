import 'package:equatable/equatable.dart';
  import '../../domain/entities/post.dart';

  class PostModel extends Post with EquatableMixin {
    PostModel({
      required super.id,
      required super.userId,
      required super.title,
      required super.body,
    });

    @override
    List<Object?> get props => [id, userId, title, body];

    factory PostModel.fromJson(Map<String, dynamic> json) {
      return PostModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        body: json['body'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };
    }
  }