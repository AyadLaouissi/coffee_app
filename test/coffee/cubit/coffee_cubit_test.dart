import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('CoffeeCubit', () {
    late CoffeeCubit cubit;
    late Coffee coffee;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffee = Coffee(
        url: 'https://coffee.com/123.png',
        image: File('data/123.png'),
      );
      coffeeRepository = MockCoffeeRepository();
      cubit = CoffeeCubit(coffeeRepository);
    });

    test('initial state is correct', () {
      expect(cubit.state, CoffeeInitialState());
    });

    group('getRandomCoffee', () {
      blocTest<CoffeeCubit, CoffeeState>(
        'calls getRandomCoffeeImage',
        build: () => cubit,
        act: (cubit) {
          when(coffeeRepository.getRandomCoffee)
              .thenAnswer((_) async => coffee);
          cubit.getRandomCoffee();
        },
        verify: (_) => verify(coffeeRepository.getRandomCoffee).called(1),
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'emits [loading, success] when getRandomCoffeeImage returns a coffee',
        build: () => cubit,
        act: (cubit) {
          when(coffeeRepository.getRandomCoffee)
              .thenAnswer((_) async => coffee);
          cubit.getRandomCoffee();
        },
        expect: () => [
          isA<CoffeeLoadingState>(),
          CoffeeSuccessState(coffee: coffee),
        ],
      );

      blocTest<CoffeeCubit, CoffeeState>(
        'emits [loading, error] when getRandomCoffeeImage throws exception',
        build: () => cubit,
        act: (cubit) {
          when(coffeeRepository.getRandomCoffee).thenThrow(Exception());
          cubit.getRandomCoffee();
        },
        expect: () => [
          isA<CoffeeLoadingState>(),
          isA<CoffeeFailureState>(),
        ],
      );
    });
  });
}
