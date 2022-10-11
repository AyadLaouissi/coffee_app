// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee/src/coffee/cubit/coffee_cubit.dart';
import 'package:coffee/src/coffee/view/coffee_page.dart';
import 'package:coffee/src/coffee/widgets/widgets.dart';
import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

class MockCoffeeCubit extends MockCubit<CoffeeState> implements CoffeeCubit {}

class MockFavouriteCubit extends MockCubit<FavouriteState>
    implements FavouriteCubit {}

void main() {
  group('CoffeePage', () {
    late CoffeeRepository coffeeRepository;

    setUp(() {
      coffeeRepository = MockCoffeeRepository();
    });

    testWidgets('renders CoffeeView', (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: coffeeRepository,
          child: MaterialApp(
            home: CoffeePage(),
          ),
        ),
      );
      expect(find.byType(CoffeeView), findsOneWidget);
    });
  });

  group('CoffeeView', () {
    late CoffeeCubit coffeeCubit;
    late FavouriteCubit favouriteCubit;
    late Widget view;

    setUp(() {
      coffeeCubit = MockCoffeeCubit();
      favouriteCubit = MockFavouriteCubit();
      view = MultiBlocProvider(
        providers: [
          BlocProvider.value(value: coffeeCubit),
          BlocProvider.value(value: favouriteCubit),
        ],
        child: MaterialApp(
          home: CoffeeView(),
        ),
      );
      when(() => favouriteCubit.state).thenReturn(FavouriteState());
    });

    testWidgets('renders CoffeeInitial for CoffeeInitialState', (tester) async {
      when(() => coffeeCubit.state).thenReturn(CoffeeInitialState());
      await tester.pumpWidget(view);
      expect(find.byType(CoffeeInitial), findsOneWidget);
    });

    testWidgets('renders CoffeeError for CoffeeFailureState', (tester) async {
      when(() => coffeeCubit.state).thenReturn(CoffeeFailureState());
      await tester.pumpWidget(view);
      expect(find.byType(CoffeeError), findsOneWidget);
    });

    testWidgets('renders CoffeeLoading for CoffeeLoadingState', (tester) async {
      when(() => coffeeCubit.state).thenReturn(CoffeeLoadingState());
      await tester.pumpWidget(view);
      expect(find.byType(CoffeeLoading), findsOneWidget);
    });

    testWidgets('renders CoffeeImage for CoffeeSuccessState', (tester) async {
      when(() => coffeeCubit.state).thenReturn(
        CoffeeSuccessState(
          coffee: Coffee(
            url: 'https://coffee',
            image: File('/data/user/coffee.png'),
          ),
        ),
      );
      await tester.pumpWidget(view);
      expect(find.byType(CoffeeImage), findsOneWidget);
    });
  });
}
