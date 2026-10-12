import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/providers/auth_providers.dart';

part 'comment_repository.g.dart';

class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;
  final String? username;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
    this.username,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profiles'] != null
        ? Map<String, dynamic>.from(json['profiles'] as Map)
        : null;
    return CommentModel(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      username: profile?['username'] as String? ?? 'User',
    );
  }
}

@riverpod
Stream<List<CommentModel>> postCommentsStream(Ref ref, String postId) {
  final supabase = Supabase.instance.client;

  return supabase
      .from('comments')
      .stream(primaryKey: ['id'])
      .eq('post_id', postId)
      .order('created_at', ascending: true)
      .asyncMap((data) async {
        if (data.isEmpty) return [];

        final userIds = data
            .map((e) => e['user_id'] as String)
            .toSet()
            .toList();
        final profilesRes = await supabase
            .from('profiles')
            .select('id, username')
            .filter('id', 'in', userIds);

        final profileMap = {
          for (var p in (profilesRes as List))
            (p as Map)['id'] as String: p['username'] as String,
        };

        return data.map((map) {
          final copy = Map<String, dynamic>.from(map);
          copy['profiles'] = {'username': profileMap[copy['user_id']]};
          return CommentModel.fromJson(copy);
        }).toList();
      });
}

@riverpod
class CommentController extends _$CommentController {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null || content.trim().isEmpty) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await Supabase.instance.client.from('comments').insert({
        'post_id': postId,
        'user_id': user.uid,
        'content': content.trim(),
      });
    });
  }
}
