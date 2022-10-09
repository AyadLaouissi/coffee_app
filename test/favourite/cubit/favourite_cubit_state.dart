import 'dart:io';

import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../coffee/cubit/coffee_cubit_test.dart';
import '../../helpers/hydrated_bloc.dart';

class MockFile extends Mock implements File {}

void main() {
  initHydratedStorage();

  group('FavouriteCubit', () {
    late File image;
    late FavouriteCubit cubit;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      image = MockFile();
      coffeeRepository = MockCoffeeRepository();
      cubit = FavouriteCubit(coffeeRepository);
    });

    test('initial state is correct', () {
      final weatherCubit = FavouriteCubit(coffeeRepository);
      expect(weatherCubit.state, FavouriteState());
    });
  });
}
