import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/providers/providers.dart';

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
