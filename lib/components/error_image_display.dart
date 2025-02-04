import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/providers/providers.dart';

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
