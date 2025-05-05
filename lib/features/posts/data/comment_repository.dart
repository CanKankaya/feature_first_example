import 'package:feature_first_example/common/models/comment.dart';
import 'package:feature_first_example/core/services/api_service.dart';

class CommentRepository {
  final ApiService _apiService;

  CommentRepository(this._apiService);

  Future<List<Comment>> getComments() async {
    final response = await _apiService.request(
      endpoint: '/comments',
      requestType: RequestType.get,
    );

    return (response as List).map((json) => Comment.fromJson(json)).toList();
  }

  Future<List<Comment>> getCommentsByPostId(int postId) async {
    final response = await _apiService.request(
      endpoint: '/comments',
      requestType: RequestType.get,
      queryParameters: {'postId': postId},
    );

    return (response as List).map((json) => Comment.fromJson(json)).toList();
  }

  Future<Comment> getComment(int id) async {
    final response = await _apiService.request(
      endpoint: '/comments/$id',
      requestType: RequestType.get,
    );

    return Comment.fromJson(response);
  }

  Future<Comment> createComment(Comment comment) async {
    final response = await _apiService.request(
      endpoint: '/comments',
      requestType: RequestType.post,
      body: comment.toJson(),
    );

    return Comment.fromJson(response);
  }
}
