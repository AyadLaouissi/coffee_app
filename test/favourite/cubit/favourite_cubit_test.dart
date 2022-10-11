import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../coffee/cubit/coffee_cubit_test.dart';
import '../../coffee/widgets/coffee_image_test.dart';
import '../../helpers/hydrated_bloc.dart';

class MockFile extends Mock implements File {}

void main() {
  group('FavouriteCubit', () {
    late FavouriteCubit favouriteCubit;
    late CoffeeRepository coffeeRepository;
    late Coffee coffee;

    setUpAll(() {
      registerFallbackValue(FakeCoffee());
    });

    setUp(() {
      coffee = Coffee(
        url: 'https://coffee.com/123.png',
        image: File('data/123.png'),
      );
      coffeeRepository = MockCoffeeRepository();
      initHydratedStorage(
        () => favouriteCubit = FavouriteCubit(
          coffeeRepository,
          Directory('data'),
        ),
      );
      when(() => coffeeRepository.saveCoffeeImage(any()))
          .thenAnswer((_) async => File('data/persistent/123.png'));
      when(() => coffeeRepository.removeCoffeeImage(any()))
          .thenAnswer((_) async {});
    });

    test('initial state is correct', () {
      expect(favouriteCubit.state, FavouriteState());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        final state = FavouriteState(coffees: [coffee]);
        expect(
          favouriteCubit.fromJson(favouriteCubit.toJson(state)),
          isA<FavouriteState>()
              .having(
                (f) => f.coffees.length,
                'should have one coffee',
                1,
              )
              .having(
                (f) => f.coffees.first.url,
                'should contain the correct url',
                'https://coffee.com/123.png',
              )
              .having(
                (f) => f.coffees.first.imageName,
                'should contain the correct url',
                '123.png',
              )
              .having(
                (f) => f.coffees.first.image.path,
                'should contain the correct path',
                'data/123.png',
              ),
        );
      });
    });

    group('addCoffee', () {
      blocTest<FavouriteCubit, FavouriteState>(
        'calls saveCoffeeImage',
        build: () => favouriteCubit,
        act: (cubit) => cubit.addCoffee(coffee),
        verify: (_) {
          verify(() => coffeeRepository.saveCoffeeImage(coffee)).called(1);
        },
      );

      blocTest<FavouriteCubit, FavouriteState>(
        'should add coffee when empty',
        build: () => favouriteCubit,
        act: (cubit) => cubit.addCoffee(coffee),
        expect: () => [
          isA<FavouriteState>()
              .having(
                (f) => f.coffees.length,
                'should have one coffee',
                1,
              )
              .having(
                (f) => f.coffees.first.url,
                'should contain the correct url',
                'https://coffee.com/123.png',
              )
              .having(
                (f) => f.coffees.first.image.path,
                'should contain the correct path',
                'data/persistent/123.png',
              ),
        ],
      );
    });

    group('removeCoffee', () {
      blocTest<FavouriteCubit, FavouriteState>(
        'calls removeCoffee',
        build: () => favouriteCubit,
        act: (cubit) => cubit.removeCoffee(coffee),
        verify: (_) {
          verify(() => coffeeRepository.removeCoffeeImage(coffee)).called(1);
        },
      );

      blocTest<FavouriteCubit, FavouriteState>(
        'removes all the coffees from the favourite',
        seed: () => FavouriteState(
          coffees: [
            Coffee(
              url: 'https://coffee.com/123.png',
              image: File('data/123.png'),
            ),
          ],
        ),
        build: () => favouriteCubit,
        act: (cubit) => cubit.removeCoffee(coffee),
        expect: () => [FavouriteState()],
      );

      blocTest<FavouriteCubit, FavouriteState>(
        'removes one of the coffees from the favourite',
        seed: () => FavouriteState(
          coffees: [
            Coffee(
              url: 'https://coffee.com/123.png',
              image: File('data/123.png'),
            ),
            Coffee(
              url: 'https://coffee.com/456.png',
              image: File('data/456.png'),
            ),
          ],
        ),
        build: () => favouriteCubit,
        act: (cubit) => cubit.removeCoffee(coffee),
        expect: () => [
          FavouriteState(
            coffees: [
              Coffee(
                url: 'https://coffee.com/456.png',
                image: File('data/456.png'),
              ),
            ],
          ),
        ],
      );
    });
  });
}
