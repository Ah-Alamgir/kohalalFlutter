import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_scanner/components/card_icon_btn.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/components/image_cropper.dart';
import 'package:text_scanner/providers/providers.dart';

class ImageDisplay extends HookConsumerWidget {
  final bool editable;
  final bool withRescan;
  const ImageDisplay({
    super.key,
    this.editable = true,
    this.withRescan = false,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);
    final theme = Theme.of(context);

    return asyncImageController.when(
      data: (data) {
        final image = data.currentImage;

        if (image == null) {
          return NoImageDisplay();
        }

        return Column(
          children: [
            Expanded(
              child: Card(
                elevation: .5,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  // height: MediaQuery.of(context).size.height * .6,
                  width: MediaQuery.of(context).size.width,
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
                dividerWidth: .5,
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
                              backgroundColor: Theme.of(context).cardColor,
                              builder: (context) {
                                return ImageHistoryDisplay();
                              },
                            );
                          },
                    icon: FluentIcons.history_24_regular,
                  ),
                  JoinBtn(
                    onPressed: () async {
                      await ref
                          .read(imagePickerControllerProvider.notifier)
                          .revertToOriginal();
                    },
                    icon: FluentIcons.arrow_reset_24_regular,
                  ),
                  JoinBtn(
                    onPressed: data.canUndo
                        ? () async {
                            await ref
                                .read(imagePickerControllerProvider.notifier)
                                .undo();
                          }
                        : null,
                    icon: FluentIcons.arrow_undo_24_regular,
                  ),
                  JoinBtn(
                    onPressed: data.canRedo
                        ? () async {
                            await ref
                                .read(imagePickerControllerProvider.notifier)
                                .redo();
                          }
                        : null,
                    icon: FluentIcons.arrow_redo_24_regular,
                  ),
                  JoinBtn(
                    onPressed: () async {
                      final cropResult = await showImageCropper(
                        context,
                        FileImage(
                          File(image.path),
                        ), // Or any other image provider
                      );

                      await ref
                          .read(imagePickerControllerProvider.notifier)
                          .croppyImage(cropResult);
                    },
                    icon: FluentIcons.crop_24_regular,
                  ),
                ],
              ),
            if (withRescan)
              JoinBtns(
                buttons: [
                  JoinBtn(
                    onPressed: asyncImageController.valueOrNull?.currentImage ==
                            null
                        ? null
                        : () {
                            ref.invalidate(
                                barcodeScannerControllerProvider(image.path));
                            ref.invalidate(
                                textRecControllerProvider(image.path));
                          },
                    label: "Rescan",
                  ),
                ],
              ),
          ],
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

class ImageHistoryDisplay extends HookConsumerWidget {
  const ImageHistoryDisplay({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Text(
                  'Edit History',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(),
          asyncImageController.when(
            data: (data) {
              if (data.history.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No edit history yet'),
                );
              }

              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: ListView.separated(
                  itemCount: data.history.length,
                  reverse: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final isSelected = index == data.currentIndex;
                    final isOriginal = index == 0;

                    return GestureDetector(
                      onTap: () async {
                        await ref
                            .read(imagePickerControllerProvider.notifier)
                            .goto(index);

                        if (context.mounted) Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.withValues(alpha: 0.3),
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Thumbnail
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(data.history[index].path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Version Info
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isOriginal ? 'Original' : 'Version $index',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Edit ${index + 1} of ${data.history.length}',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Selection indicator
                            if (isSelected)
                              Container(
                                margin: const EdgeInsets.all(16),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            error: (error, stackTrace) {
              return AsyncErrorView(
                error: error,
                stackTrace: stackTrace,
              );
            },
            loading: () {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FileImageDisplay extends ConsumerWidget {
  const FileImageDisplay({
    super.key,
    required this.data,
    this.editable = true,
  });
  final bool editable;
  final XFile data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        if (editable)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CardIconBtn(
                onTap: () async {
                  final cropResult = await showImageCropper(
                    context,
                    FileImage(
                      File(data.path),
                    ), // Or any other image provider
                  );

                  await ref
                      .read(imagePickerControllerProvider.notifier)
                      .croppyImage(cropResult);
                },
                icon: FluentIcons.crop_24_regular,
              ),
            ],
          ),
        Expanded(
          child: Card(
            elevation: .5,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(
                  data.path,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NoImageDisplay extends ConsumerWidget {
  const NoImageDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Card(
            elevation: .5,
            child: InkWell(
              onTap: () async {
                await ref
                    .read(imagePickerControllerProvider.notifier)
                    .pickImage();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Icon(
                  FluentIcons.image_add_24_regular,
                  color:
                      Theme.of(context).iconTheme.color?.withValues(alpha: .3),
                  size: MediaQuery.of(context).size.shortestSide * .4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ErrorImageDisplay extends ConsumerWidget {
  const ErrorImageDisplay({
    super.key,
    required this.error,
    required this.stackTrace,
  });
  final Object error;
  final StackTrace stackTrace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Card(
            elevation: .5,
            child: InkWell(
              onTap: () async {
                await ref
                    .read(imagePickerControllerProvider.notifier)
                    .pickImage();
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AsyncErrorView(
                  error: error,
                  stackTrace: stackTrace,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
