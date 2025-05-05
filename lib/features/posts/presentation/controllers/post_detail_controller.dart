import 'package:feature_first_example/common/models/post.dart';
import 'package:feature_first_example/common/models/comment.dart';
import 'package:feature_first_example/features/posts/data/post_repository.dart';
import 'package:feature_first_example/features/posts/data/comment_repository.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  final PostRepository _postRepository;
  final CommentRepository _commentRepository;

  PostDetailController({
    required PostRepository postRepository,
    required CommentRepository commentRepository,
  })  : _postRepository = postRepository,
        _commentRepository = commentRepository;

  var isLoading = false.obs;
  var post = Rx<Post?>(null);
  var comments = <Comment>[].obs;
  var errorMessage = ''.obs;

  Future<void> fetchPost(int id) async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedPost = await _postRepository.getPost(id);
      post.value = fetchedPost;
      await fetchComments(id);
    } catch (e) {
      errorMessage('Failed to load post: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      final fetchedComments = await _commentRepository.getCommentsByPostId(postId);
      comments.assignAll(fetchedComments);
    } catch (e) {
      errorMessage('Failed to load comments: $e');
    }
  }

  Future<void> addComment(Comment comment) async {
    try {
      isLoading(true);
      errorMessage('');
      final newComment = await _commentRepository.createComment(comment);
      comments.add(newComment);
    } catch (e) {
      errorMessage('Failed to add comment: $e');
    } finally {
      isLoading(false);
    }
  }
}
