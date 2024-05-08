part of 'providers.dart';

@riverpod
class TextRecController extends _$TextRecController {
  @override
  FutureOr<String> build(String filePath) {
    return getRecText(filePath);
  }

  Future<void> extractText() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await getRecText(filePath);
    });
  }

  FutureOr<String> getRecText(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    

    String text = recognizedText.text;

    // Release resources
    await textRecognizer.close();

    if (text.isEmpty) {
      throw Exception('No text found');
    }

    return text;
  }
}
