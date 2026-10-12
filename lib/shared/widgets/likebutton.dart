import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagramclone/features/posts/domain/repositories/like_repository.dart';


class LikeButton extends ConsumerWidget {
  final String postId;

  const LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeAsync = ref.watch(likeControllerProvider(postId));

    return likeAsync.when(
      data: (state) => Row(
        children: [
          IconButton(
            icon: Icon(
              state.isLiked ? Icons.favorite : Icons.favorite_border,
              color: state.isLiked ? Colors.red : null,
            ),
            onPressed: () {
              ref.read(likeControllerProvider(postId).notifier).toggle();
            },
          ),
          Text(
            '${state.count}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      loading: () => const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const Icon(Icons.favorite_border),
    );
  }
}