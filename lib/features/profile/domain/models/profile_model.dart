class ProfileModel {
  final String id;
  final String username;
  final String displayName;
  final String? avatarUrl;
  final String? bio;

  const ProfileModel({
    required this.id,
    required this.username,
    required this.displayName,
    this.avatarUrl,
    this.bio,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      username: json['username'] as String? ?? 'user',
      displayName: json['display_name'] as String? ?? 'Instagram User',
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'bio': bio,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
