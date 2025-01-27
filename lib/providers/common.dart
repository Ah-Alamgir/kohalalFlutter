part of 'providers.dart';

@riverpod
Raw<BeamerDelegate> routerDelegate(Ref ref) {
  return BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        TextRecLocation(),
      ],
    ).call,
  );
}
