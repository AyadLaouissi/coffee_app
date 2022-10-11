import 'dart:io';

import 'package:coffee/src/favourite/cubit/favourite_cubit.dart';
import 'package:coffee/src/favourite/widgets/favourite_item.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../coffee/view/coffee_page_test.dart';
import '../../coffee/widgets/coffee_image_test.dart';

void main() {
  group('FavouriteItem', () {
    late Widget widget;
    late Coffee coffee;
    late FavouriteCubit favouriteCubit;

    setUpAll(() {
      registerFallbackValue(FakeCoffee());
    });

    setUp(() {
      coffee = Coffee(
        url: 'https://coffee.es/123.png',
        image: File('/data/123.png'),
      );
      favouriteCubit = MockFavouriteCubit();
      widget = BlocProvider.value(
        value: favouriteCubit,
        child: MaterialApp(
          home: FavouriteItem(coffee: coffee),
        ),
      );
    });

    testWidgets('render correct image and icon', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);
    });

    testWidgets('icon pressed calls removeCoffee', (tester) async {
      when(() => favouriteCubit.removeCoffee(any()))
          .thenAnswer((_) async => {});
      await tester.pumpWidget(widget);
      await tester.tap(find.byIcon(Icons.delete));
      verify(() => favouriteCubit.removeCoffee(coffee)).called(1);
    });
  });
}
