// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerDelegateHash() => r'e6c781bdfc3a0c55c18e565e1ae8d28aba267054';

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

String _$barcodeScannerControllerHash() =>
    r'cd0c4e4290cabccdbb254dfe5e916e56315a6e0d';

abstract class _$BarcodeScannerController
    extends BuildlessAutoDisposeAsyncNotifier<List<Barcode>> {
  late final String filePath;

  FutureOr<List<Barcode>> build(
    String filePath,
  );
}

/// See also [BarcodeScannerController].
@ProviderFor(BarcodeScannerController)
const barcodeScannerControllerProvider = BarcodeScannerControllerFamily();

/// See also [BarcodeScannerController].
class BarcodeScannerControllerFamily extends Family<AsyncValue<List<Barcode>>> {
  /// See also [BarcodeScannerController].
  const BarcodeScannerControllerFamily();

  /// See also [BarcodeScannerController].
  BarcodeScannerControllerProvider call(
    String filePath,
  ) {
    return BarcodeScannerControllerProvider(
      filePath,
    );
  }

  @override
  BarcodeScannerControllerProvider getProviderOverride(
    covariant BarcodeScannerControllerProvider provider,
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
  String? get name => r'barcodeScannerControllerProvider';
}

/// See also [BarcodeScannerController].
class BarcodeScannerControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BarcodeScannerController,
        List<Barcode>> {
  /// See also [BarcodeScannerController].
  BarcodeScannerControllerProvider(
    String filePath,
  ) : this._internal(
          () => BarcodeScannerController()..filePath = filePath,
          from: barcodeScannerControllerProvider,
          name: r'barcodeScannerControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$barcodeScannerControllerHash,
          dependencies: BarcodeScannerControllerFamily._dependencies,
          allTransitiveDependencies:
              BarcodeScannerControllerFamily._allTransitiveDependencies,
          filePath: filePath,
        );

  BarcodeScannerControllerProvider._internal(
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
  FutureOr<List<Barcode>> runNotifierBuild(
    covariant BarcodeScannerController notifier,
  ) {
    return notifier.build(
      filePath,
    );
  }

  @override
  Override overrideWith(BarcodeScannerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: BarcodeScannerControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<BarcodeScannerController,
      List<Barcode>> createElement() {
    return _BarcodeScannerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BarcodeScannerControllerProvider &&
        other.filePath == filePath;
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
mixin BarcodeScannerControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Barcode>> {
  /// The parameter `filePath` of this provider.
  String get filePath;
}

class _BarcodeScannerControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BarcodeScannerController,
        List<Barcode>> with BarcodeScannerControllerRef {
  _BarcodeScannerControllerProviderElement(super.provider);

  @override
  String get filePath => (origin as BarcodeScannerControllerProvider).filePath;
}

String _$selectedScanTypeHash() => r'6c877432cf830470733e205f621d4890d80fc88a';

/// See also [SelectedScanType].
@ProviderFor(SelectedScanType)
final selectedScanTypeProvider =
    NotifierProvider<SelectedScanType, ScanType>.internal(
  SelectedScanType.new,
  name: r'selectedScanTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedScanTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedScanType = Notifier<ScanType>;
String _$imagePickerControllerHash() =>
    r'77cc2fa82755591b5f560654a6f520f912cffd21';

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
String _$textRecognitionControllerHash() =>
    r'fa19226a48ebc6cbea3aa957720eca4a5726c7ea';

abstract class _$TextRecognitionController
    extends BuildlessAutoDisposeAsyncNotifier<String> {
  late final String filePath;

  FutureOr<String> build(
    String filePath,
  );
}

/// See also [TextRecognitionController].
@ProviderFor(TextRecognitionController)
const textRecognitionControllerProvider = TextRecognitionControllerFamily();

/// See also [TextRecognitionController].
class TextRecognitionControllerFamily extends Family<AsyncValue<String>> {
  /// See also [TextRecognitionController].
  const TextRecognitionControllerFamily();

  /// See also [TextRecognitionController].
  TextRecognitionControllerProvider call(
    String filePath,
  ) {
    return TextRecognitionControllerProvider(
      filePath,
    );
  }

  @override
  TextRecognitionControllerProvider getProviderOverride(
    covariant TextRecognitionControllerProvider provider,
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
  String? get name => r'textRecognitionControllerProvider';
}

/// See also [TextRecognitionController].
class TextRecognitionControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TextRecognitionController,
        String> {
  /// See also [TextRecognitionController].
  TextRecognitionControllerProvider(
    String filePath,
  ) : this._internal(
          () => TextRecognitionController()..filePath = filePath,
          from: textRecognitionControllerProvider,
          name: r'textRecognitionControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$textRecognitionControllerHash,
          dependencies: TextRecognitionControllerFamily._dependencies,
          allTransitiveDependencies:
              TextRecognitionControllerFamily._allTransitiveDependencies,
          filePath: filePath,
        );

  TextRecognitionControllerProvider._internal(
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
    covariant TextRecognitionController notifier,
  ) {
    return notifier.build(
      filePath,
    );
  }

  @override
  Override overrideWith(TextRecognitionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TextRecognitionControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TextRecognitionController, String>
      createElement() {
    return _TextRecognitionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TextRecognitionControllerProvider &&
        other.filePath == filePath;
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
mixin TextRecognitionControllerRef
    on AutoDisposeAsyncNotifierProviderRef<String> {
  /// The parameter `filePath` of this provider.
  String get filePath;
}

class _TextRecognitionControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TextRecognitionController,
        String> with TextRecognitionControllerRef {
  _TextRecognitionControllerProviderElement(super.provider);

  @override
  String get filePath => (origin as TextRecognitionControllerProvider).filePath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
