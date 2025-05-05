import 'package:feature_first_example/core/services/api_service.dart';
import 'package:feature_first_example/features/posts/data/comment_repository.dart';
import 'package:feature_first_example/features/posts/data/post_repository.dart';
import 'package:feature_first_example/features/posts/presentation/controllers/post_detail_controller.dart';
import 'package:feature_first_example/features/posts/presentation/controllers/posts_controller.dart';
import 'package:feature_first_example/features/users/data/user_repository.dart';
import 'package:feature_first_example/features/users/presentation/controllers/users_controller.dart';
import 'package:get/get.dart';

/// Initial bindings class to setup dependency injection for the app
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register core services
    Get.put(ApiService(), permanent: true);

    // Register repositories
    Get.lazyPut(() => PostRepository(Get.find<ApiService>()), fenix: true);
    Get.lazyPut(() => CommentRepository(Get.find<ApiService>()), fenix: true);
    Get.lazyPut(() => UserRepository(Get.find<ApiService>()), fenix: true);

    // Register controllers
    Get.lazyPut(() => PostsController(Get.find<PostRepository>()), fenix: true);
    Get.lazyPut(() => UsersController(Get.find<UserRepository>()), fenix: true);
    Get.lazyPut(
      () => PostDetailController(
        postRepository: Get.find<PostRepository>(),
        commentRepository: Get.find<CommentRepository>(),
      ),
      fenix: true,
    );
  }
}
