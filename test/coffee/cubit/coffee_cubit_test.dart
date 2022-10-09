import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  group('CoffeeCubit', () {
    late CoffeeCubit cubit;
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
      cubit = CoffeeCubit(coffeeRepository);
    });
  });
}
