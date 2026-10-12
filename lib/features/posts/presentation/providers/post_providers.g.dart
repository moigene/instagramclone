// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postRepository)
final postRepositoryProvider = PostRepositoryProvider._();

final class PostRepositoryProvider
    extends
        $FunctionalProvider<IPostRepository, IPostRepository, IPostRepository>
    with $Provider<IPostRepository> {
  PostRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postRepositoryHash();

  @$internal
  @override
  $ProviderElement<IPostRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IPostRepository create(Ref ref) {
    return postRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IPostRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IPostRepository>(value),
    );
  }
}

String _$postRepositoryHash() => r'62e3340aecea56ef61d684e3db73ce6a04f05a2f';

@ProviderFor(PostController)
final postControllerProvider = PostControllerProvider._();

final class PostControllerProvider
    extends $NotifierProvider<PostController, AsyncValue<void>> {
  PostControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'postControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$postControllerHash();

  @$internal
  @override
  PostController create() => PostController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$postControllerHash() => r'4ec1ed7edbab1db4f0fb5c324cf4582a5dea9f1d';

abstract class _$PostController extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
