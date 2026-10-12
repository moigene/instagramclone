import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:instagramclone/features/auth/presentation/providers/auth_providers.dart';
import 'package:instagramclone/features/auth/presentation/screens/login_screen.dart';
import 'package:instagramclone/features/auth/presentation/screens/signup_screen.dart';
import 'package:instagramclone/features/explore/presentation/screens/explore_screen.dart';
import 'package:instagramclone/features/navigation/presentation/screens/main_navigation_screen.dart';
import 'package:instagramclone/features/posts/presentation/screens/create_post_screen.dart';
import 'package:instagramclone/features/posts/presentation/screens/feed_screen.dart';
import 'package:instagramclone/features/profile/presentation/screens/profile_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  // Watch the Firebase Auth state
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,    
    initialLocation: '/feed',
    
    // Auth Listener & Redirect Guard
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/signup';

      // 1. If not logged in and not on auth pages, redirect to /login
      if (!isLoggedIn && !isAuthRoute) return '/login';

      // 2. If logged in and trying to access login/register, redirect to /feed (where bottom bar is visible)
      if (isLoggedIn && isAuthRoute) return '/feed';

      return null;
    },
    
    routes: [
      // Auth routes (rendered OUTSIDE the bottom navigation bar shell)
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),

      // Main App Shell (Bottom Navigation Bar wraps all these branches)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Feed
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/feed',
                builder: (context, state) => const FeedScreen(),
              ),
            ],
          ),

          // Branch 1: Search / Explore
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/explore',
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),

          // Branch 2: Create Post
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/create-post',
                builder: (context, state) => const CreatePostScreen(),
              ),
            ],
          ),

          // Branch 3: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}