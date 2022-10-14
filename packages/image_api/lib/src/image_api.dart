import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageApi {
  ImageApi({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  /// Saves the file in the temporary directory
  Future<File> getTempImage(String url) async {
    final imageName = _getFileName(url);
    final tempDir = await getTemporaryDirectory();

    // Download image
    final uri = Uri.parse(url);
    final response = await _httpClient.get(uri);

    // Create a temp file
    final file = File('${tempDir.path}/$imageName');
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  /// Saves the file in the application directory
  Future<File> saveImage(File image) async {
    final imageName = _getFileName(image.path);
    final persistentDirectory = await getApplicationDocumentsDirectory();
    return image.copy('${persistentDirectory.path}/$imageName');
  }

  /// Removes the file in the application directory
  Future<void> removeImage(File image) => image.delete();

  String _getFileName(String url) => url.split('/').last;
}
