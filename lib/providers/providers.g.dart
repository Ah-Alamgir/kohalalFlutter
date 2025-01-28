// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerDelegateHash() => r'16aaa51e3e20c8fd1682ec7cfb464782b37ffddf';

/// See also [routerDelegate].
@ProviderFor(routerDelegate)
final routerDelegateProvider =
    AutoDisposeProvider<Raw<BeamerDelegate>>.internal(
  routerDelegate,
  name: r'routerDelegateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerDelegateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterDelegateRef = AutoDisposeProviderRef<Raw<BeamerDelegate>>;
String _$sharedImageFileHash() => r'921f11396d9e8f9a7c390d308894129d08b95731';

/// See also [sharedImageFile].
@ProviderFor(sharedImageFile)
final sharedImageFileProvider = FutureProvider<XFile?>.internal(
  sharedImageFile,
  name: r'sharedImageFileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedImageFileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedImageFileRef = FutureProviderRef<XFile?>;
String _$croppableImageDataFromImageHash() =>
    r'7cc43ffbafe65bb1ae206e0d27218522fa4757cc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [croppableImageDataFromImage].
@ProviderFor(croppableImageDataFromImage)
const croppableImageDataFromImageProvider = CroppableImageDataFromImageFamily();

/// See also [croppableImageDataFromImage].
class CroppableImageDataFromImageFamily
    extends Family<AsyncValue<CroppableImageData>> {
  /// See also [croppableImageDataFromImage].
  const CroppableImageDataFromImageFamily();

  /// See also [croppableImageDataFromImage].
  CroppableImageDataFromImageProvider call(
    ImageProvider<Object> imageProvider,
  ) {
    return CroppableImageDataFromImageProvider(
      imageProvider,
    );
  }

  @override
  CroppableImageDataFromImageProvider getProviderOverride(
    covariant CroppableImageDataFromImageProvider provider,
  ) {
    return call(
      provider.imageProvider,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'croppableImageDataFromImageProvider';
}

/// See also [croppableImageDataFromImage].
class CroppableImageDataFromImageProvider
    extends AutoDisposeFutureProvider<CroppableImageData> {
  /// See also [croppableImageDataFromImage].
  CroppableImageDataFromImageProvider(
    ImageProvider<Object> imageProvider,
  ) : this._internal(
          (ref) => croppableImageDataFromImage(
            ref as CroppableImageDataFromImageRef,
            imageProvider,
          ),
          from: croppableImageDataFromImageProvider,
          name: r'croppableImageDataFromImageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$croppableImageDataFromImageHash,
          dependencies: CroppableImageDataFromImageFamily._dependencies,
          allTransitiveDependencies:
              CroppableImageDataFromImageFamily._allTransitiveDependencies,
          imageProvider: imageProvider,
        );

  CroppableImageDataFromImageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.imageProvider,
  }) : super.internal();

  final ImageProvider<Object> imageProvider;

  @override
  Override overrideWith(
    FutureOr<CroppableImageData> Function(
            CroppableImageDataFromImageRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CroppableImageDataFromImageProvider._internal(
        (ref) => create(ref as CroppableImageDataFromImageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        imageProvider: imageProvider,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CroppableImageData> createElement() {
    return _CroppableImageDataFromImageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CroppableImageDataFromImageProvider &&
        other.imageProvider == imageProvider;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, imageProvider.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CroppableImageDataFromImageRef
    on AutoDisposeFutureProviderRef<CroppableImageData> {
  /// The parameter `imageProvider` of this provider.
  ImageProvider<Object> get imageProvider;
}

class _CroppableImageDataFromImageProviderElement
    extends AutoDisposeFutureProviderElement<CroppableImageData>
    with CroppableImageDataFromImageRef {
  _CroppableImageDataFromImageProviderElement(super.provider);

  @override
  ImageProvider<Object> get imageProvider =>
      (origin as CroppableImageDataFromImageProvider).imageProvider;
}

String _$imagePickerControllerHash() =>
    r'e10eebcabe3205ac8b1abd16a8397b4b76e7c6ee';

/// See also [ImagePickerController].
@ProviderFor(ImagePickerController)
final imagePickerControllerProvider =
    AsyncNotifierProvider<ImagePickerController, ImagePickerState>.internal(
  ImagePickerController.new,
  name: r'imagePickerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imagePickerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImagePickerController = AsyncNotifier<ImagePickerState>;
String _$textRecControllerHash() => r'b08693782d6223104234ca026df5ef86df2166fc';

abstract class _$TextRecController
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final String filePath;

  FutureOr<String> build(
    String filePath,
  );
}

/// See also [TextRecController].
@ProviderFor(TextRecController)
const textRecControllerProvider = TextRecControllerFamily();

/// See also [TextRecController].
class TextRecControllerFamily extends Family<AsyncValue<String>> {
  /// See also [TextRecController].
  const TextRecControllerFamily();

  /// See also [TextRecController].
  TextRecControllerProvider call(
    String filePath,
  ) {
    return TextRecControllerProvider(
      filePath,
    );
  }

  @override
  TextRecControllerProvider getProviderOverride(
    covariant TextRecControllerProvider provider,
  ) {
    return call(
      provider.filePath,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'textRecControllerProvider';
}

/// See also [TextRecController].
class TextRecControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TextRecController, String> {
  /// See also [TextRecController].
  TextRecControllerProvider(
    String filePath,
  ) : this._internal(
          () => TextRecController()..filePath = filePath,
          from: textRecControllerProvider,
          name: r'textRecControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$textRecControllerHash,
          dependencies: TextRecControllerFamily._dependencies,
          allTransitiveDependencies:
              TextRecControllerFamily._allTransitiveDependencies,
          filePath: filePath,
        );

  TextRecControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.filePath,
  }) : super.internal();

  final String filePath;

  @override
  FutureOr<String> runNotifierBuild(
    covariant TextRecController notifier,
  ) {
    return notifier.build(
      filePath,
    );
  }

  @override
  Override overrideWith(TextRecController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TextRecControllerProvider._internal(
        () => create()..filePath = filePath,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        filePath: filePath,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TextRecController, String>
      createElement() {
    return _TextRecControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TextRecControllerProvider && other.filePath == filePath;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filePath.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TextRecControllerRef on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `filePath` of this provider.
  String get filePath;
}

class _TextRecControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TextRecController, String>
    with TextRecControllerRef {
  _TextRecControllerProviderElement(super.provider);

  @override
  String get filePath => (origin as TextRecControllerProvider).filePath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
