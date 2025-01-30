import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/hooks/undo_history.dart';

class TextResultsDisplay extends HookConsumerWidget {
  const TextResultsDisplay({
    super.key,
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(text: text);
    final undoController = useUndoHistoryController();

    return Column(
      children: [
        Expanded(
          child: Card(
            elevation: .5,
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                Expanded(
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
                JoinBtns(
                  shape: Border(
                      top: BorderSide(
                    color: Theme.of(context).dividerColor,
                  )),
                  padding: EdgeInsets.only(top: 8.0),
                  dividerHeightRatio: .8,
                  dividerWidth: .3,
                  buttons: [
                    JoinBtn(
                      onPressed: undoController.value.canUndo
                          ? undoController.undo
                          : null,
                      icon: FluentIcons.arrow_hook_up_left_20_regular,
                      // label: 'Undo',
                    ),
                    JoinBtn(
                      onPressed: undoController.value.canUndo
                          ? undoController.redo
                          : null,
                      icon: FluentIcons.arrow_hook_up_right_20_regular,
                      // label: 'Redo',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        JoinBtns(
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
              label: "Share",
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
              label: "Copy",
            ),
          ],
        ),
      ],
    );
  }
}
