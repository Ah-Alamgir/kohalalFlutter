part of 'providers.dart';

@riverpod
class BarcodeScannerController extends _$BarcodeScannerController {
  @override
  FutureOr<List<Barcode>> build(String filePath) {
    return getBarcodes(filePath);
  }

  Future<void> scanCodes() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await getBarcodes(filePath);
    });
  }

  FutureOr<List<Barcode>> getBarcodes(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final barcodeScanner = BarcodeScanner();
    final barcodes = await barcodeScanner.processImage(inputImage);

    if (barcodes.isEmpty) {
      throw Exception("No barcodes found");
    }

    return barcodes;
  }
}
