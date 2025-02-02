import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/scan_type_selector.dart';
import 'package:text_scanner/providers/providers.dart';

import 'package:text_scanner/components/common/join_btns.dart';

import 'package:text_scanner/components/image_display.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);
    final scanType = ref.watch(selectedScanTypeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scanner'),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ).copyWith(
          bottom: 16.0,
        ),
        child: Column(
          children: [
            Expanded(
              child: ImageDisplay(),
            ),
            if (asyncImageController.valueOrNull?.currentImage != null)
              JoinBtns(
                buttons: [
                  JoinBtn(
                    onPressed: () async {
                      await ref
                          .read(imagePickerControllerProvider.notifier)
                          .pickImage();
                    },
                    icon: FluentIcons.image_add_24_regular,
                    label: "Choose Image",
                  ),
                ],
              ),
            SizedBox(
              height: 8.0,
            ),
            ScanTypeSelector(),
            SizedBox(
              height: 8.0,
            ),
            JoinBtns(
              color: asyncImageController.valueOrNull?.currentImage == null
                  ? theme.disabledColor
                  : theme.colorScheme.primary,
              height: theme.buttonTheme.height * 1.3,
              textStyle: theme.textTheme.labelLarge,
              buttons: [
                JoinBtn(
                  foregroundColor: theme.colorScheme.onPrimary,
                  onPressed:
                      asyncImageController.valueOrNull?.currentImage == null
                          ? null
                          : () {
                              context.beamToNamed(
                                scanType == ScanType.text
                                    ? '/textrecognition'
                                    : '/barcodes',
                                data: {
                                  'imagePath': asyncImageController
                                      .valueOrNull?.currentImage?.path
                                },
                              );
                            },
                  // icon: scanType.icon,
                  label: "SCAN",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
