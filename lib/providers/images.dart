part of 'providers.dart';

@Riverpod(keepAlive: true)
class ImagePickerController extends _$ImagePickerController {
  @override
  FutureOr<XFile?> build() {
    return null;
  }

  Future<void> pickImage() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_pickImage);
  }

  Future<XFile?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) {
      throw Exception('No image selected');
    }
    // Add your validation logic here
    return image;
  }
}
