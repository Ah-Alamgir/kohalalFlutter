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
  final double dividerHeightRatio;
  final double iconSize;
  final Color? color;
  final double? height;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const JoinBtns({
    super.key,
    required this.buttons,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.dividerColor,
    this.dividerWidth = 1.0,
    this.color,
    this.height,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.dividerHeightRatio = .5,
    this.iconSize = 20.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final btnHeight = theme.buttonTheme.height;

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: .6,
      color: color ?? Theme.of(context).cardColor,
      shape: shape,
      child: Padding(
        padding: padding,
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
                              size: iconSize,
                              color: button.onPressed == null
                                  ? theme.disabledColor
                                  : button.foregroundColor,
                            ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          if (button.label != null)
                            Text(
                              button.label ?? "",
                              style: TextStyle(
                                fontSize: 15.0,
                              ).merge(textStyle).copyWith(
                                    color: button.onPressed == null
                                        ? theme.disabledColor
                                        : button.foregroundColor,
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
                    height: btnHeight * dividerHeightRatio,
                    color: dividerColor ??
                        theme.dividerColor.withValues(alpha: .5),
                  ),
              ];
            }).toList(),
          ),
        ),
      ),
    );
  }
}
