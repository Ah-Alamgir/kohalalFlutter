part of 'providers.dart';

@Riverpod(keepAlive: true)
FutureOr<XFile?> sharedImageFile(SharedImageFileRef ref) async {
  String? sharedImageUri = await SharedData.getSharedImageUri();

  if (sharedImageUri == null) {
    return null;
  }

  if (sharedImageUri.isEmpty) {
    return null;
  }

  try {
    File file = await toFile(sharedImageUri); // Converting uri to file

    return XFile(file.path);
  } on PlatformException {
    return null;
  }
}

@Riverpod(keepAlive: true)
class ImagePickerController extends _$ImagePickerController {
  @override
  FutureOr<XFile?> build() {
    return ref.watch(sharedImageFileProvider.future);
  }

  Future<void> pickImage() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_pickImage);
  }

  Future<void> croppyImage(CropImageResult? cropResult) async {
    if (cropResult == null) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final image = cropResult.uiImage;
      final bytesData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (bytesData == null) {
        throw Exception("No bytes found");
      }

      final bytes = bytesData.buffer.asUint8List();

      final temp = await getTemporaryDirectory();
      final fileName = p.setExtension(generateFilename(), '.png');
      final filePath = p.join(temp.path, fileName);
      final file = File(filePath);

      // Write the png bytes to the file
      await file.writeAsBytes(bytes);

      // Dispose the image if it's no longer needed (e.g. you don't use it in the UI)
      image.dispose();

      return XFile(file.path);
    });
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) {
      // User cancelled image selection
      return null;
    }

    return image;
  }
}

String generateFilename() {
  // Get the current date and time
  DateTime now = DateTime.now();

  // Format the date and time as a string
  String formattedDateTime =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}_${now.minute.toString().padLeft(2, '0')}_${now.second.toString().padLeft(2, '0')}_${now.millisecond.toString().padLeft(3, '0')}';

  // Create the filename starting with 'Crop_' followed by the formatted date and time
  String filename = 'Crop_$formattedDateTime';

  return filename;
}
