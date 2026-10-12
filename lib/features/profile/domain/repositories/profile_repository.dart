import 'package:instagramclone/features/profile/domain/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract class IProfileRepository {
  Future<ProfileModel?> getProfile(String userId);
  Future<void> updateProfile(ProfileModel profile);
}

class SupabaseProfileRepository implements IProfileRepository {
  final SupabaseClient _supabase;

  SupabaseProfileRepository(this._supabase);

  @override
  Future<ProfileModel?> getProfile(String userId) async {
    final data = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    await _supabase.from('profiles').upsert(profile.toJson());
  }
}
