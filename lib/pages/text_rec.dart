import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/providers/providers.dart';

class TextRecPage extends HookConsumerWidget {
  const TextRecPage(this.imagePath, {super.key});
  final String imagePath;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTextRecController =
        ref.watch(textRecControllerProvider(imagePath));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Recognition'),
        leading: IconButton(
          onPressed: () {
            if (context.canBeamBack) {
              context.beamBack();
            }
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Container(
        child: asyncTextRecController.when(
          data: (data) {
            if (data == null) {
              return const Text("Error recognizing text");
            }
            return Text(data);
          },
          error: (error, stackTrace) {
            return Text("Error: ${error.toString()}");
          },
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
