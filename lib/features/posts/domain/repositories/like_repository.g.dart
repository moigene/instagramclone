// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(likeRepository)
final likeRepositoryProvider = LikeRepositoryProvider._();

final class LikeRepositoryProvider
    extends
        $FunctionalProvider<ILikeRepository, ILikeRepository, ILikeRepository>
    with $Provider<ILikeRepository> {
  LikeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'likeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$likeRepositoryHash();

  @$internal
  @override
  $ProviderElement<ILikeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ILikeRepository create(Ref ref) {
    return likeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ILikeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ILikeRepository>(value),
    );
  }
}

String _$likeRepositoryHash() => r'fc12065be0c1fb88299b883675efb7c3f686f279';

@ProviderFor(LikeController)
final likeControllerProvider = LikeControllerFamily._();

final class LikeControllerProvider
    extends $AsyncNotifierProvider<LikeController, LikeState> {
  LikeControllerProvider._({
    required LikeControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'likeControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$likeControllerHash();

  @override
  String toString() {
    return r'likeControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  LikeController create() => LikeController();

  @override
  bool operator ==(Object other) {
    return other is LikeControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$likeControllerHash() => r'3e261591792cb0fb4830bad041c30bf8b8ecf9ba';

final class LikeControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          LikeController,
          AsyncValue<LikeState>,
          LikeState,
          FutureOr<LikeState>,
          String
        > {
  LikeControllerFamily._()
    : super(
        retry: null,
        name: r'likeControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  LikeControllerProvider call(String postId) =>
      LikeControllerProvider._(argument: postId, from: this);

  @override
  String toString() => r'likeControllerProvider';
}

abstract class _$LikeController extends $AsyncNotifier<LikeState> {
  late final _$args = ref.$arg as String;
  String get postId => _$args;

  FutureOr<LikeState> build(String postId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LikeState>, LikeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LikeState>, LikeState>,
              AsyncValue<LikeState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
