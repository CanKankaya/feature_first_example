import 'package:feature_first_example/common/models/post.dart';
import 'package:feature_first_example/features/posts/presentation/controllers/posts_controller.dart';
import 'package:feature_first_example/features/posts/presentation/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPostsScreen extends GetView<PostsController> {
  final int userId;

  const UserPostsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Fetch posts by the specific user
    controller.fetchPostsByUser(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text('User $userId Posts'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchPostsByUser(userId),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (controller.posts.isEmpty) {
          return const Center(child: Text('No posts found for this user'));
        } else {
          return ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              final post = controller.posts[index];
              return PostCard(post: post);
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Add New Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && bodyController.text.isNotEmpty) {
                // Create a post for this specific user
                controller.createPost(
                  Post(
                    id: 0, // API will assign the real ID
                    userId: userId,
                    title: titleController.text,
                    body: bodyController.text,
                  ),
                );
                Get.back();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
