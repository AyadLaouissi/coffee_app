import 'package:flutter/material.dart';

class FavouriteEmpty extends StatelessWidget {
  const FavouriteEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('☕', style: TextStyle(fontSize: 35)),
        Text(
          'There are no favourite coffees',
          style: theme.textTheme.headline5,
        ),
      ],
    );
  }
}
