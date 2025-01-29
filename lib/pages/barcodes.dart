
import 'package:beamer/beamer.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/components/image_display.dart';
import 'package:text_scanner/hooks/undo_history.dart';
import 'package:text_scanner/providers/providers.dart';

class BarcodesPage extends HookConsumerWidget {
  const BarcodesPage(this.imagePath, {super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBarcodesController =
        ref.watch(barcodeScannerControllerProvider(imagePath));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  FluentIcons.scan_text_24_regular,
                ),
              ),
              Tab(
                icon: Icon(
                  FluentIcons.image_24_regular,
                ),
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
              Column(
                children: [
                  Expanded(
                    child: asyncBarcodesController.when(
                      data: (data) {
                        if (data.length == 1) {
                          return BarcodeView(
                            barcode: data.first,
                          );
                        }

                        return BarcodesPageView(
                          barcodes: data,
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
                ],
              ),
              const ImageDisplay(
                editable: false,
                withRescan: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarcodesPageView extends HookConsumerWidget {
  const BarcodesPageView({
    super.key,
    required this.barcodes,
  });
  final List<Barcode> barcodes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final currentPage = useState(0);

    // Listen to page changes
    useEffect(() {
      void listener() {
        currentPage.value = pageController.page!.round();
      }

      pageController.addListener(listener);
      return () => pageController.removeListener(listener);
    }, [pageController]);

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: PageViewIndicator(
            controller: pageController,
            pageCount: barcodes.length,
            direction: Axis.vertical,
            indicatorColor: Theme.of(context).indicatorColor,
            backgroundColor: Theme.of(context).disabledColor,
            spacing: 0,
            indicatorHeight: 3,
            indicatorWidthFactor: .3,
            backgroundHeight: .5,
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: barcodes.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final barcode = barcodes.elementAt(index);
              return BarcodeView(
                barcode: barcode,
              );
            },
          ),
        ),
      ],
    );
  }
}

class BarcodeView extends HookConsumerWidget {
  const BarcodeView({super.key, required this.barcode});
  final Barcode barcode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(
      text: barcode.displayValue ?? barcode.rawValue,
    );
    final undoController = useUndoHistoryController();

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
        )
      ],
    );
  }
}

class PageViewIndicator extends HookWidget {
  final PageController controller;
  final int pageCount;
  final Color indicatorColor;
  final Color backgroundColor;
  final double indicatorHeight;
  final double backgroundHeight;
  final Axis direction;
  final double spacing;
  final double indicatorWidthFactor;

  const PageViewIndicator({
    super.key,
    required this.controller,
    required this.pageCount,
    this.indicatorColor = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.indicatorHeight = 3.0,
    this.backgroundHeight = 2.0,  // Thinner background indicators
    this.direction = Axis.horizontal,
    this.spacing = 16.0,
    this.indicatorWidthFactor =
        0.8, // Indicator takes up 80% of dot width by default
  });

  @override
  Widget build(BuildContext context) {
    final pagePosition = useState<double>(controller.initialPage.toDouble());

    useEffect(() {
      void listener() {
        if (controller.page != null) {
          pagePosition.value = controller.page!;
        }
      }

      controller.addListener(listener);
      return () => controller.removeListener(listener);
    }, [controller]);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isHorizontal = direction == Axis.horizontal;
        final availableLength =
            isHorizontal ? constraints.maxWidth : constraints.maxHeight;

        // Calculate dot width based on available space and spacing
        final totalSpacing = spacing * (pageCount - 1);
        final dotLength = (availableLength - totalSpacing) / pageCount;

        final dotWidth = isHorizontal ? dotLength : indicatorHeight;
        final dotHeight = isHorizontal ? indicatorHeight : dotLength;

        return CustomPaint(
          size: Size(
            isHorizontal ? availableLength : indicatorHeight,
            isHorizontal ? indicatorHeight : availableLength,
          ),
          painter: _IndicatorPainter(
            position: pagePosition.value,
            pageCount: pageCount,
            indicatorColor: indicatorColor,
            backgroundColor: backgroundColor,
            direction: direction,
            dotWidth: dotWidth,
            dotHeight: dotHeight,
            backgroundHeight: backgroundHeight,
            spacing: spacing,
            indicatorWidthFactor: indicatorWidthFactor,
          ),
        );
      },
    );
  }
}

class _IndicatorPainter extends CustomPainter {
  final double position;
  final int pageCount;
  final Color indicatorColor;
  final Color backgroundColor;
  final Axis direction;
  final double dotWidth;
  final double dotHeight;
  final double backgroundHeight;
  final double spacing;
  final double indicatorWidthFactor;

  _IndicatorPainter({
    required this.position,
    required this.pageCount,
    required this.indicatorColor,
    required this.backgroundColor,
    required this.direction,
    required this.dotWidth,
    required this.dotHeight,
    required this.backgroundHeight,
    required this.spacing,
    required this.indicatorWidthFactor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final indicatorPaint = Paint()
      ..color = indicatorColor
      ..style = PaintingStyle.fill;

    final isHorizontal = direction == Axis.horizontal;
    // Draw background indicators
    for (int i = 0; i < pageCount; i++) {
      final x = isHorizontal ? i * (dotWidth + spacing) : 0.0;
      final y = isHorizontal ? 0.0 : i * (dotHeight + spacing);

      final backgroundWidth = isHorizontal ? dotWidth : this.backgroundHeight;
      final backgroundHeight = isHorizontal ? this.backgroundHeight : dotHeight;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, backgroundWidth, backgroundHeight),
          const Radius.circular(2.0),
        ),
        paint,
      );
    }

    // Draw the moving indicator with animation
    final currentPage = position.floor();
    final nextPage = currentPage + 1;
    final percent = position - currentPage;

    // Calculate the width/height factor based on the transition progress
    final progressFactor = 1.0 - (2.0 * (percent - 0.5).abs());
    final sizeFactor =
        indicatorWidthFactor + ((1.0 - indicatorWidthFactor) * progressFactor);

    final currentX = isHorizontal ? currentPage * (dotWidth + spacing) : 0.0;
    final currentY = isHorizontal ? 0.0 : currentPage * (dotHeight + spacing);
    final nextX = isHorizontal ? nextPage * (dotWidth + spacing) : 0.0;
    final nextY = isHorizontal ? 0.0 : nextPage * (dotHeight + spacing);

    final left = currentX + (nextX - currentX) * percent;
    final top = currentY + (nextY - currentY) * percent;

    // Calculate the indicator size
    final indicatorWidth = isHorizontal ? dotWidth * sizeFactor : dotWidth;
    final indicatorHeight = isHorizontal ? dotHeight : dotHeight * sizeFactor;
    // Center the indicator
    final xOffset = isHorizontal ? (dotWidth - indicatorWidth) / 2 : 0.0;
    final yOffset = isHorizontal ? 0.0 : (dotHeight - indicatorHeight) / 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            left + xOffset, top + yOffset, indicatorWidth, indicatorHeight),
        const Radius.circular(2.0),
      ),
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(_IndicatorPainter oldDelegate) =>
      oldDelegate.position != position ||
      oldDelegate.pageCount != pageCount ||
      oldDelegate.indicatorColor != indicatorColor ||
      oldDelegate.backgroundColor != backgroundColor ||
      oldDelegate.direction != direction ||
      oldDelegate.dotWidth != dotWidth ||
      oldDelegate.dotHeight != dotHeight ||
      oldDelegate.backgroundHeight != backgroundHeight ||
      oldDelegate.spacing != spacing ||
      oldDelegate.indicatorWidthFactor != indicatorWidthFactor;
}