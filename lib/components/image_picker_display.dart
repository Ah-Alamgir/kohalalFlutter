import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/components/image_cropper.dart';
import 'package:text_scanner/components/image_history_display.dart';
import 'package:text_scanner/components/no_image_display.dart';
import 'package:text_scanner/providers/providers.dart';

class ImagePickerDisplay extends ConsumerWidget {
  const ImagePickerDisplay({
    super.key,
    required this.data,
    required this.editable,
  });

  final ImagePickerState data;
  final bool editable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final image = data.currentImage;

    if (image == null) {
      return NoImageDisplay();
    }

    return Card(
      elevation: .5,
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: image.path,
                child: Image.file(
                  File(
                    image.path,
                  ),
                ),
              ),
            ),
          ),
          if (editable)
            JoinBtns(
              dividerColor: theme.dividerColor.withValues(alpha: .3),
              padding: EdgeInsets.only(top: 8.0),
              dividerHeightRatio: .5,
              dividerWidth: .3,
              shape: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              buttons: [
                JoinBtn(
                  onPressed: data.history.length <= 1
                      ? null
                      : () async {
                          await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            isDismissible: true,
                            showDragHandle: true,
                            backgroundColor: theme.cardColor,
                            builder: (context) {
                              return ImageHistoryDisplay();
                            },
                          );
                        },
                  icon: FluentIcons.history_20_regular,
                ),
                JoinBtn(
                  onPressed: data.history.length <= 1
                      ? null
                      : () async {
                          await ref
                              .read(imagePickerControllerProvider.notifier)
                              .revertToOriginal();
                        },
                  icon: FluentIcons.arrow_reset_20_regular,
                ),
                JoinBtn(
                  onPressed: data.canUndo
                      ? () async {
                          await ref
                              .read(imagePickerControllerProvider.notifier)
                              .undo();
                        }
                      : null,
                  icon: FluentIcons.arrow_hook_up_left_20_regular,
                ),
                JoinBtn(
                  onPressed: data.canRedo
                      ? () async {
                          await ref
                              .read(imagePickerControllerProvider.notifier)
                              .redo();
                        }
                      : null,
                  icon: FluentIcons.arrow_hook_up_right_20_regular,
                ),
                JoinBtn(
                  onPressed: () async {
                    final cropResult = await showImageCropper(
                      context,
                      heroTag: image.path,
                      FileImage(
                        File(image.path),
                      ), // Or any other image provider
                    );

                    await ref
                        .read(imagePickerControllerProvider.notifier)
                        .croppyImage(cropResult);
                  },
                  icon: FluentIcons.crop_20_regular,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
