
import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/providers/providers.dart';

import 'package:text_scanner/components/common/join_btns.dart';

import 'package:text_scanner/components/image_display.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scanner'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: ImageDisplay(),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: JoinBtns(
          buttons: [
            JoinBtn(
              onPressed: () async {
                await ref
                    .read(imagePickerControllerProvider.notifier)
                    .pickImage();
              },
              icon: FluentIcons.image_add_24_regular,
              label: "Pick Image",
            ),
            JoinBtn(
              onPressed: asyncImageController.valueOrNull == null
                  ? null
                  : () {
                      context.beamToNamed(
                        '/textrec',
                        data: {
                          'imagePath': asyncImageController.valueOrNull?.path
                        },
                      );
                    },
              icon: FluentIcons.scan_text_24_regular,
              label: "Scan",
            )
          ],
        ),
      ),
    );
  }
}
