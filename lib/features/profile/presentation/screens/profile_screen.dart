import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/features/profile/domain/models/profile_model.dart';

import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../media/presentation/providers/media_providers.dart';
import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authRepositoryProvider).currentUser;

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }

    final profileAsync = ref.watch(userProfileProvider(currentUser.uid));
    final userPostsAsync = ref.watch(userGridPostsProvider(currentUser.uid));

    return Scaffold(
      appBar: AppBar(
        title: profileAsync.when(
          data: (p) => Text(p?.username ?? 'Profile'),
          loading: () => const Text('Profile'),
          error: (_, __) => const Text('Profile'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(userProfileProvider(currentUser.uid));
          ref.invalidate(userGridPostsProvider(currentUser.uid));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Block
              profileAsync.when(
                data: (profile) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Avatar Image
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: profile?.avatarUrl != null
                                ? NetworkImage(profile!.avatarUrl!)
                                : null,
                            child: profile?.avatarUrl == null
                                ? const Icon(Icons.person, size: 40)
                                : null,
                          ),
                          const Spacer(),
                          // Post Count
                          userPostsAsync.when(
                            data: (posts) => _StatColumn(
                              count: posts.length.toString(),
                              label: 'Posts',
                            ),
                            loading: () =>
                                const _StatColumn(count: '-', label: 'Posts'),
                            error: (_, __) =>
                                const _StatColumn(count: '0', label: 'Posts'),
                          ),
                          const Spacer(),
                          const _StatColumn(count: '0', label: 'Followers'),
                          const Spacer(),
                          const _StatColumn(count: '0', label: 'Following'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        profile?.displayName ?? 'Instagram User',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (profile?.bio != null && profile!.bio!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(profile.bio!),
                      ],
                      const SizedBox(height: 16),

                      // Edit Profile Button
                      OutlinedButton(
                        onPressed: () => _showEditProfileDialog(
                          context,
                          ref,
                          profile,
                          currentUser.uid,
                        ),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(36),
                        ),
                        child: const Text('Edit Profile'),
                      ),
                    ],
                  ),
                ),
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),

              const Divider(),

              // Grid View of Posts
              userPostsAsync.when(
                data: (posts) {
                  if (posts.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(child: Text('No posts yet')),
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Image.network(
                        post.mediaUrls.first,
                        fit: BoxFit.cover,
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (err, _) => Center(child: Text('Error: $err')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(
    BuildContext context,
    WidgetRef ref,
    ProfileModel? profile,
    String userId,
  ) {
    final nameController = TextEditingController(
      text: profile?.displayName ?? '',
    );
    final bioController = TextEditingController(text: profile?.bio ?? '');
    String? newAvatarUrl = profile?.avatarUrl;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          final mediaState = ref.watch(mediaControllerProvider);

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Wrap(
              runSpacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: mediaState.isUploading
                          ? null
                          : () async {
                              await ref
                                  .read(profileControllerProvider.notifier)
                                  .updateProfile(
                                    displayName: nameController.text,
                                    bio: bioController.text,
                                    avatarUrl: newAvatarUrl,
                                  );
                              if (context.mounted) Navigator.pop(context);
                            },
                    ),
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: mediaState.isUploading
                        ? null
                        : () async {
                            final url = await ref
                                .read(mediaControllerProvider.notifier)
                                .pickCompressAndUpload(
                                  source: ImageSource.gallery,
                                  bucketName: 'avatars',
                                  folderPath: userId,
                                );
                            if (url != null) {
                              setModalState(() {
                                newAvatarUrl = url;
                              });
                            }
                          },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: newAvatarUrl != null
                          ? NetworkImage(newAvatarUrl!)
                          : null,
                      child: mediaState.isUploading
                          ? const CircularProgressIndicator()
                          : newAvatarUrl == null
                          ? const Icon(Icons.add_a_photo, size: 30)
                          : null,
                    ),
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String count;
  final String label;

  const _StatColumn({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
