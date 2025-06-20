import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gitbub_clone/providers/github_providers.dart';
import 'package:gitbub_clone/providers/state_notifier.dart';
import 'repo_detail_screen.dart';

final repoNotifierProvider = ChangeNotifierProvider((ref) {
  final service = ref.read(githubServiceProvider);
  return RepoChangeNotifier(service)..loadRepos();
});

class RepositoriesScreen extends ConsumerStatefulWidget {
  const RepositoriesScreen({super.key});

  @override
  ConsumerState<RepositoriesScreen> createState() => _RepositoriesScreenState();
}

class _RepositoriesScreenState extends ConsumerState<RepositoriesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final notifier = ref.read(repoNotifierProvider);
  if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !notifier.isLoading && notifier.hasMore) {
    ref.read(repoNotifierProvider.notifier).loadRepos();
  }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(repoNotifierProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Repositories')),
      body: RefreshIndicator(
        onRefresh: () async {
             await ref.read(repoNotifierProvider.notifier).loadRepos(refresh: true);

        },
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: notifier.repos.length + (notifier.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < notifier.repos.length) {
              final repo = notifier.repos[index];
              return ListTile(
                title: Text(repo.name),
                subtitle: Text(repo.description ?? 'No description'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('⭐ ${repo.stargazersCount}'),
                    if (repo.language != null) Text(repo.language!),
                  ],
                ),
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RepoDetailScreen(repo: repo),
                      ),
                    ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }
}
