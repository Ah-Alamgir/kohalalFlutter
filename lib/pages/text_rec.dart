import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/components/text_results_display.dart';
import 'package:text_scanner/pages/image_scan_results.dart';
import 'package:text_scanner/providers/providers.dart';


class TextRecPage extends HookConsumerWidget {
  const TextRecPage(this.imagePath, {super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTextRecController =
        ref.watch(textRecControllerProvider(imagePath));

    return ImageScanResultsPage(
      imagePath: imagePath,
      scanResults: asyncTextRecController.when(
        data: (data) {
          return TextResultsDisplay(
            text: data,
          );
        },
        error: (error, stackTrace) {
          return AsyncErrorView(
            error: error,
            stackTrace: stackTrace,
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

  }
}
