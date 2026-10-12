// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(feedPosts)
final feedPostsProvider = FeedPostsProvider._();

final class FeedPostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostWithProfileModel>>,
          List<PostWithProfileModel>,
          FutureOr<List<PostWithProfileModel>>
        >
    with
        $FutureModifier<List<PostWithProfileModel>>,
        $FutureProvider<List<PostWithProfileModel>> {
  FeedPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedPostsHash();

  @$internal
  @override
  $FutureProviderElement<List<PostWithProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostWithProfileModel>> create(Ref ref) {
    return feedPosts(ref);
  }
}

String _$feedPostsHash() => r'c5f4212efc6d89ba97d8d6719e4361a56b139d4f';
