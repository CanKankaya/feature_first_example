import 'package:feature_first_example/common/models/user.dart';
import 'package:feature_first_example/core/services/api_service.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<List<User>> getUsers() async {
    final response = await _apiService.request(
      endpoint: '/users',
      requestType: RequestType.get,
    );

    return (response as List).map((json) => User.fromJson(json)).toList();
  }

  Future<User> getUser(int id) async {
    final response = await _apiService.request(
      endpoint: '/users/$id',
      requestType: RequestType.get,
    );

    return User.fromJson(response);
  }
}
