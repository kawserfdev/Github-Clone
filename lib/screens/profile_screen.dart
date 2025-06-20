import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gitbub_clone/app_routes.dart';
import 'package:gitbub_clone/providers/github_providers.dart';

class GitHubProfileScreen extends ConsumerWidget {
  const GitHubProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Profile')),
      body: userAsync.when(
        data:
            (user) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user.name ?? 'No Name',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    user.bio ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(' ${user.location ?? 'Unknown'}'),
                  const SizedBox(height: 10),
                  Text(
                    'Followers: ${user.followers} | Following: ${user.following}',
                  ),
                  const SizedBox(height: 10),
                  Text('Public Repos: ${user.publicRepos}'),
                  const Spacer(),
                  ElevatedButton(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          AppRoutes.repositories,
                        ),

                    child: const Text('View Repositories'),
                  ),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Github Profile\nLoading Failed')),
      ),
    );
  }
}
