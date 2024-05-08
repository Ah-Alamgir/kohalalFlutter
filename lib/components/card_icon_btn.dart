import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class CardIconBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  const CardIconBtn({
    super.key,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: .6,
      child: SizedBox(
        height: Theme.of(context).buttonTheme.height,
        child: InkWell(
          onTap: onTap,
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
    );
  }
}
