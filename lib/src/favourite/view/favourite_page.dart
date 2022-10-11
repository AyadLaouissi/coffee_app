import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee/src/favourite/widgets/favourite_empty.dart';
import 'package:coffee/src/favourite/widgets/favourite_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  static const routeName = '/favourite_coffee';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites️️'),
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              if (state.coffees.isEmpty) {
                return const FavouriteEmpty();
              }

              return PageView.builder(
                itemCount: state.coffees.length,
                itemBuilder: (context, index) {
                  final coffee = state.coffees[index];

                  return FavouriteItem(
                    coffee: coffee,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
