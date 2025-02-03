import 'package:croppy/croppy.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:text_scanner/components/common/join_btns.dart';
import 'package:text_scanner/components/rotation_slider.dart';

Future<CropImageResult?> showModalSheetImageCropper(
  BuildContext context,
  ImageProvider imageProvider, {
  CroppableImageData? initialData,
  Object? heroTag,
  Future<CropImageResult> Function(CropImageResult)? onCropped,
}) async {
  // Before pushing the route, prepare the initial data. If it's null, populate
  // it with empty content. This is required for Hero animations.
  final prepInitialData = initialData ??
      await CroppableImageData.fromImageProvider(
        imageProvider,
      );

  if (context.mounted) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return ModalSheetImageCropper(
          imageProvider: imageProvider,
          initialData: prepInitialData,
          heroTag: heroTag,
          onCropped: onCropped,
        );
      },
    );
  }

  return null;
}

class ModalSheetImageCropper extends StatelessWidget {
  const ModalSheetImageCropper({
    super.key,
    required this.imageProvider,
    required this.initialData,
    this.heroTag,
    this.onCropped,
  });

  final ImageProvider imageProvider;
  final CroppableImageData? initialData;
  final Object? heroTag;
  final Future<CropImageResult> Function(CropImageResult)? onCropped;

  @override
  Widget build(BuildContext context) {
    return DefaultMaterialCroppableImageController(
      imageProvider: imageProvider,
      initialData: initialData,
      builder: (context, controller) {
        return CroppableImagePageAnimator(
          controller: controller,
          builder: (context, overlayOpacityAnimation) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: RepaintBoundary(
                      child: AnimatedCroppableImageViewport(
                        controller: controller,
                        cropHandlesBuilder: (context) {
                          return CupertinoImageCropHandles(
                            controller: controller,
                            gesturePadding: 16.0,
                          );
                        },
                        overlayOpacityAnimation: overlayOpacityAnimation,
                        gesturePadding: 16.0,
                        heroTag: heroTag,
                      ),
                    ),
                  ),
                  RepaintBoundary(
                    child: AnimatedBuilder(
                      animation: overlayOpacityAnimation,
                      builder: (context, _) {
                        return Opacity(
                          opacity: overlayOpacityAnimation.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Column(
                              children: <Widget>[
                                if (controller.isTransformationEnabled(
                                    Transformation.rotateZ))
                                  RotationSlider(
                                    controller: controller,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  JoinBtns(
                    buttons: [
                      JoinBtn(
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        icon: FluentIcons.dismiss_24_regular,
                      ),
                      JoinBtn(
                        onPressed: () async {
                          // Enable the Hero animations
                          CroppableImagePageAnimator.of(context)
                              ?.setHeroesEnabled(true);

                          // Crop the image
                          final result = await controller.crop();

                          if (context.mounted) {
                            Navigator.of(context).pop(result);
                          }
                        },
                        icon: FluentIcons.checkmark_24_regular,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
