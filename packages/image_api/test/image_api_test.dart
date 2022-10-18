import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:image_api/image_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFile extends Mock implements File {}

class MockFileSystemEntity extends Mock implements FileSystemEntity {}

class MockResponse extends Mock implements http.Response {}

class MockHttpClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

const String kTemporaryPath = 'test';
const String kApplicationDocumentsPath = 'persistent';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('ImageApi', () {
    late ImageApi imageApi;
    late http.Client httpClient;
    const temporaryImagePath = '$kTemporaryPath/coffee.png';
    const persistentImagePath = '$kApplicationDocumentsPath/coffee.png';

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      PathProviderPlatform.instance = FakePathProviderPlatform();

      httpClient = MockHttpClient();
      imageApi = ImageApi(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(ImageApi(), isNotNull);
      });
    });

    group('getTempImage', () {
      const url = 'https://coffee.alexflipnote.dev/coffee.png';
      File? image;

      setUp(() {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.bodyBytes).thenReturn(Uint8List.fromList([]));
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
      });

      tearDown(() {
        // removes the image from the directory
        image?.delete();
      });

      test('calls http to get the image', () async {
        image = await imageApi.getTempImage(url);

        verify(
          () => httpClient.get(
            Uri.https(
              'coffee.alexflipnote.dev',
              '/coffee.png',
            ),
          ),
        ).called(1);
      });

      test('returns image from url in the temporary directory', () async {
        image = await imageApi.getTempImage(url);
        expect(image!.path, temporaryImagePath);
      });
    });

    group('saveImage', () {
      test('returns image in the persistent directory', () async {
        final persistentImage = MockFile();
        when(() => persistentImage.path).thenReturn(persistentImagePath);

        final temporaryImage = MockFile();
        when(() => temporaryImage.path).thenReturn(temporaryImagePath);
        // returns file saved in the persistent directory
        when(() => temporaryImage.copy(any()))
            .thenAnswer((_) async => persistentImage);

        final savedImage = await imageApi.saveImage(temporaryImage);
        expect(savedImage.path, persistentImagePath);

        // verify the copy is to the right persistentImagePath
        verify(() => temporaryImage.copy(persistentImagePath)).called(1);
      });
    });

    group('removeImage', () {
      test('calls delete for the image', () async {
        final persistentFile = MockFile();
        when(persistentFile.delete)
            .thenAnswer((_) async => MockFileSystemEntity());

        await imageApi.removeImage(persistentFile);
        verify(persistentFile.delete).called(1);
      });
    });
  });
}
