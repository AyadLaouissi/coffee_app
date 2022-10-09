import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({
    super.key,
    required this.coffee,
  });

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Image.file(coffee.image),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: context.read<CoffeeCubit>().getRandomImage,
                child: const Text('Another Coffee'),
              ),
              BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {
                  final favourites = state.coffees;
                  final index = favourites
                      .indexWhere((element) => element.url == coffee.url);
                  final isFavourite = index >= 0;

                  return IconButton(
                    onPressed: () => !isFavourite
                        ? context.read<FavouriteCubit>().addCoffee(coffee)
                        : context
                            .read<FavouriteCubit>()
                            .removeCoffee(favourites[index]),
                    icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_border),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
