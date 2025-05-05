import 'package:feature_first_example/common/models/user.dart';
import 'package:feature_first_example/features/users/presentation/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreen extends GetView<UsersController> {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.fetchUsers(),
          ),
        ],
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
                  onPressed: () => controller.fetchUsers(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (controller.users.isEmpty) {
          return const Center(child: Text('No users found'));
        } else {
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return UserCard(user: user);
            },
          );
        }
      }),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    user.name.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '@${user.username}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Get.toNamed('/users/posts/${user.id}'),
                  icon: const Icon(Icons.article),
                  tooltip: 'View Posts',
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.email, size: 16),
                const SizedBox(width: 8),
                Text(user.email),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 16),
                const SizedBox(width: 8),
                Text(user.phone),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 8),
                Text(user.website),
              ],
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('Address'),
              children: [
                ListTile(
                  title: Text('${user.address.street}, ${user.address.suite}'),
                  subtitle: Text('${user.address.city}, ${user.address.zipcode}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: () {
                      // In a real app, we'd open a map here
                      Get.snackbar(
                        'Location',
                        'Lat: ${user.address.geo.lat}, Lng: ${user.address.geo.lng}',
                      );
                    },
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text('Company'),
              children: [
                ListTile(
                  title: Text(user.company.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.company.catchPhrase),
                      Text(user.company.bs),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
