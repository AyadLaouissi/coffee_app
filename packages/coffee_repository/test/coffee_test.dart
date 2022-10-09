import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'coffee_repository_test.dart';

void main() {
  group('Coffee', () {
    const url = 'https://coffee.alexflipnote.dev/vkaytB28iAU_coffee.jpg';
    const filePath = '/data/vkaytB28iAU_coffee.jpg';
    late MockFile image;
    late Coffee coffee;

    setUp(() {
      image = MockFile();
      when(() => image.path).thenReturn(filePath);
      coffee = Coffee(url: url, image: image);
    });

    group('fromJson', () {
      test('returns correct Coffee object', () {
        expect(
          Coffee.fromJson(
            const <String, dynamic>{
              'url': url,
              'image_path': filePath,
            },
          ),
          isA<Coffee>()
              .having((c) => c.url, 'url', url)
              .having((c) => c.image.path, 'url', filePath),
        );
      });
    });

    group('toJson', () {
      test('returns correct json', () {
        expect(
          coffee.toJson(),
          const <String, dynamic>{
            'url': url,
            'image_path': filePath,
          },
        );
      });
    });

    group('copyWith', () {
      test('changes correctly url', () {
        expect(
          coffee.copyWith(url: 'https://new.com'),
          isA<Coffee>()
              .having((c) => c.url, 'url', 'https://new.com')
              .having((c) => c.image.path, 'url', filePath),
        );
      });

      test('changes correctly image', () {
        const newFilePath = '/data/12345_coffee.jpg';
        final newImage = MockFile();
        when(() => newImage.path).thenReturn(newFilePath);

        expect(
          coffee.copyWith(image: newImage),
          isA<Coffee>()
              .having((c) => c.url, 'url', url)
              .having((c) => c.image.path, 'url', newFilePath),
        );
      });
    });
  });
}
