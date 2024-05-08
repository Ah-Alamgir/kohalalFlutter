import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/card_icon_btn.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/providers/providers.dart';

class ImageDisplay extends HookConsumerWidget {
  final bool editable;
  const ImageDisplay({super.key, this.editable = true});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);

    return asyncImageController.when(
      data: (data) {
        if (data == null) {
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
                            Theme.of(context).iconTheme.color?.withOpacity(.3),
                        size: MediaQuery.of(context).size.shortestSide * .4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          children: [
            if (editable)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CardIconBtn(
                    onTap: () async {
                      await ref
                          .read(imagePickerControllerProvider.notifier)
                          .cropImage(data);
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
      },
      error: (error, stackTrace) {
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
