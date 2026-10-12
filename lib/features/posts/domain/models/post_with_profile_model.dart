import 'package:instagramclone/features/profile/domain/models/profile_model.dart';

class PostWithProfileModel {
  final String id;
  final String userId;
  final String caption;
  final List<String> mediaUrls;
  final bool isVideo;
  final DateTime createdAt;
  final ProfileModel profile;

  const PostWithProfileModel({
    required this.id,
    required this.userId,
    required this.caption,
    required this.mediaUrls,
    required this.isVideo,
    required this.createdAt,
    required this.profile,
  });

  factory PostWithProfileModel.fromJson(Map<String, dynamic> json) {
    return PostWithProfileModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      caption: json['caption'] as String? ?? '',
      mediaUrls:
          (json['media_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isVideo: json['is_video'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      profile: ProfileModel.fromJson(
        Map<String, dynamic>.from(json['profiles'] as Map? ?? {}),
      ),
    );
  }
}
