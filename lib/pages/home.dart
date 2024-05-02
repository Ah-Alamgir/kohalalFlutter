import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/providers/providers.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scanner'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            asyncImageController.when(
              data: (data) {
                if (data == null) {
                  return const Text("No Image Selected");
                }
                return Image.file(File(data.path));
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () => const CircularProgressIndicator(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    await ref
                        .read(imagePickerControllerProvider.notifier)
                        .pickImage();
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text("Pick Image"),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  label: const Text("Scan"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
