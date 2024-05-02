// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerDelegateHash() => r'821e819e4834fb370ce6d3e3e5575b62a076efbc';

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
    r'e9490ff0c9d5c84fcea74756967b6bef9d4a395b';

/// See also [ImagePickerController].
@ProviderFor(ImagePickerController)
final imagePickerControllerProvider =
    AutoDisposeAsyncNotifierProvider<ImagePickerController, XFile?>.internal(
  ImagePickerController.new,
  name: r'imagePickerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imagePickerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImagePickerController = AutoDisposeAsyncNotifier<XFile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
