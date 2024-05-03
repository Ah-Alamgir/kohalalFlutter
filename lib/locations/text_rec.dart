part of 'locations.dart';

class TextRecLocation extends BeamLocation<BeamState> {
  @override
  List<String> get pathPatterns => ['/textrec'];

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
        child: TextRecPage(imagePath),
      ),
    );

    return pages;
  }
}
