import 'dart:io';

import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee/src/favourite/view/favourite_page.dart';
import 'package:coffee/src/favourite/widgets/favourite_empty.dart';
import 'package:coffee/src/favourite/widgets/favourite_item.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../coffee/view/coffee_page_test.dart';

void main() {
  group('FavouritePage', () {
    late Widget widget;
    late FavouriteCubit favouriteCubit;

    setUp(() {
      favouriteCubit = MockFavouriteCubit();
      widget = BlocProvider.value(
        value: favouriteCubit,
        child: const MaterialApp(
          home: FavouritePage(),
        ),
      );
    });

    testWidgets('render FavouriteEmpty when there are no favourites',
        (tester) async {
      when(() => favouriteCubit.state).thenReturn(FavouriteState());
      await tester.pumpWidget(widget);
      expect(find.byType(FavouriteEmpty), findsOneWidget);
    });

    testWidgets('render FavouriteItem when there is a favourite coffee',
        (tester) async {
      when(() => favouriteCubit.state).thenReturn(
        FavouriteState(
          coffees: [
            Coffee(
              url: 'https://coffee.com/123.png',
              image: File('date/123.png'),
            ),
          ],
        ),
      );
      await tester.pumpWidget(widget);
      expect(find.byType(FavouriteItem), findsOneWidget);
    });

    testWidgets('PageView should have three favourite coffees', (tester) async {
      when(() => favouriteCubit.state).thenReturn(
        FavouriteState(
          coffees: [
            Coffee(
              url: 'https://coffee.com/123.png',
              image: File('date/123.png'),
            ),
            Coffee(
              url: 'https://coffee.com/456.png',
              image: File('date/456.png'),
            ),
            Coffee(
              url: 'https://coffee.com/789.png',
              image: File('date/789.png'),
            ),
          ],
        ),
      );
      await tester.pumpWidget(widget);
      final pageView = tester.widget<PageView>(find.byType(PageView));
      expect(pageView.childrenDelegate.estimatedChildCount, equals(3));
    });
  });
}
