import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteItem extends StatelessWidget {
  const FavouriteItem({
    super.key,
    required this.coffee,
  });

  final Coffee coffee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            child: Image.file(
              coffee.image,
            ),
          ),
          FloatingActionButton(
            onPressed: () =>
                context.read<FavouriteCubit>().removeCoffee(coffee),
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
