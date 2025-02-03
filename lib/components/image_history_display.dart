import 'dart:io';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/providers/providers.dart';

class ImageHistoryDisplay extends HookConsumerWidget {
  const ImageHistoryDisplay({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncImageController = ref.watch(imagePickerControllerProvider);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          asyncImageController.when(
            data: (data) {
              if (data.history.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text('No edit history yet'),
                );
              }

              return ListView.builder(
                itemCount: data.history.length,
                shrinkWrap: true,
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
                              ? theme.colorScheme.primary
                              : theme.colorScheme.outline
                                  .withValues(alpha: 0.1),
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
                                  style:
                                      theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? theme.colorScheme.primary
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Edit ${index + 1} of ${data.history.length}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.textTheme.bodySmall?.color
                                        ?.withValues(alpha: .5),
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
                                FluentIcons.checkmark_circle_24_filled,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
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
