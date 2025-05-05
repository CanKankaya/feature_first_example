import 'package:feature_first_example/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:feature_first_example/features/posts/presentation/screens/posts_screen.dart';
import 'package:feature_first_example/features/users/presentation/screens/user_posts_screen.dart';
import 'package:feature_first_example/features/users/presentation/screens/users_screen.dart';
import 'package:get/get.dart';

/// Defines all the routes for the application
class AppRoutes {
  static const String posts = '/posts';
  static const String postDetail = '/posts/:id';
  static const String users = '/users';
  static const String userPosts = '/users/posts/:id';

  static final List<GetPage> pages = [
    GetPage(
      name: posts,
      page: () => const PostsScreen(),
    ),
    GetPage(
      name: postDetail,
      page: () {
        final id = int.parse(Get.parameters['id']!);
        return PostDetailScreen(postId: id);
      },
    ),
    GetPage(
      name: users,
      page: () => const UsersScreen(),
    ),
    GetPage(
      name: userPosts,
      page: () {
        final id = int.parse(Get.parameters['id']!);
        return UserPostsScreen(userId: id);
      },
    ),
  ];
}
