import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/coffee/widgets/widgets.dart';
import 'package:coffee/src/favourite/view/favourite_page.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CoffeeCubit>(
      create: (context) => CoffeeCubit(context.read<CoffeeRepository>()),
      child: const CoffeeView(),
    );
  }
}

class CoffeeView extends StatelessWidget {
  const CoffeeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coffee App️'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.pushNamed(
              context,
              FavouritePage.routeName,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<CoffeeCubit, CoffeeState>(
            builder: (context, state) {
              if (state is CoffeeInitialState) {
                return const CoffeeInitial();
              } else if (state is CoffeeLoadingState) {
                return const CoffeeLoading();
              } else if (state is CoffeeSuccessState) {
                return CoffeeImage(coffee: state.coffee);
              }

              return const CoffeeError();
            },
          ),
        ),
      ),
    );
  }
}
