import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:text_scanner/components/common/error_view.dart';
import 'package:text_scanner/components/page_view_indicator.dart';
import 'package:text_scanner/components/text_results_display.dart';
import 'package:text_scanner/pages/image_scan_results.dart';
import 'package:text_scanner/providers/providers.dart';

class BarcodesPage extends HookConsumerWidget {
  const BarcodesPage(this.imagePath, {super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncBarcodesController =
        ref.watch(barcodeScannerControllerProvider(imagePath));

    return ImageScanResultsPage(
      imagePath: imagePath,
      scanResults: Column(
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
    return TextResultsDisplay(
      text: barcode.displayValue ?? barcode.rawValue,
    );
  }
}
