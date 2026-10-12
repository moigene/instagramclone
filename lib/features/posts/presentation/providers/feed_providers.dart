import 'package:instagramclone/features/posts/domain/models/post_with_profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'post_providers.dart';

part 'feed_providers.g.dart';

@riverpod
Future<List<PostWithProfileModel>> feedPosts(Ref ref) async {
  final postRepo = ref.watch(postRepositoryProvider);
  return await postRepo.getFeedPosts();
}