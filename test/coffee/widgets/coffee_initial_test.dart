import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/coffee/widgets/coffee_initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../view/coffee_page_test.dart';

void main() {
  group('CoffeeInitial', () {
    late Widget widget;
    late CoffeeCubit coffeeCubit;

    setUp(() {
      coffeeCubit = MockCoffeeCubit();
      widget = BlocProvider.value(
        value: coffeeCubit,
        child: const MaterialApp(
          home: CoffeeInitial(),
        ),
      );
    });

    testWidgets('render correct text and retry button', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('Welcome to the coffee app!'), findsOneWidget);
      expect(find.text('Start'), findsOneWidget);
    });

    testWidgets('calls getRandomImage when retry button is pressed',
        (tester) async {
      when(coffeeCubit.getRandomCoffee).thenAnswer((_) async => {});
      await tester.pumpWidget(widget);
      await tester.tap(find.text('Start'));
      verify(coffeeCubit.getRandomCoffee).called(1);
    });
  });
}
