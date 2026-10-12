import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../posts/domain/models/post_with_profile_model.dart';
import '../../../profile/domain/models/profile_model.dart';

abstract class IExploreRepository {
  Future<List<ProfileModel>> searchUsers(String query);
  Future<List<PostWithProfileModel>> getPopularPosts();
}

class SupabaseExploreRepository implements IExploreRepository {
  final SupabaseClient _supabase;

  SupabaseExploreRepository(this._supabase);

  @override
  Future<List<ProfileModel>> searchUsers(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    // Case-insensitive search across username and display_name
    final response = await _supabase
        .from('profiles')
        .select()
        .or('username.ilike.%$trimmed%,display_name.ilike.%$trimmed%')
        .limit(20);

    final dataList = response as List<dynamic>;
    return dataList
        .map((json) => ProfileModel.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }

  @override
  Future<List<PostWithProfileModel>> getPopularPosts() async {
    final response = await _supabase
        .from('posts')
        .select('*, profiles!posts_user_id_fkey(*)')
        .order('created_at', ascending: false)
        .limit(30);

    final dataList = response as List<dynamic>;
    return dataList
        .map((json) => PostWithProfileModel.fromJson(Map<String, dynamic>.from(json as Map)))
        .toList();
  }
}