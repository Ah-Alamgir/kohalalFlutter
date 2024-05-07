import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                            color: Theme.of(context)
                                .iconTheme
                                .color
                                ?.withOpacity(.3),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      clipBehavior: Clip.hardEdge,
                      elevation: .6,
                      child: SizedBox(
                        height: Theme.of(context).buttonTheme.height,
                        child: InkWell(
                          onTap: () async {
                            await ref
                                .read(imagePickerControllerProvider.notifier)
                                .cropImage(data);
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 8.0,
                            ),
                            child: Icon(
                              FluentIcons.crop_24_regular,
                            ),
                          ),
                        ),
                      ),
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
        ),
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
