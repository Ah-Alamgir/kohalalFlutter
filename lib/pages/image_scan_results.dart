import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/components/image_display.dart';
import 'package:text_scanner/providers/providers.dart';

class ImageScanResultsPage extends ConsumerWidget {
  const ImageScanResultsPage({
    super.key,
    required this.imagePath,
    required this.scanResults,
  });

  final String imagePath;
  final Widget scanResults;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: IconButton(
            onPressed: () {
              if (context.canBeamBack) {
                context.beamBack();
              }
            },
            icon: const Icon(
              FluentIcons.arrow_left_24_regular,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                // icon: Icon(
                //   FluentIcons.scan_text_24_regular,
                // ),
                text: "Text",
              ),
              Tab(
                // icon: Icon(
                //   FluentIcons.image_24_regular,
                // ),
                text: "Image",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ).copyWith(
            top: 16.0,
            bottom: 16.0,
          ),
          child: TabBarView(
            children: [
              scanResults,
              Column(
                children: [
                  Expanded(
                    child: const ImageDisplay(
                      editable: false,
                    ),
                  ),
                  JoinBtns(
                    buttons: [
                      JoinBtn(
                        onPressed: () {
                          ref.invalidate(
                              barcodeScannerControllerProvider(imagePath));
                          ref.invalidate(textRecognitionControllerProvider(imagePath));
                        },
                        label: "Rescan",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
