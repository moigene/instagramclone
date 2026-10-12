import 'package:instagramclone/features/auth/presentation/providers/auth_providers.dart';
import 'package:instagramclone/features/posts/domain/models/post_with_profile_model.dart';
import 'package:instagramclone/features/profile/domain/models/profile_model.dart';
import 'package:instagramclone/features/profile/domain/repositories/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_providers.g.dart';

@riverpod
IProfileRepository profileRepository(Ref ref) {
  return SupabaseProfileRepository(Supabase.instance.client);
}

@riverpod
Future<ProfileModel?> userProfile(Ref ref, String userId) async {
  return await ref.watch(profileRepositoryProvider).getProfile(userId);
}

@riverpod
Future<List<PostWithProfileModel>> userGridPosts(Ref ref, String userId) async {
  final response = await Supabase.instance.client
      .from('posts')
      .select('*, profiles!posts_user_id_fkey(*)')
      .eq('user_id', userId)
      .order('created_at', ascending: false);

  final dataList = response as List<dynamic>;
  return dataList
      .map(
        (json) => PostWithProfileModel.fromJson(
          Map<String, dynamic>.from(json as Map),
        ),
      )
      .toList();
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> updateProfile({
    required String displayName,
    required String bio,
    String? avatarUrl,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return false;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentProfile = await ref
          .read(profileRepositoryProvider)
          .getProfile(user.uid);

      final updated = ProfileModel(
        id: user.uid,
        username: currentProfile?.username ?? 'user',
        displayName: displayName.trim(),
        avatarUrl: avatarUrl ?? currentProfile?.avatarUrl,
        bio: bio.trim(),
      );

      await ref.read(profileRepositoryProvider).updateProfile(updated);
      ref.invalidate(userProfileProvider(user.uid));
    });

    return !state.hasError;
  }
}
