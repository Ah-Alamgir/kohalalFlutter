import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
      ),
      body: asyncImageController.when(
        data: (data) {
          if (data == null) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
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
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
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
                        child: IconButton(
                          onPressed: () {
                            ref.invalidate(imagePickerControllerProvider);
                          },
                          icon: const Icon(
                            Icons.close,
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
            ),
          );
        },
        error: (error, stackTrace) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Column(
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
                      child: SingleChildScrollView(
                        primary: false,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FluentIcons.warning_20_regular,
                              size: MediaQuery.of(context).size.shortestSide *
                                  .15,
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Oops, something went wrong.\n\n',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  const TextSpan(
                                    children: [TextSpan(text: "\n\n")],
                                  ),
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Details\n',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      TextSpan(
                                        text: "${error.toString()}\n\n",
                                      ),
                                    ],
                                  ),
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Solution\n",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const TextSpan(
                                        text:
                                            "Please pick a different image.\n\n",
                                      ),
                                    ],
                                  ),
                                  const TextSpan(
                                    text:
                                        "If you need further assistance, please reach out to our support team.",
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
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
            ),
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
