part of 'coffee_cubit.dart';

abstract class CoffeeState extends Equatable {
  const CoffeeState();

  @override
  List<Object?> get props => [];
}

class CoffeeInitialState extends CoffeeState {}

class CoffeeLoadingState extends CoffeeState {}

class CoffeeSuccessState extends CoffeeState {
  const CoffeeSuccessState({
    required this.coffee,
  });

  final Coffee coffee;

  @override
  List<Object?> get props => [coffee];
}

class CoffeeFailureState extends CoffeeState {}
