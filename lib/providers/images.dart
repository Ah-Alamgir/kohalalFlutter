part of 'providers.dart';

@Riverpod(keepAlive: true)
FutureOr<XFile?> sharedImageFile(Ref ref) async {
  String? sharedImageUri = await SharedData.getSharedImageUri();

  if (sharedImageUri == null) {
    return null;
  }

  if (sharedImageUri.isEmpty) {
    return null;
  }

  try {
    // Converting uri to file
    File file = await toFile(sharedImageUri); 

    return XFile(file.path);
  } on PlatformException {
    return null;
  }
}

class ImagePickerState {
  final XFile? currentImage;
  final List<XFile> history;
  final int currentIndex;

  const ImagePickerState({
    required this.currentImage,
    required this.history,
    required this.currentIndex,
  });

  bool get canUndo => currentIndex > 0;
  bool get canRedo => currentIndex < history.length - 1;
  bool get hasOriginal => history.isNotEmpty;

  ImagePickerState copyWith({
    XFile? currentImage,
    List<XFile>? history,
    int? currentIndex,
  }) {
    return ImagePickerState(
      currentImage: currentImage ?? this.currentImage,
      history: history ?? this.history,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

@Riverpod(keepAlive: true)
class ImagePickerController extends _$ImagePickerController {
  @override
  Future<ImagePickerState> build() async {
    final sharedImage = await ref.watch(sharedImageFileProvider.future);

    return ImagePickerState(
      currentImage: sharedImage,
      history: [],
      currentIndex: -1,
    );
  }

  Future<void> pickImage() async {
    final lastState = await future;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final image = await _pickImage();
      final needsReset = image != null;

      return lastState.copyWith(
        currentImage: image,
        history: needsReset ? [image] : lastState.history,
        currentIndex: needsReset ? 0 : lastState.currentIndex,
      );
    });
  }

  Future<void> croppyImage(CropImageResult? cropResult) async {
    if (cropResult == null) {
      return;
    }

    final lastState = await future;

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

      final newVersion = XFile(file.path);

      // Create new history list removing any redo history
      final newHistory = lastState.history.sublist(
        0,
        lastState.currentIndex + 1,
      );
      newHistory.add(newVersion);

      return lastState.copyWith(
        currentImage: newVersion,
        history: newHistory,
        currentIndex: newHistory.length - 1,
      );
    });
  }

  Future<void> undo() async {
    final lastState = await future;

    if (!lastState.canUndo) return;

    final newIndex = lastState.currentIndex - 1;
    return goto(newIndex);
  }

  Future<void> redo() async {
    final lastState = await future;

    if (!lastState.canRedo) return;

    final newIndex = lastState.currentIndex + 1;
    return goto(newIndex);
  }

  Future<void> goto(int index) async {
    final lastState = await future;

    if (lastState.history.isEmpty || index > lastState.history.length - 1) {
      return;
    }

    state = const AsyncLoading();
    final gotoVersion = lastState.history[index];

    state = AsyncValue.data(lastState.copyWith(
      currentImage: gotoVersion,
      currentIndex: index,
    ));
  }

  Future<void> revertToOriginal() async {
    final lastState = await future;
    if (!lastState.hasOriginal) return;
    state = const AsyncLoading();

    final originalVersion = lastState.history[0];

    state = AsyncValue.data(lastState.copyWith(
      currentImage: originalVersion,
      currentIndex: 0,
    ));
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

@riverpod
FutureOr<CroppableImageData> croppableImageDataFromImage(
  Ref ref,
  ImageProvider imageProvider,
) {
  return CroppableImageData.fromImageProvider(
    imageProvider,
  );
}
