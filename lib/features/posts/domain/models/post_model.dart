class PostModel {
  final String? id;
  final String userId;
  final String caption;
  final List<String> mediaUrls;
  final bool isVideo;
  final DateTime? createdAt;

  const PostModel({
    this.id,
    required this.userId,
    required this.caption,
    required this.mediaUrls,
    this.isVideo = false,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'user_id': userId,
      'caption': caption,
      'media_urls': mediaUrls,
      'is_video': isVideo,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String?,
      userId: json['user_id'] as String,
      caption: json['caption'] as String? ?? '',
      mediaUrls:
          (json['media_urls'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      isVideo: json['is_video'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }
}
