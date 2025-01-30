part of 'providers.dart';

@riverpod
Raw<BeamerDelegate> routerDelegate(Ref ref) {
  return BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        TextRecLocation(),
        BarcodesLocation(),
      ],
    ).call,
  );
}

enum ScanType {
  text,
  barcode;

  String get label {
    switch (this) {
      case ScanType.text:
        return 'Text Recognition';
      case ScanType.barcode:
        return 'Barcode & QR Scanner';
    }
  }

  String get description {
    switch (this) {
      case ScanType.text:
        return 'Extract text from images using OCR technology';
      case ScanType.barcode:
        return 'Scan and decode QR codes and barcodes from images';
    }
  }

  IconData get icon {
    switch (this) {
      case ScanType.text:
        return FluentIcons.scan_type_20_regular;
      case ScanType.barcode:
        return FluentIcons.qr_code_20_regular;
    }
  }
}

@Riverpod(keepAlive: true)
class SelectedScanType extends _$SelectedScanType {
  @override
  ScanType build() {
    return ScanType.text;
  }

  void selectType(ScanType type) {
    state = type;
  }
}