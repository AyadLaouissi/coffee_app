import 'dart:io';

import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/coffee/widgets/coffee_image.dart';
import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../view/coffee_page_test.dart';

class FakeCoffee extends Fake implements Coffee {}

void main() {
  group('CoffeeImage', () {
    late Widget widget;
    late CoffeeCubit coffeeCubit;
    late FavouriteCubit favouriteCubit;
    late Coffee coffee;

    setUpAll(() {
      registerFallbackValue(FakeCoffee());
    });

    setUp(() {
      coffee = Coffee(
        url: 'https://coffee.com/123.png',
        image: File('data/123.png'),
      );
      coffeeCubit = MockCoffeeCubit();
      favouriteCubit = MockFavouriteCubit();
      widget = MultiBlocProvider(
        providers: [
          BlocProvider.value(value: coffeeCubit),
          BlocProvider.value(value: favouriteCubit),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: CoffeeImage(coffee: coffee),
          ),
        ),
      );
      when(() => favouriteCubit.state).thenReturn(FavouriteState());
    });

    testWidgets('render correct image, button and icon', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('Another Coffee'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('loads a new image when button is pressed', (tester) async {
      when(coffeeCubit.getRandomCoffee).thenAnswer((_) async => {});
      await tester.pumpWidget(widget);
      await tester.tap(find.text('Another Coffee'));
      verify(coffeeCubit.getRandomCoffee).called(1);
    });

    testWidgets('render icon favorite_border when the favourite is empty',
        (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets(
        'render icon favorite_border when the favourite '
        'does not match the current coffee', (tester) async {
      when(() => favouriteCubit.state).thenReturn(
        FavouriteState(
          coffees: [
            Coffee(
              url: 'https://coffee.com/345.png',
              image: File('data/345.png'),
            ),
            Coffee(
              url: 'https://coffee.com/678.png',
              image: File('data/678.png'),
            ),
            Coffee(
              url: 'https://coffee.com/912.png',
              image: File('data/912.png'),
            ),
          ],
        ),
      );
      await tester.pumpWidget(widget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets(
        'render icon favorite when the favourite '
        'does not match the current coffee', (tester) async {
      when(() => favouriteCubit.state).thenReturn(
        FavouriteState(
          coffees: [
            Coffee(
              url: 'https://coffee.com/123.png',
              image: File('data/123.png'),
            ),
            Coffee(
              url: 'https://coffee.com/345.png',
              image: File('data/345.png'),
            ),
            Coffee(
              url: 'https://coffee.com/678.png',
              image: File('data/678.png'),
            ),
          ],
        ),
      );
      await tester.pumpWidget(widget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets(
        'calls removeCoffee the current coffee when the coffee is favourite '
        'and the icon is pressed', (tester) async {
      final removeCoffee = Coffee(
        url: 'https://coffee.com/123.png',
        image: File('data/123.png'),
      );
      when(() => favouriteCubit.removeCoffee(any()))
          .thenAnswer((_) async => {});
      when(() => favouriteCubit.state).thenReturn(
        FavouriteState(
          coffees: [
            removeCoffee,
            Coffee(
              url: 'https://coffee.com/345.png',
              image: File('data/345.png'),
            ),
            Coffee(
              url: 'https://coffee.com/678.png',
              image: File('data/678.png'),
            ),
          ],
        ),
      );
      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(Icons.favorite));
      verify(() => favouriteCubit.removeCoffee(removeCoffee)).called(1);
    });

    testWidgets(
        'calls addCoffee when the coffee is not favourite '
        'and the icon is pressed', (tester) async {
      when(() => favouriteCubit.addCoffee(coffee)).thenAnswer((_) async => {});
      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(Icons.favorite_border));
      verify(() => favouriteCubit.addCoffee(coffee)).called(1);
    });
  });
}
