part of 'locations.dart';

class TextRecognitionLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/textrecognition'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final pages = <BeamPage>[];

    final pathData = data as Map<String, dynamic>?;

    if (pathData == null || pathData.isEmpty) {
      return pages;
    }

    final String? imagePath = pathData['imagePath'];

    if (imagePath == null || imagePath.isEmpty) {
      return pages;
    }

    pages.add(
      BeamPage(
        key: ValueKey(imagePath),
        title: 'Text Recognition',
        child: TextRecognitionPage(imagePath),
      ),
    );

    return pages;
  }
}
