import 'dart:io';

import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends HydratedCubit<FavouriteState> {
  FavouriteCubit(
    this._coffeeRepository,
    this.directory,
  ) : super(FavouriteState());

  final CoffeeRepository _coffeeRepository;
  final Directory directory;

  Future<void> addCoffee(Coffee coffee) async {
    final image = await _coffeeRepository.saveCoffeeImage(coffee);
    emit(
      FavouriteState(
        coffees: List.of(state.coffees)
          ..add(
            coffee.copyWith(
              image: image,
            ),
          ),
      ),
    );
  }

  Future<void> removeCoffee(Coffee coffee) async {
    await _coffeeRepository.removeCoffeeImage(coffee);
    emit(
      FavouriteState(
        coffees: List.of(state.coffees)..remove(coffee),
      ),
    );
  }

  @override
  FavouriteState fromJson(Map<String, dynamic> json) => FavouriteState.fromJson(
        json,
        path: directory.path,
      );

  @override
  Map<String, dynamic> toJson(FavouriteState state) => state.toJson();
}
