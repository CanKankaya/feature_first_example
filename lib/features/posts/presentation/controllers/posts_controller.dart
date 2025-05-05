import 'package:feature_first_example/common/models/post.dart';
import 'package:feature_first_example/features/posts/data/post_repository.dart';
import 'package:get/get.dart';

class PostsController extends GetxController {
  final PostRepository _postRepository;

  PostsController(this._postRepository);

  var isLoading = false.obs;
  var posts = <Post>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedPosts = await _postRepository.getPosts();
      posts.assignAll(fetchedPosts);
    } catch (e) {
      errorMessage('Failed to load posts: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPostsByUser(int userId) async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedPosts = await _postRepository.getPostsByUser(userId);
      posts.assignAll(fetchedPosts);
    } catch (e) {
      errorMessage('Failed to load user posts: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPost(Post post) async {
    try {
      isLoading(true);
      errorMessage('');
      final newPost = await _postRepository.createPost(post);
      posts.add(newPost);
    } catch (e) {
      errorMessage('Failed to create post: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      isLoading(true);
      errorMessage('');
      final updatedPost = await _postRepository.updatePost(post);
      final index = posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        posts[index] = updatedPost;
      }
    } catch (e) {
      errorMessage('Failed to update post: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deletePost(int id) async {
    try {
      isLoading(true);
      errorMessage('');
      await _postRepository.deletePost(id);
      posts.removeWhere((post) => post.id == id);
    } catch (e) {
      errorMessage('Failed to delete post: $e');
    } finally {
      isLoading(false);
    }
  }
}
