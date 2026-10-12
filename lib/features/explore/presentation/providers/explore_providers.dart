import 'package:instagramclone/features/explore/domain/repositories/explore_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../posts/domain/models/post_with_profile_model.dart';
import '../../../profile/domain/models/profile_model.dart';


part 'explore_providers.g.dart';

@riverpod
IExploreRepository exploreRepository(Ref ref) {
  return SupabaseExploreRepository(Supabase.instance.client);
}

// Search Query State
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }
}

// User Search Results Provider
@riverpod
Future<List<ProfileModel>> searchUsersResult(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.isEmpty) return [];

  final repository = ref.watch(exploreRepositoryProvider);
  return await repository.searchUsers(query);
}

// Popular Grid Posts Provider
@riverpod
Future<List<PostWithProfileModel>> popularPosts(Ref ref) async {
  final repository = ref.watch(exploreRepositoryProvider);
  return await repository.getPopularPosts();
}