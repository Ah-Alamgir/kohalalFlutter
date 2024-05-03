part of 'providers.dart';

@riverpod
Raw<BeamerDelegate> routerDelegate(RouterDelegateRef ref) {
  return BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        TextRecLocation(),
      ],
    ).call,
  );
}
