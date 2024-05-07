import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/hooks/undo_history.dart';
import 'package:text_scanner/providers/providers.dart';

class TextRecPage extends HookConsumerWidget {
  const TextRecPage(this.imagePath, {super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTextRecController =
        ref.watch(textRecControllerProvider(imagePath));
    final textController = useTextEditingController();
    final undoController = useUndoHistoryController();

    useEffect(() {
      asyncTextRecController.whenData((data) {
        textController.text = data ?? '';
      });

      return null;
    }, [asyncTextRecController.valueOrNull]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Recognition'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: asyncTextRecController.when(
          data: (data) {
            if (data == null) {
              return const Text("Error recognizing text");
            }
            // if (data.isEmpty) {
            //   return const Text("Error recognizing text");
            // }

            return Column(
              children: [
                JoinBtns(
                  buttons: [
                    JoinBtn(
                      onPressed: undoController.undo,
                      icon: FluentIcons.arrow_undo_24_regular,
                      // label: 'Undo',
                    ),
                    JoinBtn(
                      onPressed: undoController.redo,
                      icon: FluentIcons.arrow_redo_24_regular,
                      // label: 'Redo',
                    ),
                  ],
                ),
                Expanded(
                  child: Card(
                    elevation: .5,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      // height: MediaQuery.of(context).size.height * .6,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: textController,
                        undoController: undoController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return AsyncErrorView(
              error: error,
              stackTrace: stackTrace,
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
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
                final result = await Share.share(
                  textController.text,
                );

                if (result.status == ShareResultStatus.success) {
                  debugPrint('Shared successfully');
                }
              },
              icon: FluentIcons.share_24_regular,
            ),
            JoinBtn(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text: textController.text,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Text copied to clipboard'),
                  ),
                );
              },
              icon: FluentIcons.copy_24_regular,
            ),
          ],
        ),
      ),
    );
  }
}
