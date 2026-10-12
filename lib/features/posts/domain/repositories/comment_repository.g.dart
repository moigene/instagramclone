// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(postCommentsStream)
final postCommentsStreamProvider = PostCommentsStreamFamily._();

final class PostCommentsStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CommentModel>>,
          List<CommentModel>,
          Stream<List<CommentModel>>
        >
    with
        $FutureModifier<List<CommentModel>>,
        $StreamProvider<List<CommentModel>> {
  PostCommentsStreamProvider._({
    required PostCommentsStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'postCommentsStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postCommentsStreamHash();

  @override
  String toString() {
    return r'postCommentsStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<CommentModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<CommentModel>> create(Ref ref) {
    final argument = this.argument as String;
    return postCommentsStream(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentsStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postCommentsStreamHash() =>
    r'c7600d2b7bfebfcd6a65a81066276fa7084f9304';

final class PostCommentsStreamFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<CommentModel>>, String> {
  PostCommentsStreamFamily._()
    : super(
        retry: null,
        name: r'postCommentsStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostCommentsStreamProvider call(String postId) =>
      PostCommentsStreamProvider._(argument: postId, from: this);

  @override
  String toString() => r'postCommentsStreamProvider';
}

@ProviderFor(CommentController)
final commentControllerProvider = CommentControllerProvider._();

final class CommentControllerProvider
    extends $NotifierProvider<CommentController, AsyncValue<void>> {
  CommentControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'commentControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$commentControllerHash();

  @$internal
  @override
  CommentController create() => CommentController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$commentControllerHash() => r'1dbcca54d371de04e876dc6ab28a317168e1b62e';

abstract class _$CommentController extends $Notifier<AsyncValue<void>> {
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
