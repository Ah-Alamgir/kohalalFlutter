import 'dart:math';
import 'package:croppy/croppy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RotationSlider extends HookWidget {
  const RotationSlider({
    super.key,
    required this.controller,
    this.color,
    this.activeColor,
  });

  final CroppableImageController controller;
  final Color? color;
  final Color? activeColor;

  double _computeDegreeSignWidth(BuildContext context, TextStyle? style) {
    final painter = TextPainter(
      text: TextSpan(text: degreeSignCharacter, style: style),
      textDirection: TextDirection.ltr,
    );

    painter.layout();
    return painter.width;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final resolvedColor = color ?? theme.colorScheme.onSurface;
    final resolvedActiveColor = activeColor ?? theme.colorScheme.primary;

    final labelStyle =
        theme.textTheme.labelMedium?.copyWith(color: resolvedColor);
    final degreeSignWidth = _computeDegreeSignWidth(context, labelStyle);

    final width = useState<double>(0.0);
    final dragStartDetails = useState<DragStartDetails?>(null);
    final dragStartValue = useState<double?>(null);

    void onPanStart(DragStartDetails details) {
      dragStartDetails.value = details;
      dragStartValue.value = controller.rotationZNotifier.value;
      controller.onStraightenStart();
    }

    void onPanUpdate(DragUpdateDetails details) {
      final delta =
          details.globalPosition - dragStartDetails.value!.globalPosition;
      final dx = delta.dx;

      // TODO: Change this so that "zero" has more width
      double value =
          dragStartValue.value! + (-dx / width.value) * ((pi / 4) * 2);
      value = value.clamp(-pi / 4, pi / 4);

      controller.onStraighten(angleRad: value);
    }

    void onPanEnd(DragEndDetails details) {
      dragStartDetails.value = null;
      dragStartValue.value = null;
      controller.onStraightenEnd();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: ClipRect(
        child: ValueListenableBuilder(
          valueListenable: controller.rotationZNotifier,
          builder: (context, rotationZ, child) {
            final value = rotationZ / (pi / 4);

            return LayoutBuilder(
              builder: (context, constraints) {
                width.value = constraints.maxWidth;

                return Column(
                  children: [
                    Transform.translate(
                      offset: Offset(degreeSignWidth / 2, 0.0),
                      child: Text(
                        getRoundedDegrees(rotationZ * 180 / pi),
                        style: labelStyle?.copyWith(
                          color: value.abs() > epsilon
                              ? theme.colorScheme.primary
                              : null,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    SizedBox(
                      width: width.value,
                      height: 16.0,
                      child: CustomPaint(
                        painter: _RotationSliderPainter(
                          value: value,
                          baseColor: resolvedColor,
                          primaryColor: resolvedActiveColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _RotationSliderPainter extends CustomPainter {
  _RotationSliderPainter({
    required this.primaryColor,
    required this.baseColor,
    required this.value,
  });

  final Color primaryColor;
  final Color baseColor;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {
    final dividerPaint = Paint()
      ..color = baseColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = size.center(Offset(-size.width / 2, 0.0) * value);

    for (var i = -45; i <= 45; i++) {
      if (i % 2 != 0) continue;
      if (((i / 45) - value).abs() < 1 / 135) continue;

      final isHighlighted = i % 20 == 0;
      final x = i * (size.width / 45) / 2;
      final _paint = dividerPaint;

      final absoluteX = center.dx + x;
      final centerDiff = ((size.width / 2) - absoluteX).abs();

      var opacity = 1.0 - (centerDiff.abs() / (size.width / 2)).clamp(0, 1);
      opacity = pow(opacity, 0.35).toDouble();

      if (!isHighlighted) {
        opacity *= 0.5;
      }

      final markValue = i / 45;
      late final bool isInValueRange;

      if (markValue == 0 && value.abs() > epsilon) {
        isInValueRange = true;
      } else if (value < 0 && markValue < 0 && value < markValue) {
        isInValueRange = true;
      } else if (value > 0 && markValue > 0 && value > markValue) {
        isInValueRange = true;
      } else {
        isInValueRange = false;
      }

      final color = isInValueRange ? primaryColor : baseColor;

      final paint = Paint()
        ..color = color.withValues(alpha: color.a * opacity)
        ..style = _paint.style
        ..strokeWidth = _paint.strokeWidth;

      canvas.drawLine(
        Offset(center.dx + x, size.height / 3),
        Offset(center.dx + x, size.height),
        paint,
      );
    }

    canvas.drawLine(
      Offset(size.center(Offset.zero).dx, 0),
      Offset(size.center(Offset.zero).dx, size.height),
      Paint()
        ..color = value.abs() > epsilon ? primaryColor : baseColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );
  }

  @override
  bool shouldRepaint(_RotationSliderPainter oldDelegate) =>
      primaryColor != oldDelegate.primaryColor || value != oldDelegate.value;
}

/// Defaults to °
String get degreeSignCharacter => '°';

/// Defaults to "12°"
String getRoundedDegrees(double degrees) {
  return '${degrees.round()}$degreeSignCharacter';
}
