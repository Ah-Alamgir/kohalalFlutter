import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/providers/providers.dart';

import 'package:text_scanner/components/common/join_btns.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: asyncImageController.when(
          data: (data) {
            if (data == null) {
              return Column(
                children: [
                  Card(
                    elevation: .5,
                    child: InkWell(
                      onTap: () async {
                        await ref
                            .read(imagePickerControllerProvider.notifier)
                            .pickImage();
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .7,
                        width: MediaQuery.of(context).size.width,
                        child: Icon(
                          FluentIcons.image_add_24_regular,
                          color: Theme.of(context)
                              .iconTheme
                              .color
                              ?.withOpacity(.3),
                          size: MediaQuery.of(context).size.shortestSide * .4,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: JoinBtns(
                      buttons: [
                        JoinBtn(
                          onPressed: () async {
                            await ref
                                .read(imagePickerControllerProvider.notifier)
                                .pickImage();
                          },
                          // icon: FluentIcons.image_add_24_regular,
                          label: "Pick Image",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .7,
                  child: Stack(
                    children: [
                      Positioned.fill(
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
                      Positioned(
                        right: 0.0,
                        child: Card.outlined(
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: () {
                              ref.invalidate(imagePickerControllerProvider);
                            },
                            icon: const Icon(
                              FluentIcons.delete_24_regular,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
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
                        onPressed: () {
                          context.beamToNamed(
                            '/textrec',
                            data: {'imagePath': data.path},
                          );
                        },
                        icon: FluentIcons.scan_text_24_regular,
                        label: "Scan",
                      )
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Column(
              children: [
                Card(
                  elevation: .5,
                  child: InkWell(
                    onTap: () async {
                      await ref
                          .read(imagePickerControllerProvider.notifier)
                          .pickImage();
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width,
                      child: AsyncErrorView(
                        error: error,
                        stackTrace: stackTrace,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                  ),
                  child: JoinBtns(
                    buttons: [
                      JoinBtn(
                        onPressed: () async {
                          await ref
                              .read(imagePickerControllerProvider.notifier)
                              .pickImage();
                        },
                        // icon: FluentIcons.image_add_24_regular,
                        label: "Pick Image",
                      ),
                    ],
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
        ),
      ),
    );
  }
}
