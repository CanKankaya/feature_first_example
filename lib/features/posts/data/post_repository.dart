import 'package:feature_first_example/common/models/post.dart';
import 'package:feature_first_example/core/services/api_service.dart';

class PostRepository {
  final ApiService _apiService;

  PostRepository(this._apiService);

  Future<List<Post>> getPosts() async {
    final response = await _apiService.request(
      endpoint: '/posts',
      requestType: RequestType.get,
    );

    return (response as List).map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> getPost(int id) async {
    final response = await _apiService.request(
      endpoint: '/posts/$id',
      requestType: RequestType.get,
    );

    return Post.fromJson(response);
  }

  Future<List<Post>> getPostsByUser(int userId) async {
    final response = await _apiService.request(
      endpoint: '/posts',
      requestType: RequestType.get,
      queryParameters: {'userId': userId},
    );

    return (response as List).map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> createPost(Post post) async {
    final response = await _apiService.request(
      endpoint: '/posts',
      requestType: RequestType.post,
      body: post.toJson(),
    );

    return Post.fromJson(response);
  }

  Future<Post> updatePost(Post post) async {
    final response = await _apiService.request(
      endpoint: '/posts/${post.id}',
      requestType: RequestType.put,
      body: post.toJson(),
    );

    return Post.fromJson(response);
  }

  Future<bool> deletePost(int id) async {
    await _apiService.request(
      endpoint: '/posts/$id',
      requestType: RequestType.delete,
    );

    return true;
  }
}
