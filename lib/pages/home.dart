import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/locations/locations.dart';
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
          children: asyncImageController.when(
            data: (data) {
              if (data == null) {
                return [
                  const Text("No Image Selected"),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImagePickerBtn(),
                    ],
                  )
                ];
              }
              return [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ref.invalidate(imagePickerControllerProvider);
                      },
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                Image.file(
                  File(
                    data.path,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const ImagePickerBtn(),
                    TextButton.icon(
                      onPressed: () {
                        context.beamToNamed(
                          '/textrec',
                          data: {'imagePath': data.path},
                        );
                      },
                      icon: const Icon(Icons.search),
                      label: const Text("Scan"),
                    ),
                  ],
                ),
              ];
            },
            error: (error, stackTrace) {
              return [Text(error.toString())];
            },
            loading: () {
              return [
                const CircularProgressIndicator(),
              ];
            },
          ),
        ),
      ),
    );
  }
}

class ImagePickerBtn extends HookConsumerWidget {
  const ImagePickerBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton.icon(
      onPressed: () async {
        await ref.read(imagePickerControllerProvider.notifier).pickImage();
      },
      icon: const Icon(Icons.photo),
      label: const Text("Pick Image"),
    );
  }
}
