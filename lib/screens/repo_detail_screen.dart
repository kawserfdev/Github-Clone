import 'package:flutter/material.dart';
import 'package:gitbub_clone/models/repo_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailScreen extends StatelessWidget {
  final GitHubRepo repo;
  const RepoDetailScreen({super.key, required this.repo});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // }
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.06,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF1976D2),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, size: size.height * 0.03),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                repo.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2196F3),
                      Color(0xFF1976D2),
                      Color(0xFF0D47A1),
                    ],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          Icons.star,
                          '${repo.stargazersCount}',
                          'Stars',
                          Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 16),
                      if (repo.language != null)
                        Expanded(
                          child: _buildStatItem(
                            Icons.code,
                            repo.language!,
                            'Language',
                            _getLanguageColor(repo.language!),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  _buildSectionTitle('Description'),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      repo.description ??
                          'No description available for this repository.',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            repo.description != null
                                ? Colors.grey[700]
                                : Colors.grey[500],
                        height: 1.5,
                        fontStyle:
                            repo.description == null
                                ? FontStyle.italic
                                : FontStyle.normal,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  _buildSectionTitle('Actions'),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () => _launchURL(repo.htmlUrl),
                      icon: const Icon(Icons.open_in_browser, size: 24),
                      label: const Text(
                        'View on GitHub',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF24292e),
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton.icon(
                      onPressed: () => _copyToClipboard(context, repo.htmlUrl),
                      icon: const Icon(Icons.copy, size: 20),
                      label: const Text(
                        'Copy Repository URL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1976D2),
                        side: const BorderSide(
                          color: Color(0xFF1976D2),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getLanguageColor(String language) {
    final colors = {
      'Dart': const Color(0xFF0175C2),
      'JavaScript': const Color(0xFFF7DF1E),
      'Python': const Color(0xFF3776AB),
      'Java': const Color(0xFFED8B00),
      'Swift': const Color(0xFFFA7343),
      'Kotlin': const Color(0xFF0095D5),
      'TypeScript': const Color(0xFF007ACC),
      'Go': const Color(0xFF00ADD8),
      'Rust': const Color(0xFF000000),
      'C++': const Color(0xFF00599C),
    };
    return colors[language] ?? Colors.grey[600]!;
  }

  void _copyToClipboard(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Repository URL copied to clipboard!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
