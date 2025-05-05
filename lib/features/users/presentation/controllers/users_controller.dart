import 'package:feature_first_example/common/models/user.dart';
import 'package:feature_first_example/features/users/data/user_repository.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  final UserRepository _userRepository;

  UsersController(this._userRepository);

  var isLoading = false.obs;
  var users = <User>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedUsers = await _userRepository.getUsers();
      users.assignAll(fetchedUsers);
    } catch (e) {
      errorMessage('Failed to load users: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUser(int id) async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedUser = await _userRepository.getUser(id);
      final index = users.indexWhere((user) => user.id == id);
      if (index != -1) {
        users[index] = fetchedUser;
      } else {
        users.add(fetchedUser);
      }
    } catch (e) {
      errorMessage('Failed to load user: $e');
    } finally {
      isLoading(false);
    }
  }
}
