import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coffee_state.dart';

class CoffeeCubit extends Cubit<CoffeeState> {
  CoffeeCubit(this._coffeeRepository) : super(CoffeeInitialState());

  final CoffeeRepository _coffeeRepository;

  Future<void> getRandomCoffee() async {
    emit(CoffeeLoadingState());

    try {
      final coffee = await _coffeeRepository.getRandomCoffee();
      emit(
        CoffeeSuccessState(
          coffee: coffee,
        ),
      );
    } on Exception {
      emit(CoffeeFailureState());
    }
  }
}
