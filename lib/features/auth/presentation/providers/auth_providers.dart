import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:instagramclone/features/auth/domain/repositories/auth_repositories.dart';
import 'package:instagramclone/features/profile/presentation/providers/profile_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';



part 'auth_providers.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref) {
  final profileRepo = ref.watch(profileRepositoryProvider);
  return FirebaseAuthRepository(fb_auth.FirebaseAuth.instance, profileRepo);
}

@riverpod
Stream<fb_auth.User?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    return const AsyncData(null);
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      await repo.signInWithEmail(email: email, password: password);
    });
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      await repo.signUpWithEmail(
        email: email,
        password: password,
        username: username,
      );
    });
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      await repo.signOut();
    });
  }
}