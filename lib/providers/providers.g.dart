// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerDelegateHash() => r'04e01521a28ad37aa85006a57860f8494a729dd0';

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

typedef RouterDelegateRef = AutoDisposeProviderRef<Raw<BeamerDelegate>>;
String _$imagePickerControllerHash() =>
    r'056b3b619365bf2c2420610815bed7b16a0740f5';

/// See also [ImagePickerController].
@ProviderFor(ImagePickerController)
final imagePickerControllerProvider =
    AsyncNotifierProvider<ImagePickerController, XFile?>.internal(
  ImagePickerController.new,
  name: r'imagePickerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imagePickerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImagePickerController = AsyncNotifier<XFile?>;
String _$textRecControllerHash() => r'cc5aa6829bc3e18dc9f33647c613e3f0a1ce9034';

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

abstract class _$TextRecController
    extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final String filePath;

  FutureOr<String?> build(
    String filePath,
  );
}

/// See also [TextRecController].
@ProviderFor(TextRecController)
const textRecControllerProvider = TextRecControllerFamily();

/// See also [TextRecController].
class TextRecControllerFamily extends Family<AsyncValue<String?>> {
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
    extends AutoDisposeAsyncNotifierProviderImpl<TextRecController, String?> {
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
  FutureOr<String?> runNotifierBuild(
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
  AutoDisposeAsyncNotifierProviderElement<TextRecController, String?>
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

mixin TextRecControllerRef on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `filePath` of this provider.
  String get filePath;
}

class _TextRecControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TextRecController, String?>
    with TextRecControllerRef {
  _TextRecControllerProviderElement(super.provider);

  @override
  String get filePath => (origin as TextRecControllerProvider).filePath;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
