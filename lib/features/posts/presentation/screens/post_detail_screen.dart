import 'package:feature_first_example/common/models/comment.dart';
import 'package:feature_first_example/features/posts/presentation/controllers/post_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailScreen extends GetView<PostDetailController> {
  final int postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the post ID
    controller.fetchPost(postId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
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
                  onPressed: () => controller.fetchPost(postId),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (controller.post.value == null) {
          return const Center(child: Text('Post not found'));
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.post.value!.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(controller.post.value!.body),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.person),
                              label: Text('User ${controller.post.value!.userId}'),
                              onPressed: () =>
                                  Get.toNamed('/users/${controller.post.value!.userId}'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Comments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (controller.comments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: Text('No comments yet')),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.comments.length,
                    itemBuilder: (context, index) {
                      final comment = controller.comments[index];
                      return CommentCard(comment: comment);
                    },
                  ),
                const SizedBox(height: 16),
                AddCommentForm(
                  postId: postId,
                  onSubmit: (comment) => controller.addComment(comment),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class CommentCard extends StatelessWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    comment.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.email, size: 16),
                const SizedBox(width: 8),
                Text(
                  comment.email,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment.body),
          ],
        ),
      ),
    );
  }
}

class AddCommentForm extends StatefulWidget {
  final int postId;
  final Function(Comment) onSubmit;

  const AddCommentForm({
    super.key,
    required this.postId,
    required this.onSubmit,
  });

  @override
  State<AddCommentForm> createState() => _AddCommentFormState();
}

class _AddCommentFormState extends State<AddCommentForm> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add a Comment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: bodyController,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.onSubmit(
                        Comment(
                          id: 0, // The API will assign the actual ID
                          postId: widget.postId,
                          name: nameController.text,
                          email: emailController.text,
                          body: bodyController.text,
                        ),
                      );
                      nameController.clear();
                      emailController.clear();
                      bodyController.clear();
                    }
                  },
                  child: const Text('Submit Comment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
