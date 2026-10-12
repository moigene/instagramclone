// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exploreRepository)
final exploreRepositoryProvider = ExploreRepositoryProvider._();

final class ExploreRepositoryProvider
    extends
        $FunctionalProvider<
          IExploreRepository,
          IExploreRepository,
          IExploreRepository
        >
    with $Provider<IExploreRepository> {
  ExploreRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreRepositoryHash();

  @$internal
  @override
  $ProviderElement<IExploreRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IExploreRepository create(Ref ref) {
    return exploreRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IExploreRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IExploreRepository>(value),
    );
  }
}

String _$exploreRepositoryHash() => r'31a095fd74398462fc54de17807c073be3652d04';

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'32848c18dd36b350439a45fa6338bf2df6758978';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(searchUsersResult)
final searchUsersResultProvider = SearchUsersResultProvider._();

final class SearchUsersResultProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProfileModel>>,
          List<ProfileModel>,
          FutureOr<List<ProfileModel>>
        >
    with
        $FutureModifier<List<ProfileModel>>,
        $FutureProvider<List<ProfileModel>> {
  SearchUsersResultProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchUsersResultProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchUsersResultHash();

  @$internal
  @override
  $FutureProviderElement<List<ProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProfileModel>> create(Ref ref) {
    return searchUsersResult(ref);
  }
}

String _$searchUsersResultHash() => r'e6e567f3ec478ce3c469bafae390cabc10e95119';

@ProviderFor(popularPosts)
final popularPostsProvider = PopularPostsProvider._();

final class PopularPostsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PostWithProfileModel>>,
          List<PostWithProfileModel>,
          FutureOr<List<PostWithProfileModel>>
        >
    with
        $FutureModifier<List<PostWithProfileModel>>,
        $FutureProvider<List<PostWithProfileModel>> {
  PopularPostsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularPostsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularPostsHash();

  @$internal
  @override
  $FutureProviderElement<List<PostWithProfileModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PostWithProfileModel>> create(Ref ref) {
    return popularPosts(ref);
  }
}

String _$popularPostsHash() => r'0d057e9f288d16ac95f991e0ac3a686be13cecdb';
