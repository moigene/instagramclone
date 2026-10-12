import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:instagramclone/features/profile/domain/models/profile_model.dart';
import 'package:instagramclone/features/profile/domain/repositories/profile_repository.dart';


abstract class IAuthRepository {
  Stream<fb_auth.User?> get authStateChanges;
  fb_auth.User? get currentUser;

  Future<fb_auth.UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  });
  Future<fb_auth.UserCredential> signInWithEmail({
    required String email,
    required String password,
  });
  Future<void> signOut();
}

class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(this._firebaseAuth, this._profileRepository);

  final fb_auth.FirebaseAuth _firebaseAuth;
  final IProfileRepository _profileRepository;

  @override
  Stream<fb_auth.User?> get authStateChanges =>
      _firebaseAuth.authStateChanges();

  @override
  fb_auth.User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<fb_auth.UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on fb_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<fb_auth.UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;
      if (user != null) {
        // Sync user profile to Supabase 'profiles' table
        final newProfile = ProfileModel(
          id: user.uid,
          username: username.toLowerCase().trim(),
          displayName: username.trim(),
          avatarUrl: null,
          bio: null,
        );
        await _profileRepository.updateProfile(newProfile);
      }

      return credential;
    } on fb_auth.FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Exception _handleAuthException(fb_auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return Exception('Invalid email or password.');
      case 'email-already-in-use':
        return Exception('An account already exists for that email.');
      case 'weak-password':
        return Exception('The password provided is too weak.');
      default:
        return Exception(
          e.message ?? 'An unknown authentication error occurred.',
        );
    }
  }
}