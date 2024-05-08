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

  Future<void> cropImage(XFile image) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );

      if (croppedFile != null) {
        return XFile(croppedFile.path);
      }

      return image;
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
