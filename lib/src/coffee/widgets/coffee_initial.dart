import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeInitial extends StatelessWidget {
  const CoffeeInitial({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to the coffee app!️',
          style: theme.textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: context.read<CoffeeCubit>().getRandomImage,
          child: const Text('Start'),
        ),
      ],
    );
  }
}
