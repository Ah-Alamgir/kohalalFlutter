import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/error_image_display.dart';
import 'package:text_scanner/components/image_picker_display.dart';
import 'package:text_scanner/providers/providers.dart';

class ImageDisplay extends HookConsumerWidget {
  final bool editable;
  const ImageDisplay({
    super.key,
    this.editable = true,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);

    return asyncImageController.when(
      data: (data) {
        return ImagePickerDisplay(
          data: data,
          editable: editable,
        );
      },
      error: (error, stackTrace) {
        return ErrorImageDisplay(
          error: error,
          stackTrace: stackTrace,
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        );
      },
    );
  }
}
