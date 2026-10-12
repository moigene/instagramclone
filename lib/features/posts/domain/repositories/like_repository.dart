import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

part 'like_repository.g.dart';

abstract class ILikeRepository {
  Future<bool> isPostLiked({required String postId, required String userId});
  Future<int> getLikesCount(String postId);
  Future<void> toggleLike({required String postId, required String userId});
}

class SupabaseLikeRepository implements ILikeRepository {
  final SupabaseClient _supabase;

  SupabaseLikeRepository(this._supabase);

  @override
  Future<bool> isPostLiked({required String postId, required String userId}) async {
    final res = await _supabase
        .from('likes')
        .select()
        .eq('post_id', postId)
        .eq('user_id', userId)
        .maybeSingle();
    return res != null;
  }

  @override
  Future<int> getLikesCount(String postId) async {
    final count = await _supabase
        .from('likes')
        .select()
        .eq('post_id', postId);
    return (count as List).length;
  }

  @override
  Future<void> toggleLike({required String postId, required String userId}) async {
    final liked = await isPostLiked(postId: postId, userId: userId);
    if (liked) {
      await _supabase
          .from('likes')
          .delete()
          .eq('post_id', postId)
          .eq('user_id', userId);
    } else {
      await _supabase.from('likes').insert({
        'post_id': postId,
        'user_id': userId,
      });
    }
  }
}

@riverpod
ILikeRepository likeRepository(Ref ref) {
  return SupabaseLikeRepository(Supabase.instance.client);
}

// State model for Like status on a post
class LikeState {
  final bool isLiked;
  final int count;

  const LikeState({required this.isLiked, required this.count});
}

@riverpod
class LikeController extends _$LikeController {
  @override
  Future<LikeState> build(String postId) async {
    final repo = ref.watch(likeRepositoryProvider);
    final user = ref.watch(authRepositoryProvider).currentUser;

    if (user == null) {
      return const LikeState(isLiked: false, count: 0);
    }

    final isLiked = await repo.isPostLiked(postId: postId, userId: user.uid);
    final count = await repo.getLikesCount(postId);

    return LikeState(isLiked: isLiked, count: count);
  }

  Future<void> toggle() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    final repo = ref.read(likeRepositoryProvider);
    final previousState = state.value;

    if (previousState == null) return;

    // Optimistic UI update
    final newIsLiked = !previousState.isLiked;
    final newCount = newIsLiked ? previousState.count + 1 : previousState.count - 1;
    state = AsyncData(LikeState(isLiked: newIsLiked, count: newCount));

    try {
      await repo.toggleLike(postId: postId, userId: user.uid);
    } catch (e) {
      // Revert if request fails
      state = AsyncData(previousState);
    }
  }
}