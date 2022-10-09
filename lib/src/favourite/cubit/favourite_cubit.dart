import 'package:coffee_repository/coffee_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends HydratedCubit<FavouriteState> {
  FavouriteCubit(this._coffeeRepository) : super(FavouriteState());

  final CoffeeRepository _coffeeRepository;

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
        coffees: List.of(state.coffees)
          ..removeWhere(
            (coffeeElement) => coffeeElement.url == coffee.url,
          ),
      ),
    );
  }

  @override
  FavouriteState fromJson(Map<String, dynamic> json) =>
      FavouriteState.fromJson(json);

  @override
  Map<String, dynamic> toJson(FavouriteState state) => state.toJson();
}
