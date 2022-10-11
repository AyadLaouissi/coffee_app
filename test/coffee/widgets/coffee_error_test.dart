import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/coffee/widgets/coffee_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../view/coffee_page_test.dart';

void main() {
  group('CoffeeError', () {
    late Widget widget;
    late CoffeeCubit coffeeCubit;

    setUp(() {
      coffeeCubit = MockCoffeeCubit();
      widget = BlocProvider.value(
        value: coffeeCubit,
        child: const MaterialApp(
          home: CoffeeError(),
        ),
      );
    });

    testWidgets('render correct text and retry button', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('Something went wrong!'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('calls getRandomImage when retry button is pressed',
        (tester) async {
      when(coffeeCubit.getRandomCoffee).thenAnswer((_) async => {});
      await tester.pumpWidget(widget);
      await tester.tap(find.text('Retry'));
      verify(coffeeCubit.getRandomCoffee).called(1);
    });
  });
}
