import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/models/post_model.dart';
import '../../domain/repositories/post_repository.dart';

part 'post_providers.g.dart';

@riverpod
IPostRepository postRepository(Ref ref) {
  return SupabasePostRepository(Supabase.instance.client);
}

@riverpod
class PostController extends _$PostController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<bool> createPost({
    required String caption,
    required String mediaUrl,
  }) async {
    state = const AsyncValue.loading();

    // Retrieve active Firebase User ID
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      state = AsyncValue.error(
        Exception('User is not authenticated'),
        StackTrace.current,
      );
      return false;
    }

    state = await AsyncValue.guard(() async {
      final post = PostModel(
        userId: currentUser.uid,
        caption: caption.trim(),
        mediaUrls: [mediaUrl],
        isVideo: false,
      );

      await ref.read(postRepositoryProvider).createPost(post);
    });

    return !state.hasError;
  }
}