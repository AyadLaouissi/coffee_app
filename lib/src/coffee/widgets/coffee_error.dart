import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoffeeError extends StatelessWidget {
  const CoffeeError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Something went wrong!',
          style: theme.textTheme.headline5,
        ),
        ElevatedButton(
          onPressed: context.read<CoffeeCubit>().getRandomImage,
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
