import 'package:flutter/material.dart';

class JoinBtn {
  final IconData? icon;
  final String? label;
  final VoidCallback? onPressed;
  final Color? foregroundColor;

  JoinBtn({
    this.icon,
    this.label,
    this.foregroundColor,
    required this.onPressed,
  }) : assert(
          icon != null || label != null,
          'You must provide an icon or a label.',
        );
}

class JoinBtns extends StatelessWidget {
  final List<JoinBtn> buttons;
  final MainAxisAlignment mainAxisAlignment;
  final Color? dividerColor;
  final double? dividerWidth;
  final Color? color;
  final double? height;

  const JoinBtns({
    super.key,
    required this.buttons,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.dividerColor,
    this.dividerWidth = 1.0,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final btnHeight = Theme.of(context).buttonTheme.height;

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: .6,
      color: color ?? Theme.of(context).cardColor,
      child: SizedBox(
        height: height ?? btnHeight,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: buttons.expand((button) {
            return [
              Expanded(
                child: InkWell(
                  onTap: button.onPressed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        if (button.icon != null)
                          Icon(
                            button.icon,
                            color: button.foregroundColor,
                          ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        if (button.label != null)
                          Text(
                            button.label ?? "",
                            style: TextStyle(
                              // fontWeight: FontWeight.w600,
                              color: button.foregroundColor,
                              fontSize: 15.0,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (button != buttons.last)
                Container(
                  width: dividerWidth,
                  height: btnHeight * .5,
                  color: dividerColor ??
                      Theme.of(context).dividerColor.withOpacity(.5),
                ),
            ];
          }).toList(),
        ),
      ),
    );
  }
}
