import 'package:instagramclone/features/posts/domain/models/post_with_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/post_model.dart';

abstract class IPostRepository {
  Future<void> createPost(PostModel post);
  Future<List<PostWithProfileModel>> getFeedPosts();
}

class SupabasePostRepository implements IPostRepository {
  final SupabaseClient _supabaseClient;

  SupabasePostRepository(this._supabaseClient);

  @override
  Future<void> createPost(PostModel post) async {
    await _supabaseClient.from('posts').insert(post.toJson());
  }

  @override
  Future<List<PostWithProfileModel>> getFeedPosts() async {
    // Relational join select: fetches all post columns and inner joins profiles
    final response = await _supabaseClient
        .from('posts')
        .select('*, profiles!posts_user_id_fkey(*)')
        .order('created_at', ascending: false);

    final dataList = response as List<dynamic>;
    return dataList
        .map(
          (json) => PostWithProfileModel.fromJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
