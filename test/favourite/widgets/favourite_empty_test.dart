import 'package:coffee/src/favourite/widgets/favourite_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavouriteEmpty', () {
    late Widget widget;

    setUp(() {
      widget = const MaterialApp(
        home: FavouriteEmpty(),
      );
    });

    testWidgets('render correct text', (tester) async {
      await tester.pumpWidget(widget);
      expect(find.text('☕'), findsOneWidget);
      expect(find.text('There are no favourite coffees'), findsOneWidget);
    });
  });
}
