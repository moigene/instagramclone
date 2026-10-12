// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storageRepository)
final storageRepositoryProvider = StorageRepositoryProvider._();

final class StorageRepositoryProvider
    extends
        $FunctionalProvider<
          IStorageRepository,
          IStorageRepository,
          IStorageRepository
        >
    with $Provider<IStorageRepository> {
  StorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageRepositoryHash();

  @$internal
  @override
  $ProviderElement<IStorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IStorageRepository create(Ref ref) {
    return storageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IStorageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IStorageRepository>(value),
    );
  }
}

String _$storageRepositoryHash() => r'd58cf6aec0360038f9eeee82b33a02308f66b40f';

@ProviderFor(MediaController)
final mediaControllerProvider = MediaControllerProvider._();

final class MediaControllerProvider
    extends $NotifierProvider<MediaController, UploadState> {
  MediaControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaControllerHash();

  @$internal
  @override
  MediaController create() => MediaController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadState>(value),
    );
  }
}

String _$mediaControllerHash() => r'62bda4ab5c71fb681717ba29b7bd07ba702cdca1';

abstract class _$MediaController extends $Notifier<UploadState> {
  UploadState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UploadState, UploadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UploadState, UploadState>,
              UploadState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
