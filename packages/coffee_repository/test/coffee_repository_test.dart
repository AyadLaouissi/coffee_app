import 'dart:io';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_api/image_api.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeApiClient extends Mock implements CoffeeApiClient {}

class MockImageApi extends Mock implements ImageApi {}

class MockFile extends Mock implements File {}

void main() {
  group('CoffeeRepository', () {
    late CoffeeRepository coffeeRepository;
    late CoffeeApiClient coffeeApiClient;
    late ImageApi imageApi;
    late MockFile image;
    late Coffee coffee;
    const url = 'https://coffee.alexflipnote.dev/vkaytB28iAU_coffee.jpg';

    setUp(() {
      image = MockFile();
      coffee = Coffee(url: url, image: image);
      imageApi = MockImageApi();
      coffeeApiClient = MockCoffeeApiClient();
      coffeeRepository = CoffeeRepository(
        coffeeApiClient: coffeeApiClient,
        imageApi: imageApi,
      );
    });

    group('constructor', () {
      test('does not require an CoffeeApiClient', () {
        expect(CoffeeRepository(), isNotNull);
      });
    });

    group('getRandomCoffee', () {
      test('returns correct url on success', () async {
        when(coffeeApiClient.getRandomCoffee).thenAnswer((_) async => url);
        when(() => imageApi.getTempImage(url)).thenAnswer((_) async => image);

        final response = await coffeeRepository.getRandomCoffee();
        expect(response, coffee);

        verify(coffeeApiClient.getRandomCoffee).called(1);
        verify(() => imageApi.getTempImage(url)).called(1);
      });

      test('throws when randomCoffee fails', () async {
        final exception = Exception('oops');
        when(coffeeApiClient.getRandomCoffee).thenThrow(exception);

        expect(
          coffeeRepository.getRandomCoffee,
          throwsA(exception),
        );
      });

      test('throws when getTempImage fails', () async {
        final exception = Exception('oops');
        when(coffeeApiClient.getRandomCoffee).thenAnswer((_) async => url);
        when(() => imageApi.getTempImage(any())).thenThrow(exception);

        expect(
          coffeeRepository.getRandomCoffee,
          throwsA(exception),
        );
      });
    });

    group('saveCoffeeImage', () {
      test('returns saved image', () async {
        final File savedImage = MockFile();
        when(() => imageApi.saveImage(image))
            .thenAnswer((_) async => savedImage);

        expect(await coffeeRepository.saveCoffeeImage(coffee), savedImage);
        verify(() => imageApi.saveImage(image)).called(1);
      });
    });

    group('removeCoffeeImage', () {
      test('remove saved image', () async {
        when(() => imageApi.removeImage(image)).thenAnswer((_) async => {});

        await coffeeRepository.removeCoffeeImage(coffee);
        verify(() => imageApi.removeImage(image)).called(1);
      });
    });
  });
}
