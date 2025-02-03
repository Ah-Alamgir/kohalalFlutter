import 'package:croppy/croppy.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:text_scanner/components/common/join_btns.dart';

import 'rotation_slider.dart';

class ImageCropper extends StatelessWidget {
  const ImageCropper({
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
        // Used to animate the page with Hero animations. Can be omitted if
        // you don't want to use Hero animations.
        return CroppableImagePageAnimator(
          controller: controller,
          heroTag: heroTag,
          builder: (context, overlayOpacityAnimation) {
            return Scaffold(
              // appBar: AppBar(
              //   title: const Text('Crop Image'),
              //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: .5,
                          clipBehavior: Clip.hardEdge,
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
                                    overlayOpacityAnimation:
                                        overlayOpacityAnimation,
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
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16.0,
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            const Divider(),
                                            if (controller
                                                .isTransformationEnabled(
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
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
                ),
              ),
            );
          },
        );
      },
    );
  }
}

Future<CropImageResult?> showImageCropper(
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
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ImageCropper(
            imageProvider: imageProvider,
            initialData: prepInitialData,
            heroTag: heroTag,
            onCropped: onCropped,
          );
        },
      ),
    );
  }

  return null;
}
